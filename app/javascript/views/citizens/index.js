document.addEventListener('DOMContentLoaded', () => {
    const filterForm = document.getElementById('filter-form')
    if (filterForm) {
        filterForm.addEventListener('submit', handleFormSubmit)
    }

    const resetButton = document.getElementById('reset-button')
    if (resetButton) {
        resetButton.addEventListener('click', clearQueryParamsAndReload)
    }

    const zipCodeField = document.getElementById('address_zip_code')
    zipCodeField.addEventListener('change', () => {
        const zipCode = zipCodeField.value
        console.log('hello')
        console.log(zipCode)

        if (zipCode.length === 8) {
            fetch(`https://app.zipcodebase.com/api/v1/search?codes=${zipCode}&apikey=63750c50-88b2-11ee-a503-87b46622915b`)
                .then(response => response.json())
                .then(data => {
                    console.log(JSON.stringify(data))
                    const addressInfo = data.results[zipCode][0]
                    document.getElementById('address_street').value = addressInfo.province // 'province' seems to be the street info
                    document.getElementById('address_neighborhood').value = addressInfo.city // 'city' is being used for neighborhood
                    document.getElementById('address_city').value = addressInfo.city_en // City in English
                    document.getElementById('address_state').value = addressInfo.state_en // State in English
                    document.getElementById('address_ibge_code').value = addressInfo.province_code // IBGE code
                })
                .catch(error => console.error('Error:', error))
        }
    })
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
