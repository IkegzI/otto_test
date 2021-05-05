//функция elementCreate перенесена в application.js



$(document).ready(function () {
    $.ajax({
        type: 'get',
        url: '/order',
        dataType: 'json',
        cache: false,
        remote: true,
        success: function (data) {
            show_create(data);
        }
    });
})

function show_create(data) {
    for (let key in data) {

        let div_element = document.getElementById('list_order');
        let p_element = elementCreate('p', '', '', '', {'data-order-id': key})
        let span_element = document.createElement('span');


        // p_element.appendChild(elementCreate('span', '', 'order-theme', '&or;'));

        p_element.appendChild(elementCreate('span', '', 'order-theme', ('Заказ ' + data[key][0][0])));

        p_element.appendChild(elementCreate('span', '', 'order-theme', data[key][0][3]));


        p_element.appendChild(elementCreate('span', '', 'order-theme', data[key][0][4]));

        div_element.appendChild(p_element)

        p_element =elementCreate('p', '', 'item-list', '', {'data-order-id': data[key][0][0]});

        p_element.appendChild(elementCreate('span', '', 'order-item', 'Товар(id)'));

        p_element.appendChild(elementCreate('span', '', 'order-item', 'Кол-во'));

        div_element.appendChild(p_element)


        for (let i = 0; i < data[key].length; i++) {
            p_element = elementCreate('p', '', 'item-list', '', {'data-order-id': data[key][i][0]});

            span_element = elementCreate('span', '', 'order-item', data[key][i][1])
            p_element.appendChild(span_element);

            span_element = elementCreate('span', '', 'order-item', data[key][i][2])

            p_element.appendChild(span_element);

            div_element.appendChild(p_element)
        }
    }
}