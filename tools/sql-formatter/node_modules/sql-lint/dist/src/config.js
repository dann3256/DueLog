"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.findConfiguration = exports.getConfiguration = exports.file = exports.fileLocal = void 0;
const fs = require("fs");
const os = require("os");
const path = require("path");
const process = require("process");
exports.fileLocal = ".sql-lint.json";
exports.file = `${os.homedir}/.config/sql-lint/config.json`;
function getConfiguration(config) {
    if (fs.existsSync(config)) {
        return JSON.parse(fs.readFileSync(config, "utf8"));
    }
    return null;
}
exports.getConfiguration = getConfiguration;
function findConfiguration() {
    let dir = process.cwd();
    while (dir !== "/") {
        const config = path.join(dir, exports.fileLocal);
        if (fs.existsSync(config)) {
            return JSON.parse(fs.readFileSync(config, "utf8"));
        }
        dir = path.dirname(dir);
    }
    if (fs.existsSync(exports.file)) {
        return JSON.parse(fs.readFileSync(exports.file, "utf8"));
    }
    return null;
}
exports.findConfiguration = findConfiguration;
//# sourceMappingURL=config.js.map