/**
 * Основной модуль юникома
 * (конструирует и возвращает неймспейс Юникома)
 *
 * @module Unicom
 */
define([], function() {
    var Unicom = window.Unicom || {},
        deepExtend = function(destination, source) {
            for (var property in source) {
                if (
                    source[property] &&
                    source[property].constructor &&
                    source[property].constructor === Object
                ) {
                    destination[property] = destination[property] || {};
                    deepExtend(destination[property], source[property]);
                } else {
                    destination[property] = source[property];
                }
            }
            return destination;
        };

    Unicom.deepExtend = deepExtend.bind(Unicom);

    // определение ширины скролла
    // использование - компенсировать ширину скролла, когда появляются модальные окна
    // для избегания прыжков контента из-за расширения вьюпорта
    Unicom.scrollWidth = 15;

    if (typeof document.addEventListener === 'function') {
        document.addEventListener('DOMContentLoaded', function() {
            var div = document.createElement('div');

            div.style.overflowY = 'scroll';
            div.style.width =  '50px';
            div.style.height = '50px';

            // при display:none размеры нельзя узнать
            // нужно, чтобы элемент был видим
            // visibility:hidden - можно, т.к. сохраняет геометрию
            div.style.visibility = 'hidden';

            document.body.appendChild(div);
            Unicom.scrollWidth = div.offsetWidth - div.clientWidth;
            document.body.removeChild(div);
        });
    }

    return Unicom;
});