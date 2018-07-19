From: Will Zhao <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ceph rdma + IB network error
Date: Thu, 19 Jul 2018 10:16:34 +0800
Message-ID: <CAGOEmcO3r2phKT7QFxxK8AcQdDn-NT=c2YHvcjCRXXZ05oaEZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7367998815734842394=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============7367998815734842394==
Content-Type: multipart/alternative; boundary="0000000000006a59b8057150c57e"

--0000000000006a59b8057150c57e
Content-Type: text/plain; charset="UTF-8"

Hi all:



By following the instructions:

(https://community.mellanox.com/docs/DOC-2721)

(https://community.mellanox.com/docs/DOC-2693)

(http://hwchiu.com/2017-05-03-ceph-with-rdma.html)



I'm trying to configure CEPH with RDMA feature on environments as follows:



CentOS Linux release 7.2.1511 (Core)

MLNX_OFED_LINUX-4.4-1.0.0.0:

Mellanox Technologies MT27500 Family [ConnectX-3]



rping works between all nodes and add these lines to ceph.conf to enable
RDMA:



public_network = 10.10.121.0/24

cluster_network = 10.10.121.0/24

ms_type = async+rdma

ms_async_rdma_device_name = mlx4_0

ms_async_rdma_port_num = 2



IB network is using 10.10.121.0/24 addresses and "ibdev2netdev" command
shows port 2 is up.

Error occurs when running "ceph-deploy --overwrite-conf mon
create-initial", ceph-deploy log details:



[2018-07-12 17:53:48,943][ceph_deploy.conf][DEBUG ] found configuration
file at: /home/user1/.cephdeploy.conf

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ] Invoked (1.5.37):
/usr/bin/ceph-deploy --overwrite-conf mon create-initial

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ] ceph-deploy options:

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ]
username                      : None

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ]
verbose                       : False

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ]
overwrite_conf                : True

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ]
subcommand                    : create-initial

[2018-07-12 17:53:48,944][ceph_deploy.cli][INFO  ]  quiet
              : False

[2018-07-12 17:53:48,945][ceph_deploy.cli][INFO  ]
cd_conf                       : <ceph_deploy.conf.cephdeploy.Conf object at
0x27e6210>

[2018-07-12 17:53:48,945][ceph_deploy.cli][INFO  ]
cluster                       : ceph

[2018-07-12 17:53:48,945][ceph_deploy.cli][INFO  ]
func                          : <function mon at 0x2a7d2a8>

[2018-07-12 17:53:48,945][ceph_deploy.cli][INFO  ]
ceph_conf                     : None

[2018-07-12 17:53:48,945][ceph_deploy.cli][INFO  ]
default_release               : False

[2018-07-12 17:53:48,945][ceph_deploy.cli][INFO  ]
keyrings                      : None

[2018-07-12 17:53:48,947][ceph_deploy.mon][DEBUG ] Deploying mon, cluster
ceph hosts node1

[2018-07-12 17:53:48,947][ceph_deploy.mon][DEBUG ] detecting platform for
host node1 ...

[2018-07-12 17:53:49,005][node1][DEBUG ] connection detected need for sudo

[2018-07-12 17:53:49,039][node1][DEBUG ] connected to host: node1

[2018-07-12 17:53:49,040][node1][DEBUG ] detect platform information from
remote host

[2018-07-12 17:53:49,073][node1][DEBUG ] detect machine type

[2018-07-12 17:53:49,078][node1][DEBUG ] find the location of an executable

[2018-07-12 17:53:49,079][ceph_deploy.mon][INFO  ] distro info: CentOS
Linux 7.2.1511 Core

[2018-07-12 17:53:49,079][node1][DEBUG ] determining if provided host has
same hostname in remote

[2018-07-12 17:53:49,079][node1][DEBUG ] get remote short hostname

[2018-07-12 17:53:49,080][node1][DEBUG ] deploying mon to node1

[2018-07-12 17:53:49,080][node1][DEBUG ] get remote short hostname

[2018-07-12 17:53:49,081][node1][DEBUG ] remote hostname: node1

[2018-07-12 17:53:49,083][node1][DEBUG ] write cluster configuration to
/etc/ceph/{cluster}.conf

[2018-07-12 17:53:49,084][node1][DEBUG ] create the mon path if it does not
exist

