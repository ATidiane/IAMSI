(define (problem blockProblem)
        (:domain blockWorld)
        (:objects A B - block)
        (:init (clear B)
               (ontable A)
               (on B A)
               (handempty))
        (:goal (and (on A B) (handempty))))
        