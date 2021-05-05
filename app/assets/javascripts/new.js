function addInputGroup() {
    let amount_line_order = parseInt(document.getElementById('item-list').getAttribute('data-amount-number-line-order'))
    let line_block = document.getElementById('line-order').cloneNode(true);
    let next_number_line = amount_line_order + 1
    line_block.setAttribute('data-number-line-order', next_number_line)
    document.getElementById('item-list').setAttribute('data-amount-number-line-order', next_number_line)
    for (let i = 0; i < line_block.children.length; i++) {
        line_block.children[i].value = '';
    }
    document.getElementById('item-list').appendChild(line_block)
}

function postData() {
    $.ajax({
        type: 'post',
        url: '/order',
        dataType: 'json',
        data: getDataOrder(),
        cache: false,
        remote: true,
        success: function (data) {
            console.log(data)
        }
    });
}


function getDataOrder() {
    let input_order_info = document.getElementById('base-info').querySelectorAll('input')
    let input_order_items = document.getElementById('item-list').querySelectorAll('#line-order')
    let data_json = {}

    for (let i=0;i<input_order_info.length;i++){
        data_json[input_order_info[i].getAttribute('name')] = input_order_info[i].value
    }
    data_json['ignore'] = document.querySelector('[name="ignore"]').checked

    for (let i=0;i<input_order_items.length;i++){
        let item_number = input_order_items[i].getAttribute('data-number-line-order')

        if (data_json['items'] == null && data_json['items'] != {}){
            data_json['items'] = {}

        }
                if (data_json['items'][item_number] == null && data_json['items'][item_number] != {}){
            data_json['items'][item_number] = {}

                }

        data_json['items'][item_number]['item_id'] = input_order_items[i].querySelector('#item_id').value
        data_json['items'][item_number]['amount'] = input_order_items[i].querySelector('#amount').value
    }
return data_json
}