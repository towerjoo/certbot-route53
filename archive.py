import os
from zipfile import ZipFile


ROOT = os.path.abspath(os.path.dirname(__file__))

domains = ["tradexport.com",
            "tradexport.cn",
            "zeno.group",
            "zeno-dev.com",
         ]

finalfiles = []
for domain in domains:
    folder = os.path.join(ROOT, "letsencrypt/archive/", domain)
    no = 1
    while True:
        name = "fullchain{}.pem".format(no)
        files = os.listdir(folder)
        if name not in files:
            no -= 1
            break
        no += 1
    fullchain = "fullchain{}.pem".format(no)
    privkey = "privkey{}.pem".format(no)
    finalfiles.append(
        {
            "name":"{}.fullchain".format(domain),
            "path": os.path.join(folder, fullchain),
        },
    )
    finalfiles.append(
        {
            "name": "{}.privkey".format(domain),
            "path": os.path.join(folder, privkey),
        }
    )
    
            
with ZipFile('certs.zip', 'w') as myzip:
    for f in finalfiles:
        myzip.write(f["path"], f["name"])
