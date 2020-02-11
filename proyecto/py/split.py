import os

def create_files(foldername, srcpath):
    if not os.path.exists(foldername):
        os.mkdir(foldername)
    n = 0
    with open(srcpath) as fp:
        container = []
        for line in fp:
            container.append(line)
            if len(line) == 1 and container:  # "empty line" \n
                with open(os.path.join(foldername, f'{n}.sql'), 'w') as fw:
                    for x in container:
                        fw.write(x)
                container = []
                n += 1
    with open(f'{foldername}.tex', 'w') as fp:
        for i in range(n):
            fp.write('\inputminted')
            fp.write('{sql}')
            fp.write('{')
            fp.write(f'src/{foldername}/{i}.sql')
            fp.write('}\n')
            fp.write('\clearpage\n\n')

create_files('table', '../sql/db.sql')
create_files('restriccion', '../sql/restricciones.sql')
create_files('vista', '../sql/vistas.sql')
create_files('trigger', '../sql/triggers.sql')
