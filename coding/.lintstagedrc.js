/**
 * @filename: .lintstagedrc.js
 * @type {import('lint-staged').Configuration}
 */
export default {
  // -------------------------------------------------------
  // Common
  // -------------------------------------------------------
  '*.md': 'markdownlint-cli2',
  '*.{css,scss,less,js,jsx,ts,tsx,json,yml,yaml}': 'prettier --write',

  // -------------------------------------------------------
  // Javascript - Typescript
  // -------------------------------------------------------
  '{app,src}/**/*.{js,ts}': ['eslint --fix', 'tsc --noEmit'],

  // -------------------------------------------------------
  // PHP - Laravel
  // -------------------------------------------------------
  // '{app,src}/**/*.php': [
  //     'vendor/bin/pint',
  //     'vendor/bin/phpstan analyse --no-progress',
  // ],
  // 'routes/**/*.php': 'vendor/bin/pint',
};
