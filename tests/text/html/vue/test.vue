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
    el: '#test',
    components: {
        OtherComponent
    },
    props: {
        aProp:String,
        anotherProp:String,
    },
    data() {
        return {
            greeting: 'Hello'
        }
    },
    computed: {
        methodA() {},
        methodB() {},
    },
    watch: {
        propertyA() {},
        propertyB: {
            handler() {},
            deep: true,
        },
    },
    methods: {
        methodA() {},
        methodB() {},
    },
    render (h) {}
    renderError (h, err) {}

    // Assets
    directives: {}
    filters: {}
    mixins: {}
    extends: {}

    // Hooks
    beforeCreate () {}
    created () {}
    beforeMount () {}
    mounted () {}
    beforeUpdate () {}
    updated () {}
    activated () {}
    deactivated () {}
    beforeDestroy () {}
    destroyed () {}
    errorCaptured () {}
}
</script>

<style lang="stylus" scoped>
p
  font-size 2em
  text-align center
</style>
