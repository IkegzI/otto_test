
function postData() {
    $.ajax({
        type: 'post',
        url: '/order',
        dataType: 'json',
        data: getDataOrder(),
        cache: false,
        remote: true,
        success: function (data) {
            errorNotice(data);
        }
    });
}
// вывод предупреждений
function errorNotice(data) {
    if (document.getElementById('error-info') != null) {
        document.getElementById('error-info').remove()
    }
    let data_exist = (data != null)
    if (data_exist) {
        if (data['error'] != "no_error") {
            let div_element = elementCreate('div', 'error-info', '', '')
            let p_element = elementCreate('p', '', '', data['error'])
            div_element.appendChild(p_element)
            document.getElementById('head-page').appendChild(div_element)
        }
    }
}

//формирование хеша для post запроса
function getDataOrder() {
    let input_order_info = document.getElementById('base-info').querySelectorAll('input')
    let input_order_items = document.getElementById('item-list').querySelectorAll('#line-order')
    let data_json = {}

    for (let i = 0; i < input_order_info.length; i++) {
        data_json[input_order_info[i].getAttribute('name')] = input_order_info[i].value
    }
    data_json['ignore'] = document.querySelector('[name="ignore"]').checked

    for (let i = 0; i < input_order_items.length; i++) {
        let item_number = input_order_items[i].getAttribute('data-number-line-order')

        if (data_json['items'] == null && data_json['items'] != {}) {
            data_json['items'] = {}

        }
        if (data_json['items'][item_number] == null && data_json['items'][item_number] != {}) {
            data_json['items'][item_number] = {}

        }

        data_json['items'][item_number]['item_id'] = input_order_items[i].querySelector('#item_id').value
        data_json['items'][item_number]['amount'] = input_order_items[i].querySelector('#amount').value
    }
    return data_json
}