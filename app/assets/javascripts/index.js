$(document).ready(function(){
   $.ajax({
        type: 'get',
        url: '/order/get_list',
        dataType: 'json',
        cache: false,
        remote: true,
        success: function (data) {
            show_create(data);
        }
    });
})

function  show_create(data) {
    for (let key in data){

        var div_element = document.getElementById('list_order');

        var p_element = document.createElement('p');
        p_element.setAttribute('id', data[key]['id']);

        var span_element = document.createElement('span');

        span_element = document.createElement('span');
        span_element.text =	'&or;';
        span_element.setAttribute('class', 'order-theme');
        p_element.appendChild(span_element);

        span_element = document.createElement('span');
        span_element.textContent = 'Заказ ' + data[key][0][0];
        span_element.setAttribute('class', 'order-theme');
        p_element.appendChild(span_element);

        span_element = document.createElement('span');
        span_element.textContent = data[key][0][3];
        span_element.setAttribute('class', 'order-theme');
        p_element.appendChild(span_element);

        span_element = document.createElement('span');
        span_element.textContent = data[key][0][4];
        span_element.setAttribute('class', 'order-theme');
        p_element.appendChild(span_element);

        div_element.appendChild(p_element)

        p_element = document.createElement('p');
        p_element.setAttribute('class', 'item-list')
        p_element.setAttribute('data-order-id', data[key][0][0])

        span_element = document.createElement('span');
        span_element.textContent = 'Товар(id)';
        span_element.setAttribute('class', 'order-item');
        p_element.appendChild(span_element);

        span_element = document.createElement('span');
        span_element.textContent = 'Кол-во';
        span_element.setAttribute('class', 'order-item');
        p_element.appendChild(span_element);
        div_element.appendChild(p_element)


        for (let i =0; i < data[key].length;i++){
            p_element = document.createElement('p');
            p_element.setAttribute('class', 'item-list')
            p_element.setAttribute('data-order-id', data[key][i][0])

            span_element = document.createElement('span');
            span_element.textContent = data[key][i][1];
            span_element.setAttribute('class', 'order-item');
            p_element.appendChild(span_element);

            span_element = document.createElement('span');
            span_element.textContent = data[key][i][2];
            span_element.setAttribute('class', 'order-item');
            p_element.appendChild(span_element);
            div_element.appendChild(p_element)
        }
    }
}