[2018-07-12 17:53:49,085][node1][DEBUG ] checking for done path:
/var/lib/ceph/mon/ceph-node1/done

[2018-07-12 17:53:49,085][node1][DEBUG ] create a done file to avoid
re-doing the mon deployment

[2018-07-12 17:53:49,086][node1][DEBUG ] create the init path if it does
not exist

[2018-07-12 17:53:49,089][node1][INFO  ] Running command: sudo systemctl
enable ceph.target

[2018-07-12 17:53:49,365][node1][INFO  ] Running command: sudo systemctl
enable ceph-mon@node1

[2018-07-12 17:53:49,588][node1][INFO  ] Running command: sudo systemctl
start ceph-mon@node1

[2018-07-12 17:53:51,762][node1][INFO  ] Running command: sudo ceph
--cluster=ceph --admin-daemon /var/run/ceph/ceph-mon.node1.asok mon_status

[2018-07-12 17:53:51,979][node1][DEBUG ]
********************************************************************************

[2018-07-12 17:53:51,979][node1][DEBUG ] status for monitor: mon.node1

[2018-07-12 17:53:51,980][node1][DEBUG ] {

[2018-07-12 17:53:51,980][node1][DEBUG ]   "election_epoch": 3,

[2018-07-12 17:53:51,980][node1][DEBUG ]   "extra_probe_peers": [],

[2018-07-12 17:53:51,980][node1][DEBUG ]   "feature_map": {

[2018-07-12 17:53:51,981][node1][DEBUG ]     "mon": {

[2018-07-12 17:53:51,981][node1][DEBUG ]       "group": {

[2018-07-12 17:53:51,981][node1][DEBUG ]         "features":
"0x1ffddff8eea4fffb",

[2018-07-12 17:53:51,981][node1][DEBUG ]         "num": 1,

[2018-07-12 17:53:51,981][node1][DEBUG ]         "release": "luminous"

[2018-07-12 17:53:51,981][node1][DEBUG ]       }

[2018-07-12 17:53:51,981][node1][DEBUG ]     }

[2018-07-12 17:53:51,982][node1][DEBUG ]   },

[2018-07-12 17:53:51,982][node1][DEBUG ]   "features": {

[2018-07-12 17:53:51,982][node1][DEBUG ]     "quorum_con":
"2305244844532236283",

[2018-07-12 17:53:51,982][node1][DEBUG ]     "quorum_mon": [

[2018-07-12 17:53:51,982][node1][DEBUG ]       "kraken",

[2018-07-12 17:53:51,982][node1][DEBUG ]       "luminous"

[2018-07-12 17:53:51,982][node1][DEBUG ]     ],

[2018-07-12 17:53:51,982][node1][DEBUG ]     "required_con":
"153140804152475648",

[2018-07-12 17:53:51,983][node1][DEBUG ]     "required_mon": [

[2018-07-12 17:53:51,983][node1][DEBUG ]       "kraken",

[2018-07-12 17:53:51,983][node1][DEBUG ]       "luminous"

[2018-07-12 17:53:51,983][node1][DEBUG ]     ]

[2018-07-12 17:53:51,983][node1][DEBUG ]   },

[2018-07-12 17:53:51,983][node1][DEBUG ]   "monmap": {

[2018-07-12 17:53:51,983][node1][DEBUG ]     "created": "2018-07-12
17:41:24.243749",

[2018-07-12 17:53:51,984][node1][DEBUG ]     "epoch": 1,

[2018-07-12 17:53:51,984][node1][DEBUG ]     "features": {

[2018-07-12 17:53:51,984][node1][DEBUG ]       "optional": [],

[2018-07-12 17:53:51,984][node1][DEBUG ]       "persistent": [

[2018-07-12 17:53:51,984][node1][DEBUG ]         "kraken",

[2018-07-12 17:53:51,984][node1][DEBUG ]         "luminous"

[2018-07-12 17:53:51,984][node1][DEBUG ]       ]

[2018-07-12 17:53:51,984][node1][DEBUG ]     },

[2018-07-12 17:53:51,985][node1][DEBUG ]     "fsid":
"9317bc6a-ea20-4376-a390-52afa0b81353",

[2018-07-12 17:53:51,985][node1][DEBUG ]     "modified": "2018-07-12
17:41:24.243749",

[2018-07-12 17:53:51,985][node1][DEBUG ]     "mons": [

[2018-07-12 17:53:51,985][node1][DEBUG ]       {

[2018-07-12 17:53:51,985][node1][DEBUG ]         "addr": "
10.10.121.25:6789/0",

[2018-07-12 17:53:51,985][node1][DEBUG ]         "name": "node1",

[2018-07-12 17:53:51,985][node1][DEBUG ]         "public_addr": "
10.10.121.25:6789/0",

[2018-07-12 17:53:51,986][node1][DEBUG ]         "rank": 0

[2018-07-12 17:53:51,986][node1][DEBUG ]       }

[2018-07-12 17:53:51,986][node1][DEBUG ]     ]

[2018-07-12 17:53:51,986][node1][DEBUG ]   },

[2018-07-12 17:53:51,986][node1][DEBUG ]   "name": "node1",

[2018-07-12 17:53:51,986][node1][DEBUG ]   "outside_quorum": [],

[2018-07-12 17:53:51,986][node1][DEBUG ]   "quorum": [

[2018-07-12 17:53:51,986][node1][DEBUG ]     0

[2018-07-12 17:53:51,987][node1][DEBUG ]   ],

[2018-07-12 17:53:51,987][node1][DEBUG ]   "rank": 0,

[2018-07-12 17:53:51,987][node1][DEBUG ]   "state": "leader",

[2018-07-12 17:53:51,987][node1][DEBUG ]   "sync_provider": []

[2018-07-12 17:53:51,987][node1][DEBUG ] }

