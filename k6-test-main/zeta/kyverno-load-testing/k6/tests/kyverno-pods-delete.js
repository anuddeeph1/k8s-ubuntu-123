import http from 'k6/http';
import { check } from 'k6';
import { buildKubernetesBaseUrl, generatePod, getParamsWithAuth, getTestNamespace, randomString } from './util.js';

const baseUrl = buildKubernetesBaseUrl();
const namespace = getTestNamespace();

export const generatePodInsecure = (name = 'test', image = 'nginx') => {
  return {
    kind: 'Pod',
    apiVersion: 'v1',
    metadata: {
      name: name
    },
    spec: {
      containers: [
        {
          name: 'test',
          image,
          securityContext: {
          }
        }
      ],
    }
  }
}

function deletePod(podName, namespace, requestBody) {
  const params = getParamsWithAuth();
  params.headers['Content-Type'] = 'application/json';

  let url = `${baseUrl}/api/v1/namespaces/${namespace}/pods/${podName}`
  const deleteRes = http.del(url, JSON.stringify(requestBody), params);
  //console.log("Delete response " + deleteRes.status + " " + deleteRes.status_text);
  check(deleteRes, {
    'verify response code of DELETE is 200': r => r.status === 200
  });
}

export function setup() {
  let createdPods = [];
  for (var i = 0; i < 10; i++) {
    const podName = `test-` + i;
    const pod = generatePodInsecure(podName);
    pod.metadata.labels = {
      app: 'k6-test',
    }
  
    const params = getParamsWithAuth();
    params.headers['Content-Type'] = 'application/json';
    const createRes = http.post(`${baseUrl}/api/v1/namespaces/${namespace}/pods`, JSON.stringify(pod), params);
    if (createRes.status != 201) {
      throw new Error('unexpected response: ' + JSON.stringify(createRes));
    }

    createdPods.push(podName)
  }

  console.log("created " + createdPods.length + " pods in namesspace" + namespace)
  return {createdPods: createdPods};
}

export default function(data) {
  for (var i = 0; i < data.createdPods.length; i++) {
    deletePod(data.createdPods[i], namespace, {"propagationPolicy":"Background","dryRun":["All"]});
  }
}

export function teardown(data) {
  for (var i = 0; i < data.createdPods.length; i++) {
    deletePod(data.createdPods[i], namespace, {});
  }
}
