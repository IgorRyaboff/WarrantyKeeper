﻿
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Элементы.СписокКонтекстноеМенюИзменитьДатуПометкиУдаления.Видимость = ОбщегоНазначенияКлиент.РежимОтладки();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ВосстановитьОбъект();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Восстановить(Команда)
	ВосстановитьОбъект();
КонецПроцедуры

&НаКлиенте
Асинх Процедура ИзменитьДатуПометкиУдаления(Команда)
	Ссылка = Элементы.Список.ТекущаяСтрока;
	Если Не ЗначениеЗаполнено(Ссылка) Тогда
		Возврат;
	КонецЕсли;
	
	Дата = Ждать ВвестиДатуАсинх(ТекущаяДата(), "Введите дату");
	Если Дата = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИзменитьДатуПометкиУдаленияНаСервере(Ссылка, Дата);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ИспользуетсяАвтоудалениеИстекших()
	Возврат Константы.АвтоматическиПеремещатьИстекшиеТалоныВКорзину.Получить();
КонецФункции

&НаКлиенте
Асинх Процедура ВосстановитьОбъект()
	Ссылка = Элементы.Список.ТекущаяСтрока;
	Если Не ЗначениеЗаполнено(Ссылка) Тогда
		Возврат;
	КонецЕсли;
	
	Если Элементы.Список.ТекущиеДанные.СрокГарантииИстек И ИспользуетсяАвтоудалениеИстекших() Тогда
		Текст = НСтр("ru='Невозможно восстановить талон, т.к. включено автоматическое перемещение истекших талонов в Корзину'");
		ПоказатьПредупреждение(, Текст);
		Возврат;
	КонецЕсли;
	
	ТекстВопроса = НСтр("ru='Восстановить объект из Корзины?'");
	Ответ = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	СнятьПометкуУдаленияЭлемента(Ссылка);
	ОповеститьОбИзменении(Ссылка);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СнятьПометкуУдаленияЭлемента(Знач Ссылка)
	Объект = Ссылка.ПолучитьОбъект();
	Объект.УстановитьПометкуУдаления(Ложь);
	Объект.Записать();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ИзменитьДатуПометкиУдаленияНаСервере(Знач Ссылка, Знач Дата)
	Объект = Ссылка.ПолучитьОбъект();
	Объект.ДатаПометкиУдаления = Дата;
	Объект.Записать();
КонецПроцедуры

#КонецОбласти
