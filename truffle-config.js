require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },

    sepolia: {
      provider: () =>
        new HDWalletProvider({
          privateKeys: [process.env.PRIVATE_KEY], // tu clave privada sin "0x"
          providerOrUrl: `https://sepolia.infura.io/v3/${process.env.INFURA_KEY}`
        }),
      network_id: 11155111,     // ID de Sepolia
      gas: 5500000,             // Gas máximo a usar
      confirmations: 2,         // Confirmaciones antes de dar por hecho el deployment
      timeoutBlocks: 200,       // Tiempo de espera
      skipDryRun: true          // No simula antes de publicar
    }
  },

  compilers: {
    solc: {
      version: "0.8.0"
    }
  }
};