[2018-07-12 17:53:51,987][node1][DEBUG ]
********************************************************************************

[2018-07-12 17:53:51,987][node1][INFO  ] monitor: mon.node1 is running

[2018-07-12 17:53:51,989][node1][INFO  ] Running command: sudo ceph
--cluster=ceph --admin-daemon /var/run/ceph/ceph-mon.node1.asok mon_status

[2018-07-12 17:53:52,156][ceph_deploy.mon][INFO  ] processing monitor
mon.node1

[2018-07-12 17:53:52,194][node1][DEBUG ] connection detected need for sudo

[2018-07-12 17:53:52,230][node1][DEBUG ] connected to host: node1

[2018-07-12 17:53:52,231][node1][DEBUG ] detect platform information from
remote host

[2018-07-12 17:53:52,265][node1][DEBUG ] detect machine type

[2018-07-12 17:53:52,270][node1][DEBUG ] find the location of an executable

[2018-07-12 17:53:52,273][node1][INFO  ] Running command: sudo ceph
--cluster=ceph --admin-daemon /var/run/ceph/ceph-mon.node1.asok mon_status

[2018-07-12 17:53:52,439][ceph_deploy.mon][INFO  ] mon.node1 monitor has
reached quorum!

[2018-07-12 17:53:52,440][ceph_deploy.mon][INFO  ] all initial monitors are
running and have formed quorum

[2018-07-12 17:53:52,440][ceph_deploy.mon][INFO  ] Running gatherkeys...

[2018-07-12 17:53:52,441][ceph_deploy.gatherkeys][INFO  ] Storing keys in
temp directory /tmp/tmp8bdYT6

[2018-07-12 17:53:52,477][node1][DEBUG ] connection detected need for sudo

[2018-07-12 17:53:52,510][node1][DEBUG ] connected to host: node1

[2018-07-12 17:53:52,511][node1][DEBUG ] detect platform information from
remote host

[2018-07-12 17:53:52,552][node1][DEBUG ] detect machine type

[2018-07-12 17:53:52,558][node1][DEBUG ] get remote short hostname

[2018-07-12 17:53:52,559][node1][DEBUG ] fetch remote file

[2018-07-12 17:53:52,562][node1][INFO  ] Running command: sudo
/usr/bin/ceph --connect-timeout=25 --cluster=ceph
--admin-daemon=/var/run/ceph/ceph-mon.node1.asok mon_status

[2018-07-12 17:53:52,731][node1][INFO  ] Running command: sudo
/usr/bin/ceph --connect-timeout=25 --cluster=ceph --name mon.
--keyring=/var/lib/ceph/mon/ceph-node1/keyring auth get client.admin

[2018-07-12 17:54:18,059][node1][ERROR ] "ceph auth get-or-create for
keytype admin returned 1

[2018-07-12 17:54:18,059][node1][DEBUG ] Cluster connection interrupted or
timed out

