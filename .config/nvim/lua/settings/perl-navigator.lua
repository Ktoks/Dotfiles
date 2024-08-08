return {
  settings = {
    perlnavigator = {
      perlPath = '/strawberry/perl/bin/perl'
    },
    perl = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
      analysis = {
        typeCheckingMode = "on",
      },
    },
  },
}
