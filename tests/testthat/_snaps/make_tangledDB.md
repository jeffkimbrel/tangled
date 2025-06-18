# tangleDB snapshot looks correct

    Code
      make_tangledDB()
    Output
      # A tibble: 4,096 x 6
         diAA hexamer AA0  AA3  TOL  POL 
         <AA> <chr>   <AA> <AA> <AA> <AA>
       1 KK   AAAAAA  K    K    K    K   
       2 QK   CAAAAA  Q    K    K    K   
       3 EK   GAAAAA  E    K    K    K   
       4 *K   TAAAAA  *    K    K    K   
       5 TK   ACAAAA  T    K    Q    K   
       6 PK   CCAAAA  P    K    Q    K   
       7 AK   GCAAAA  A    K    Q    K   
       8 SK   TCAAAA  S    K    Q    K   
       9 RK   AGAAAA  R    K    E    K   
      10 RK   CGAAAA  R    K    E    K   
      # i 4,086 more rows

