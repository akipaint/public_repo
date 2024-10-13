// module.exports = {
//     content: [
//       './app/views/**/*.html.erb',
//       './app/helpers/**/*.rb',
//       './app/javascript/**/*.js'
//     ],
//     // ... other Tailwind configurations ...
//   }
  /** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.css',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
