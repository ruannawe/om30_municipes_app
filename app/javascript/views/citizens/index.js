document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('filter-form').addEventListener('submit', function (event) {
        event.preventDefault()

        const formData = new FormData(this)
        const searchParams = new URLSearchParams()

        for (const [key, value] of formData) {
            if (value.length > 0) {
                searchParams.append(key, value)
            }
        }

        window.location = this.action + '?' + searchParams.toString()
    })
})