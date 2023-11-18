document.addEventListener('DOMContentLoaded', () => {
    const filterForm = document.getElementById('filter-form')

    if (filterForm) {
        filterForm.addEventListener('submit', handleFormSubmit)
    }
})

const handleFormSubmit = event => {
    event.preventDefault()
    const formElement = event.currentTarget
    const formData = new FormData(formElement)
    const queryString = buildQueryString(formData)

    redirectToFilteredUrl(formElement.action, queryString)
}

const buildQueryString = formData => {
    const searchParams = new URLSearchParams()

    for (const [key, value] of formData) {
        if (value.length > 0) {
            searchParams.append(key, value)
        }
    }
    return searchParams.toString()
}

const redirectToFilteredUrl = (action, queryString) => {
    window.location = action + '?' + queryString
}
