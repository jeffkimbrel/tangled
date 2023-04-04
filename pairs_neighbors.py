from itertools import product
from Bio.Seq import Seq
import sys

def make_kmers(k: int = 4) -> list:
   kmers = [''.join(i) for i in product(["A", "C", "G", "T"], repeat = k)]
   return(kmers)

def make_pairs(kmers: list, frames: list):
    """
    Translation of overlapping pairs, denoted as ABC with A (0 frame) and B (+1 frame), C (+2 frame)
    A = ACG..
    B = .CGT. 
    C = ..GTA
    """

    d = {}
    for kmer in kmers:
        
        max_kmer = len(kmer) - 3

        P = ""
        for frame in frames:
            try:
                if frame > max_kmer:
                    raise Exception
            except Exception:
                print(f"kmer isn't long enough to have frame \"{frame}\"")
                sys.exit()
            
            A = Seq(kmer[frame:frame+3]).translate()
            P = P + A

        d[P] = d.get(P, []) + [kmer]
        
    return(d)

if __name__ == "__main__":
    overlaps = make_pairs(make_kmers(k = 4), frames = [0, 1])
    neighbors = make_pairs(make_kmers(k = 5), frames = [0, 2])

    for pairs, kmers in sorted(overlaps.items()):
        print(f"OVERLAPS: {pairs}\t{kmers}")

#     # for pairs, kmers in sorted(neighbors.items()):
#     #     print(f"NEIGHBORS: {pairs}\t{kmers}")