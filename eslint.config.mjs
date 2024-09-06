import globals from 'globals'
import pluginJs from '@eslint/js'

export default [
  {
    ignores: ['vendor/**'],
    languageOptions: {
      globals: {
        ...globals.node,
      },
    sourceType: 'module',
    },
  },

  pluginJs.configs.recommended,

  {
    files: ['**/*.js'],
    languageOptions: {
      sourceType: 'module',
    },
  },
]
