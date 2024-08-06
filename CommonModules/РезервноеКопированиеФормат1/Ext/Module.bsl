﻿
#Область СлужебныеПроцедурыИФункции

Функция ДоступныеРезервныеКопии(Данные) Экспорт
	Копии = РезервноеКопирование.НоваяТаблицаРезервныхКопий();
	
	Для Каждого СведенияОКопии Из Данные.Копии Цикл
		СтрКопии = Копии.Добавить();
		ЗаполнитьЗначенияСвойств(СтрКопии, СведенияОКопии, "ИмяФайла, Дата");
	КонецЦикла;
	
	Возврат Копии;
КонецФункции

Функция СформироватьФайлДоступныхРезервныхКопий(ТаблицаКопий) Экспорт
	ДанныеФайла = Новый Структура("ВерсияФормата, Копии", 1, Новый Массив);
	
	Для Каждого СтрКопии Из ТаблицаКопий Цикл
		ДатаСтрокой = РезервноеКопирование.ДатаДляВыгрузкиВJSON(СтрКопии.Дата);
		СведенияОКопии = Новый Структура("ИмяФайла, Дата", СтрКопии.ИмяФайла, ДатаСтрокой);
		ДанныеФайла.Копии.Добавить(СведенияОКопии);
	КонецЦикла;
	
	Возврат ДанныеФайла;
КонецФункции

Функция СформироватьФайлМанифеста() Экспорт
	Возврат Новый Структура("ВерсияФормата", 1);
КонецФункции

Функция СформироватьФайлКонстант() Экспорт
	ВыгружаемыеКонстанты = "АвтоматическиПеремещатьИстекшиеТалоныВКорзину, СрокХраненияТалоновВКорзине";
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Константы.АвтоматическиПеремещатьИстекшиеТалоныВКорзину КАК АвтоматическиПеремещатьИстекшиеТалоныВКорзину,
		|	Константы.СрокХраненияТалоновВКорзине КАК СрокХраненияТалоновВКорзине
		|ИЗ
		|	Константы КАК Константы";
	
	РезультатЗапроса = Запрос.Выполнить();
	ЗначенияКонстант = РезультатЗапроса.Выгрузить()[0];
	
	Данные = Новый Структура(ВыгружаемыеКонстанты);
	ЗаполнитьЗначенияСвойств(Данные, ЗначенияКонстант);
	Возврат Данные;
КонецФункции

Функция ЗначенияКонстантИзКопии(Данные) Экспорт
	Возврат Данные;
КонецФункции

Функция ЗначенияРеквизитовГарантийногоТалона(Данные) Экспорт
	Результат = Новый Структура("Код, Наименование, ПометкаУдаления,
		|ДатаПокупки, СрокГарантии, Комментарий, ДатаПометкиУдаления");
	ЗаполнитьЗначенияСвойств(Результат, Данные);
	
	Результат.ДатаПокупки = Дата(Данные.ДатаПокупки);
	Результат.ДатаПометкиУдаления = Дата(Данные.ДатаПометкиУдаления);
	
	Возврат Результат;
КонецФункции

Функция СформироватьФайлГарантийногоТалона(Выборка) Экспорт
	Данные = Новый Структура("Код, Наименование, ПометкаУдаления,
		|ДатаПокупки, СрокГарантии, Комментарий, ДатаПометкиУдаления");
	
	ЗаполнитьЗначенияСвойств(Данные, Выборка);
	Данные.ДатаПокупки = РезервноеКопирование.ДатаДляВыгрузкиВJSON(Выборка.ДатаПокупки);
	Данные.ДатаПометкиУдаления = РезервноеКопирование.ДатаДляВыгрузкиВJSON(Выборка.ДатаПометкиУдаления);
	
	Возврат Данные;
КонецФункции

#КонецОбласти
