module.exports = {
    testEnvironment: "jsdom",
    setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
    moduleDirectories: ["node_modules"],
    roots: ["<rootDir>/js"],
    transform: {
      "^.+\\.jsx?$": "babel-jest",
    },
  };
