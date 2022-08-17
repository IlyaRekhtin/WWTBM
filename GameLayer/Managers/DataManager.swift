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
    
    let questions = [Question(question: "Какого цвета была шапочка у девочки которая шла к бабушке через лес?", answers: ["Фуксия", "Красная", "Зеленая", "Мокрый асфальт"], currentAnswer: "Красная", difficult: 1),
                     Question(question: "Сколько атомов водорода в химической формуле серной кислоты?", answers: ["1", "2", "4", "нет"], currentAnswer: "2", difficult: 2),
                     Question(question: "Чьи штаны равны на все стороны?", answers: ["Архимедовы", "Арбакайтевы", "Пифагоровы", "Любые"], currentAnswer: "Пифагоровы", difficult: 3),
                     Question(question: "Как звали принцессу из мультфильма Алладин", answers: ["Жасмин", "Света", "Меляуша", "Жанна"], currentAnswer: "Жасмин", difficult: 4),
                     Question(question: "Как звали первого космонавта в мире?", answers: ["Павел", "Егор", "Николай", "Юрий"], currentAnswer: "Юрий", difficult: 5),
                     Question(question: "Семью семь?", answers: ["56", "47", "49", "77"], currentAnswer: "49", difficult: 6),
                     Question(question: "Как называется война, проходившая с 1939 по 1945 год", answers: ["Отечественная война", "Первая мировая война", "Великая Отечественная война", "Вторая мировая война"], currentAnswer: "Вторая мировая война", difficult: 7),
                     Question(question: "Сколько существует космических скоростей?", answers: ["7", "2", "1", "3"], currentAnswer: "3", difficult: 8),
                     Question(question: "Как называлась первая орбитальная станция?", answers: ["МКС", "МИР", "ВОСХОД", "СОЮЗ"], currentAnswer: "МИР", difficult: 9),
                     Question(question: "Кто написал войну и мир?", answers: ["А.Толстой", "А.Пушкин", "С.Есенин", "Л.Толстой"], currentAnswer: "Л.Толстой", difficult: 10),
                     Question(question: "Из какого населенного пункта были самые известные среди детей музыканты", answers: ["Йемен", "Бремен", "Москва", "Брест"], currentAnswer: "Бремен", difficult: 1),
                     ]
}
