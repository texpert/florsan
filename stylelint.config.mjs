// stylelint.config.mjs
import { createRequire } from 'module';
const require = createRequire(import.meta.url);

// 1. Load the raw config object
const sassGuidelines = require('stylelint-config-sass-guidelines');

/** @type {import('stylelint').Config} */
export default {
    // 2. Spread the original config
    ...sassGuidelines,

    // 3. MANDATORY: Overwrite the internal strings with absolute PnP paths.
    // This prevents Stylelint from trying to find "stylelint-scss" by string.
    plugins: [
        require.resolve('stylelint-scss'),
        require.resolve('stylelint-order'),
        require.resolve('@stylistic/stylelint-plugin')
    ],

    // 4. Ensure the syntax parser is resolved
    customSyntax: require.resolve('postcss-scss'),

    rules: {
        ...sassGuidelines.rules,
        "font-family-no-missing-generic-family-keyword": [true],
        "max-nesting-depth": 2,
        "selector-no-qualifying-type": null,
        "selector-max-compound-selectors": 5,
        "selector-max-id": 2
    }
};
