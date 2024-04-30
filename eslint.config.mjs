import globals from "globals";
import js from "@eslint/js";

export default [
    { ignores: ["**/public/", ".pnp.cjs", ".pnp.loader.mjs"] },
    {
        languageOptions: {
            sourceType: "module",
            globals: {
                ...globals.browser,
            }
        }
    },
    js.configs.recommended,
    {
        files: ["**/*.js", "**/*.cjs"],
        rules: {
            "indent": ["error", 2],
            "linebreak-style": ["error", "unix"],
            "quotes": ["error", "single"],
            "semi": ["error", "never"],
            "no-unused-vars": "error"
        }
    },
];
