# basic run works right

    Code
      get_TuNs("AA", type = "df")
    Output
      # A tibble: 4 x 5
        diAA AA0  AA3  TOL  hexamers        
        <AA> <AA> <AA> <AA> <list>          
      1 AA   A    A    L    <tibble [4 x 2]>
      2 AA   A    A    P    <tibble [4 x 2]>
      3 AA   A    A    Q    <tibble [4 x 2]>
      4 AA   A    A    R    <tibble [4 x 2]>

---

    Code
      get_TuNs("AA", type = "vec")
    Output
      [1] "L" "P" "Q" "R"

