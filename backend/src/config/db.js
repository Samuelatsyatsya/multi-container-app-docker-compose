import 'dotenv/config';
import { Sequelize } from 'sequelize';
import AWS from 'aws-sdk';

const sequelizeOptions = {
  dialect: 'mysql',
  logging: process.env.NODE_ENV === 'development' ? console.log : false,
  pool: {
    max: 10,
    min: 0,
    acquire: 30000,
    idle: 10000
  },
  define: {
    timestamps: true,
    underscored: true,
    freezeTableName: true
  }
};

async function getDbCredentials(secretName) {
  AWS.config.update({ region: process.env.AWS_REGION || 'us-east-1' });
  const secretsManager = new AWS.SecretsManager();

  try {
    const data = await secretsManager.getSecretValue({ SecretId: secretName }).promise();

    if ('SecretString' in data) {
      return JSON.parse(data.SecretString);
    }

    throw new Error('Secret has no string value');
  } catch (error) {
    console.error('Error fetching database credentials:', error.message);
    throw error;
  }
}

function buildSequelizeFromEnv() {
  const requiredVars = ['DB_HOST', 'DB_USER', 'DB_NAME'];
  const missingVars = requiredVars.filter((key) => !process.env[key]);

  if (missingVars.length > 0) {
    throw new Error(`Missing required database env vars: ${missingVars.join(', ')}`);
  }

  return new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASSWORD || '',
    {
      ...sequelizeOptions,
      host: process.env.DB_HOST,
      port: Number(process.env.DB_PORT) || 3306
    }
  );
}

async function buildSequelizeFromSecret(secretName) {
  const creds = await getDbCredentials(secretName);

  return new Sequelize(
    creds.dbname,
    creds.username,
    creds.password,
    {
      ...sequelizeOptions,
      host: creds.host,
      port: Number(creds.port) || 3306
    }
  );
}

async function initializeSequelize() {
  const secretName = process.env.DB_SECRET_NAME;
  const sequelizeInstance = secretName
    ? await buildSequelizeFromSecret(secretName)
    : buildSequelizeFromEnv();

  try {
    await sequelizeInstance.authenticate();
    console.log('Database connection established successfully.');
    return sequelizeInstance;
  } catch (error) {
    console.error('Unable to connect to the database:', error.message);
    throw error;
  }
}

const sequelize = await initializeSequelize();

// Test connection function (what server.js needs)
export const testConnection = async () => {
  try {
    await sequelize.authenticate();
    console.log('Database connection test successful.');
    return true;
  } catch (error) {
    console.error('Database connection test failed:', error.message);
    return false;
  }
};

// Export for named imports
export { sequelize };

// Export as default for compatibility
export default sequelize;
