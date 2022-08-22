//
//  DataManager.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import Foundation

final class DataManager {
    
    static let data = DataManager()
    
    private init() {}
    
    enum Price: Int {
        case one = 1
        case two
        case thee
        case four
        case five
        case six
        case seven
        case eght
        case nine
        case ten
    }
    
    var questions = [Question(questionText: "Какого цвета была шапочка у девочки которая шла к бабушке через лес?", answers: ["A":"Фуксия","B": "Красная", "C": "Зеленая", "D": "Мокрый асфальт"], currentAnswer: "Красная", difficult: 1),
                     Question(questionText: "Сколько атомов водорода в химической формуле серной кислоты?", answers: ["A": "1", "B": "2", "C": "4", "D": "нет"], currentAnswer: "2", difficult: 2),
                     Question(questionText: "Чьи штаны равны на все стороны?", answers: ["A": "Архимедовы", "B": "Арбакайтевы", "C": "Пифагоровы", "D": "Любые"], currentAnswer: "Пифагоровы", difficult: 3),
                     Question(questionText: "Как звали принцессу из мультфильма Алладин", answers: ["A": "Жасмин", "B": "Света", "C": "Меляуша", "D": "Жанна"], currentAnswer: "Жасмин", difficult: 4),
                     Question(questionText: "Как звали первого космонавта в мире?", answers: ["A": "Павел", "B": "Егор", "C": "Николай", "D": "Юрий"], currentAnswer: "Юрий", difficult: 5),
                     Question(questionText: "Семью семь?", answers: ["A": "56", "B": "47", "C": "49", "D": "77"], currentAnswer: "49", difficult: 6),
                     Question(questionText: "Как называется война, проходившая с 1939 по 1945 год", answers: ["A": "Отечественная война", "B": "Первая мировая война", "C": "Великая Отечественная война", "D": "Вторая мировая война"], currentAnswer: "Вторая мировая война", difficult: 7),
                     Question(questionText: "Сколько существует космических скоростей?", answers: ["A": "7", "B": "2", "C": "1", "D": "3"], currentAnswer: "3", difficult: 8),
                     Question(questionText: "Как называлась первая орбитальная станция?", answers: ["A": "МКС", "B": "МИР", "C": "САЛЮТ", "D": "СОЮЗ"], currentAnswer: "САЛЮТ", difficult: 9),
                     Question(questionText: "Кто написал войну и мир?", answers: ["A": "А.Толстой", "B": "А.Пушкин", "C": "С.Есенин", "D": "Л.Толстой"], currentAnswer: "Л.Толстой", difficult: 10),
                     Question(questionText: "Из какого населенного пункта были самые известные среди детей музыканты", answers: ["A": "Йемен", "B": "Бремен", "C": "Москва", "D": "Брест"], currentAnswer: "Бремен", difficult: 1),
                     ]
}
