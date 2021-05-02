function addInputGroup() {

    var line_block = document.getElementById('line-order');

for (let i=0; i < line_block.children.length;i++){
    line_block.children[i].value = '';
}
    document.getElementById('item-list').appendChild(line_block)
}