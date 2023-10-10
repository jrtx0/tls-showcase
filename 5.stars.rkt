#lang racket

(define (atom? n)
  (and (not (pair? n)) (not (null? n))))

; rember*: symbol list -> list
(define rember*
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
            (rember* a (cdr l)))
         (else (cons (car l)
                 (rember* a (cdr l))))))
      (else (cons (rember* a (car l))
                  (rember* a (cdr l)))))))
; insertR*: symbol symbol list -> list
(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((eq? (car l) old)
            (cons old
              (cons new
                (insertR* new old
                  (cdr l)))))
          (else (cons (car l)
                  (insertR* new old
                    (cdr l))))))
      (else (cons (insertR* new old
                    (car l))
              (insertR* new old
                (cdr l)))))))

; occur*: symbol list -> number
(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
        (cond
          ((eq? (car l) a)
           (add1 (occur* a (cdr l))))
          (else (occur* a (cdr l)))))
      (else (+ (occur* a (car l))
               (occur* a (cdr l)))))))

; subst*: symbol symbol list -> list
(define subst*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
         (cond
           ((eq? (car l) old)
             (cons new (subst* new old (cdr l))))
           (else (cons (car l) (subst* new old (cdr l))))))
      (else (cons (subst* new old (car l)) (subst* new old (cdr l)))))))

; insertL*: symbol symbol list -> list
(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((eq? (car l) old)
            (cons new
              (cons old
                (insertL* new old
                  (cdr l)))))
          (else (cons (car l)
                  (insertL* new old
                    (cdr l))))))
      (else (cons (insertL* new old
                    (car l))
              (insertL* new old
                (cdr l)))))))

; member*: symbol list -> bool
(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (or (eq? (car l) a)
            (member* a (cdr l))))
      (else (or (member* a (car l))
                (member* a (cdr l)))))))

; leftmost: list -> symbol
(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))

; eqan? symbol symbol -> bool
(define eqan?
  (lambda (a1 a2)
    (cond
     ((and (number? a1) (number? a2))
      (= a1 a2))
     ((or (number? a1) (number? a2))
      #f)
     (else (eq? a1 a2)))))

;(define eqlist?
;  (lambda (l1 l2)
;    (cond
;      ((and (null? l1) (null? l2)) #t)
;      ((and (null? l1) (atom? (car l2)))
;       #f)
;      ((null? l1) #f)
;      ((and (atom? (car l1)) (null? l2))
;       #f)
;      ((and (atom? (car l1)) (atom? (car l2)))
;       (and (eqan? (car l1) (car l2))
;            (eqlist? (cdr l1) (cdr l2))))
;      ((atom? (car l1)) #f)
;      ((null? l2) #f)
;      ((atom? (car l2)) #f)
;      (else
;       (and (eqlist? (car l1) (car l2))
;            (eqlist? (cdr l1) (cdr l2)))))))

;(define eqlist?
;  (lambda (l1 l2)
;    (cond
;      ((and (null? l1) (null? l2)) #t)
;      ((or (null? l1) (null? l2)) #f)
;      ((and (atom? (car l1))
;            (atom? (car l2)))
;       (and (eqan? (car l1) (car l2))
;            (eqlist? (cdr l1) (cdr l2))))
;       ((or (atom? (car l1))
;            (atom? (car l2)))
;        #f)
;       (else
;        (and (eqlist? (car l1) (car l2))
;             (eqlist? (cdr l1) (cdr l2)))))))

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2))
       (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))

; eqlist?: list list -> bool
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else
       (and (equal? (car l1) (car l2))
            (eqlist? (cdr l1) (cdr l2)))))))

; rember: symbol list -> list
(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote ()))
      ((equal? (car l) s) (cdr l))
      (else (cons (car l)
                  (rember s (cdr l)))))))