[2018-07-12 17:54:18,059][node1][ERROR ] Failed to return 'admin' key from
host node1

[2018-07-12 17:54:18,059][ceph_deploy.gatherkeys][ERROR ] Failed to connect
to host:node1

[2018-07-12 17:54:18,060][ceph_deploy.gatherkeys][INFO  ] Destroy temp
directory /tmp/tmp8bdYT6

[2018-07-12 17:54:18,060][ceph_deploy][ERROR ] RuntimeError: Failed to
connect any mon



ceph-mon service is up but cannot be connected to reach, "ceph -s" also
returns same types of error:



2018-07-13 10:44:21.169536 7fa570d4e700  0 monclient(hunting): authenticate
timed out after 300

2018-07-13 10:44:21.169579 7fa570d4e700  0 librados: client.admin
authentication error (110) Connection timed out

[errno 110] error connecting to the cluster


I'am running the ceph version 12.2.4 luminous stable, anyone  has any
suggestion about this issue?



Thx

--0000000000006a59b8057150c57e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

















<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">Hi al=
l:=C2=A0<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">By fo=
llowing the instructions:<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">(<a h=
ref=3D"https://community.mellanox.com/docs/DOC-2721" style=3D"color:rgb(5,9=
9,193);text-decoration:underline">https://community.mellanox.com/docs/DOC-2=
721</a>)<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">(<a h=
ref=3D"https://community.mellanox.com/docs/DOC-2693" style=3D"color:rgb(5,9=
9,193);text-decoration:underline">https://community.mellanox.com/docs/DOC-2=
693</a>)<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">(<a h=
ref=3D"http://hwchiu.com/2017-05-03-ceph-with-rdma.html" style=3D"color:rgb=
(5,99,193);text-decoration:underline">http://hwchiu.com/2017-05-03-ceph-wit=
h-rdma.html</a>)<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">I&#39=
;m trying to configure CEPH with RDMA
feature on environments as follows:<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">CentO=
S Linux release 7.2.1511 (Core)<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">MLNX_=
OFED_LINUX-4.4-1.0.0.0:<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">Mella=
nox Technologies MT27500 Family
[ConnectX-3]<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">rping=
 works between all nodes and add these
lines to ceph.conf to enable RDMA:<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">public_network =3D
<a href=3D"http://10.10.121.0/24">10.10.121.0/24</a><span></span></span></p=
>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">cluster_network =3D
<a href=3D"http://10.10.121.0/24">10.10.121.0/24</a><span></span></span></p=
>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">ms_type =3D async+rdma<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">ms_async_rdma_device_name
=3D mlx4_0<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">ms_async_rdma_port_num
=3D 2</span><span lang=3D"EN-US"><span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">IB ne=
twork is using <a href=3D"http://10.10.121.0/24">10.10.121.0/24</a>
addresses and &quot;ibdev2netdev&quot; command shows port 2 is up. <span></=
span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">Error=
 occurs when running &quot;ceph-deploy
--overwrite-conf mon create-initial&quot;, ceph-deploy log details:<span></=
span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,943][ceph_deploy.conf][DEBUG ] found configuration file at:
/home/user1/.cephdeploy.conf<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ] Invoked (1.5.37):
/usr/bin/ceph-deploy --overwrite-conf mon create-initial<span></span></span=
></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ] ceph-deploy options:<span></spa=
n></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0 username=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: None<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
verbose=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: False<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
overwrite_conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: True<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
subcommand=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: create-initial<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,944][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
quiet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0:
False<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,945][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
cd_conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: &lt;ceph_deploy.conf.cephdeploy.Conf object at 0x27e6210&gt;<span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,945][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
cluster=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: ceph<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,945][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
: &lt;function mon at 0x2a7d2a8&gt;<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,945][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
ceph_conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: None<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,945][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
default_release=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
: False<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,945][ceph_deploy.cli][INFO=C2=A0 ]=C2=A0
keyrings=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
: None<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12 17:53:48,947][ceph_deploy.mon][DEBU=
G
] Deploying mon, cluster ceph hosts node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:48,947][ceph_deploy.mon][DEBUG ] detecting platform for host node1 ..=
.<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,005][node1][DEBUG ] connection detected need for sudo<span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12 17:53:49,039][node1][DEBUG
] connected to host: node1 <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,040][node1][DEBUG ] detect platform information from remote host<s=
pan></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,073][node1][DEBUG ] detect machine type<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,078][node1][DEBUG ] find the location of an executable<span></span=
></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,079][ceph_deploy.mon][INFO=C2=A0 ] distro info: CentOS Linux 7.2.1=
511
Core<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,079][node1][DEBUG ] determining if provided host has same hostname=
 in
