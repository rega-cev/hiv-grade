import sys

fasta_file = sys.argv[1]

with open(fasta_file, "r") as fasta:
    is_first_line = True
    for line in fasta:
        #header
        if line.startswith('>'):
            if is_first_line:
                sys.stdout.write(line)
            else:
                sys.stdout.write('\n' + line)
        else:
            sys.stdout.write(line.strip('\n'))
        sys.stdout.flush()
        is_first_line = False 



