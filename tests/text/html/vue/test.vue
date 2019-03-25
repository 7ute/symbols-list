<template lang="jade">
div
  p {{ greeting }} World!
  OtherComponent
</template>

<!-- ! Html comment -->
<script>

// ! Simple comment
/* ! Multiline comment */

import OtherComponent from './OtherComponent.vue'
export default {
  components: {
    OtherComponent
  },
  data () {
    return {
      greeting: 'Hello'
    }
  }
}
</script>

<style lang="stylus" scoped>
p
  font-size 2em
  text-align center
</style>