remote<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,079][node1][DEBUG ] get remote short hostname<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,080][node1][DEBUG ] deploying mon to node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,080][node1][DEBUG ] get remote short hostname<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,081][node1][DEBUG ] remote hostname: node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,083][node1][DEBUG ] write cluster configuration to
/etc/ceph/{cluster}.conf<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,084][node1][DEBUG ] create the mon path if it does not exist<span>=
</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,085][node1][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph=
-node1/done<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,085][node1][DEBUG ] create a done file to avoid re-doing the mon
deployment<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,086][node1][DEBUG ] create the init path if it does not exist<span=
></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,089][node1][INFO=C2=A0 ] Running command: sudo systemctl enable
ceph.target<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,365][node1][INFO=C2=A0 ] Running command: sudo systemctl enable
ceph-mon@node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:49,588][node1][INFO=C2=A0 ] Running command: sudo systemctl start
ceph-mon@node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,762][node1][INFO=C2=A0 ] Running command: sudo ceph --cluster=3Dce=
ph
--admin-daemon /var/run/ceph/ceph-mon.node1.asok mon_status<span></span></s=
pan></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,979][node1][DEBUG ]
***************************************************************************=
*****<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12 17:53:51,979][node1][DEBUG
] status for monitor: mon.node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,980][node1][DEBUG ] {<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,980][node1][DEBUG ]=C2=A0=C2=A0 &quot;election_epoch&quot;: 3, <sp=
an></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,980][node1][DEBUG ]=C2=A0=C2=A0 &quot;extra_probe_peers&quot;: [],=
 <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,980][node1][DEBUG ]=C2=A0=C2=A0 &quot;feature_map&quot;: {<span></=
span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;mon&quot;: {<spa=
n></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;group&quot;: {<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;features&quot;: &quot;0x1ffddff8eea4fffb&quot;, <span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;num&quot;: 1, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;release&quot;: &quot;luminous&quot;<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<span></s=
pan></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,981][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 }<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0 }, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0 &quot;features&quot;: {<span></spa=
n></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;quorum_con&quot;=
:
&quot;2305244844532236283&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;quorum_mon&quot;=
: [<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;kraken&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;luminous&quot;<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 ], <span></span></span=
></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,982][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;required_con&quo=
t;:
&quot;153140804152475648&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;required_mon&quo=
t;:
[<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;kraken&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;luminous&quot;<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 ]<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0 }, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0 &quot;monmap&quot;: {<span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,983][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;created&quot;:
&quot;2018-07-12 17:41:24.243749&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;epoch&quot;: 1, =
<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;features&quot;: =
{<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;optional&quot;: [], <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&quot;persistent&quot;: [<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;kraken&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;luminous&quot;<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]<span></s=
pan></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,984][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 }, <span></span></span=
></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;fsid&quot;:
&quot;9317bc6a-ea20-4376-a390-52afa0b81353&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;modified&quot;:
&quot;2018-07-12 17:41:24.243749&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 &quot;mons&quot;: [<sp=
an></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<span></s=
pan></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;addr&quot;: &quot;<a href=3D"http://10.10.121.25:6789/0">10.10.121.25=
:6789/0</a>&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;name&quot;: &quot;node1&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,985][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;public_addr&quot;: &quot;<a href=3D"http://10.10.121.25:6789/0">10.10=
.121.25:6789/0</a>&quot;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
&quot;rank&quot;: 0<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<span></s=
pan></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 ]<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0 }, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0 &quot;name&quot;: &quot;node1&quot=
;, <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0 &quot;outside_quorum&quot;: [], <s=
pan></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0 &quot;quorum&quot;: [<span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,986][node1][DEBUG ]=C2=A0=C2=A0=C2=A0=C2=A0 0<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][DEBUG ]=C2=A0=C2=A0 ], <span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][DEBUG ]=C2=A0=C2=A0 &quot;rank&quot;: 0, <span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][DEBUG ]=C2=A0=C2=A0 &quot;state&quot;: &quot;leader&qu=
ot;,
<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][DEBUG ]=C2=A0=C2=A0 &quot;sync_provider&quot;: []<span=
></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][DEBUG ] }<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][DEBUG ]
***************************************************************************=
*****<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,987][node1][INFO=C2=A0 ] monitor: mon.node1 is running<span></span=
></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:51,989][node1][INFO=C2=A0 ] Running command: sudo ceph --cluster=3Dce=
ph
--admin-daemon /var/run/ceph/ceph-mon.node1.asok mon_status<span></span></s=
pan></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,156][ceph_deploy.mon][INFO=C2=A0 ] processing monitor mon.node1<sp=
an></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,194][node1][DEBUG ] connection detected need for sudo<span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,230][node1][DEBUG ] connected to host: node1 <span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,231][node1][DEBUG ] detect platform information from remote host<s=
pan></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,265][node1][DEBUG ] detect machine type<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,270][node1][DEBUG ] find the location of an executable<span></span=
></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,273][node1][INFO=C2=A0 ] Running command: sudo ceph --cluster=3Dce=
ph
--admin-daemon /var/run/ceph/ceph-mon.node1.asok mon_status<span></span></s=
pan></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,439][ceph_deploy.mon][INFO=C2=A0 ] mon.node1 monitor has reached q=
uorum!<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,440][ceph_deploy.mon][INFO=C2=A0 ] all initial monitors are runnin=
g
and have formed quorum<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,440][ceph_deploy.mon][INFO=C2=A0 ] Running gatherkeys...<span></sp=
an></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,441][ceph_deploy.gatherkeys][INFO=C2=A0 ] Storing keys in temp
directory /tmp/tmp8bdYT6<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,477][node1][DEBUG ] connection detected need for sudo<span></span>=
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,510][node1][DEBUG ] connected to host: node1 <span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,511][node1][DEBUG ] detect platform information from remote host<s=
pan></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,552][node1][DEBUG ] detect machine type<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,558][node1][DEBUG ] get remote short hostname<span></span></span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,559][node1][DEBUG ] fetch remote file<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,562][node1][INFO=C2=A0 ] Running command: sudo /usr/bin/ceph
--connect-timeout=3D25 --cluster=3Dceph
--admin-daemon=3D/var/run/ceph/ceph-mon.node1.asok mon_status<span></span><=
/span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:53:52,731][node1][INFO=C2=A0 ] Running command: sudo /usr/bin/ceph
--connect-timeout=3D25 --cluster=3Dceph --name mon.
--keyring=3D/var/lib/ceph/mon/ceph-node1/keyring auth get client.admin<span=
></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:54:18,059][node1][ERROR ] &quot;ceph auth get-or-create for keytype admi=
n
returned 1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:54:18,059][node1][DEBUG ] Cluster connection interrupted or timed out<sp=
an></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:54:18,059][node1][ERROR ] Failed to return &#39;admin&#39; key from host=
 node1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:54:18,059][ceph_deploy.gatherkeys][ERROR ] Failed to connect to host:nod=
e1<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:54:18,060][ceph_deploy.gatherkeys][INFO=C2=A0 ] Destroy temp directory
/tmp/tmp8bdYT6<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[2018-07-12
17:54:18,060][ceph_deploy][ERROR ] RuntimeError: Failed to connect any mon<=
span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">ceph-=
mon service is up but cannot be
connected to reach, &quot;ceph -s&quot; also returns same types of error:<s=
pan></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">2018-07-13
10:44:21.169536 7fa570d4e700=C2=A0 0 monclient(hunting): authenticate timed=
 out
after 300<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">2018-07-13
10:44:21.169579 7fa570d4e700=C2=A0 0 librados: client.admin authentication
error (110) Connection timed out<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US" style=
=3D"color:rgb(127,127,127)">[errno 110] error
connecting to the cluster<span></span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><br></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">I&#39=
;am running the ceph version 12.2.4
luminous stable, anyone=C2=A0 has any suggestion about this issue?<span></s=
pan></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US"><span=
>=C2=A0</span></span></p>

<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;text-align:justify;=
font-size:10.5pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">Thx<s=
pan></span></span></p>




<br></div>

--0000000000006a59b8057150c57e--

--===============7367998815734842394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7367998815734842394==--
