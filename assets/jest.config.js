module.exports = {
    testEnvironment: "jsdom",
    moduleDirectories: ["node_modules"],
    roots: ["<rootDir>/js"],
    transform: {
      "^.+\\.jsx?$": "babel-jest",
    },
  };
