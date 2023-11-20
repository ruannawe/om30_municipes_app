document.addEventListener('DOMContentLoaded', () => {
    const filterForm = document.getElementById('filter-form')
    if (filterForm) {
        filterForm.addEventListener('submit', handleFormSubmit)
    }

    const resetButton = document.getElementById('reset-button')
    if (resetButton) {
        resetButton.addEventListener('click', clearQueryParamsAndReload)
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

const clearQueryParamsAndReload = () => {
    const currentUrl = window.location.href;
    const baseUrl = currentUrl.includes('?') ? currentUrl.split('?')[0] : currentUrl;

    window.history.pushState({}, '', baseUrl);

    window.location.reload();
}
