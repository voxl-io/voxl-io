if Meteor.isClient
  Meteor.startup ->
    AccountsEntry.config
      homeRoute: '/'
      dashboardRoute: '/projects'
      profileRoute: 'profile'
      showSignupCode: yes
      showOtherLoginServices: no
      extraSignUpFields: [
        field: 'username'
        label: 'Username'
        placeholder: 'your-user-name'
        type: 'text'
        required: yes
      ]

if Meteor.isServer
  Meteor.startup ->
    AccountsEntry.config
      signupCode: 'beta'
