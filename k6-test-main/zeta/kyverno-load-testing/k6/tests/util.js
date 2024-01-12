export const options = {
  // Key configurations for avg load test in this section
  stages: [
    { duration: '5m', target: 20 }, // traffic ramp-up from 1 to 20 users over 5 minutes.
    { duration: '10m', target: 100 }, // stay at 100 users for 30 minutes
    { duration: '5m', target: 0 }, // ramp-down to 0 users
  ],
}

export const generatePod = (name = 'test', image = 'nginx') => {
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
	    allowPrivilegeEscalation: false
          }
        }
      ],
    }
  }
}

export const generateConfigmap = (name = 'test') => {
  return {
    kind: "ConfigMap",
    apiVersion: "v1",
    metadata: {
      name: name
    }
  }
}

export const generateSecret = (name = 'test') => {
  return {
    kind: "Secret",
    apiVersion: "v1",
    metadata: {
      name: name
    }
  }
}

export const buildKubernetesBaseUrl = () => {
  return `https://${__ENV.KUBERNETES_SERVICE_HOST}:${__ENV.KUBERNETES_SERVICE_PORT}`;
}

export const getTestNamespace = () => {
  return __ENV.POD_NAMESPACE;
}

export const getParamsWithAuth = () => {
  return {
    headers: {
      'Authorization': `Bearer ${__ENV.KUBERNETES_TOKEN}`
    }
  }
}

export const randomString = (length) => {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  const charactersLength = characters.length;
  let result = '';
  let counter = 0;
  while (counter < length) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
    counter += 1;
  }
  return result;
}
