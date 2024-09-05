import globals from 'globals'
import pluginJs from '@eslint/js'

export default [
  {
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
      sourceType: 'module', // ES Modulesを使用
    },
  },
]
