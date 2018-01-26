From: "Moreno, Orlando" <orlando.moreno-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Ceph OSDs fail to start with RDMA
Date: Fri, 26 Jan 2018 21:53:59 +0000
Message-ID: <034AAD465C6CBE4F96D9FB98573A79A63719E2D5@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1598287641255764632=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Tang, Haodong" <haodong.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1598287641255764632==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_034AAD465C6CBE4F96D9FB98573A79A63719E2D5FMSMSX108amrcor_"

--_000_034AAD465C6CBE4F96D9FB98573A79A63719E2D5FMSMSX108amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am trying to bring up a Ceph cluster where the private network is communi=
cating via RoCEv2. The storage nodes have 2 dual-port 25Gb Mellanox Connect=
X-4 NICs, with each NIC's ports bonded (2x25Gb mode 4). I have set memory l=
imits to unlimited, can rping to each node, and ms_async_rdma_device_name s=
et to the ibdev (mlx5_bond_1). Everything goes smoothly until I start bring=
ing up OSDs. Nothing appears in stderr, but upon further inspection of the =
OSD log, I see the following error:

RDMAConnectedSocketImpl activate failed to transition to RTR state: (19) No=
 such device
/build/ceph-12.2.2/src/msg/async/rdma/RDMAConnectedSocketImpl.cc: In functi=
on 'void RDMAConnectedSocketImpl::handle_connection()' thread 7f908633c700 =
time 2018-01-26 10:47:51.607573
/build/ceph-12.2.2/src/msg/async/rdma/RDMAConnectedSocketImpl.cc: 221: FAIL=
ED assert(!r)

ceph version 12.2.2 (cf0baeeeeba3b47f9427c6c97e2144b094b7e5ba) luminous (st=
able)
1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x=
102) [0x564a2ccf7892]
2: (RDMAConnectedSocketImpl::handle_connection()+0xb4a) [0x564a2d007fba]
3: (EventCenter::process_events(int, std::chrono::duration<unsigned long, s=
td::ratio<1l, 1000000000l> >*)+0xa08) [0x564a2cd9a418]
4: (()+0xb4f3a8) [0x564a2cd9e3a8]
5: (()+0xb8c80) [0x7f9088c04c80]
6: (()+0x76ba) [0x7f90892f36ba]
7: (clone()+0x6d) [0x7f908836a41d]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to=
 interpret this.

Anyone see this before or have any suggestions?

Thanks,
Orlando

--_000_034AAD465C6CBE4F96D9FB98573A79A63719E2D5FMSMSX108amrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am trying to bring up a Ceph cluster where the pri=
vate network is communicating via RoCEv2. The storage nodes have 2 dual-por=
t 25Gb Mellanox ConnectX-4 NICs, with each NIC&#8217;s ports bonded (2x25Gb=
 mode 4). I have set memory limits to unlimited,
 can rping to each node, and ms_async_rdma_device_name set to the ibdev (ml=
x5_bond_1). Everything goes smoothly until I start bringing up OSDs. Nothin=
g appears in stderr, but upon further inspection of the OSD log, I see the =
following error:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">RDMAConnectedSocketImpl activate failed to transitio=
n to RTR state: (19) No such device<o:p></o:p></p>
<p class=3D"MsoNormal">/build/ceph-12.2.2/src/msg/async/rdma/RDMAConnectedS=
ocketImpl.cc: In function 'void RDMAConnectedSocketImpl::handle_connection(=
)' thread 7f908633c700 time 2018-01-26 10:47:51.607573<o:p></o:p></p>
<p class=3D"MsoNormal">/build/ceph-12.2.2/src/msg/async/rdma/RDMAConnectedS=
ocketImpl.cc: 221: FAILED assert(!r)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ceph version 12.2.2 (cf0baeeeeba3b47f9427c6c97e2144b=
094b7e5ba) luminous (stable)<o:p></o:p></p>
<p class=3D"MsoNormal">1: (ceph::__ceph_assert_fail(char const*, char const=
*, int, char const*)&#43;0x102) [0x564a2ccf7892]<o:p></o:p></p>
<p class=3D"MsoNormal">2: (RDMAConnectedSocketImpl::handle_connection()&#43=
;0xb4a) [0x564a2d007fba]<o:p></o:p></p>
<p class=3D"MsoNormal">3: (EventCenter::process_events(int, std::chrono::du=
ration&lt;unsigned long, std::ratio&lt;1l, 1000000000l&gt; &gt;*)&#43;0xa08=
) [0x564a2cd9a418]<o:p></o:p></p>
<p class=3D"MsoNormal">4: (()&#43;0xb4f3a8) [0x564a2cd9e3a8]<o:p></o:p></p>
<p class=3D"MsoNormal">5: (()&#43;0xb8c80) [0x7f9088c04c80]<o:p></o:p></p>
<p class=3D"MsoNormal">6: (()&#43;0x76ba) [0x7f90892f36ba]<o:p></o:p></p>
<p class=3D"MsoNormal">7: (clone()&#43;0x6d) [0x7f908836a41d]<o:p></o:p></p=
>
<p class=3D"MsoNormal">NOTE: a copy of the executable, or `objdump -rdS &lt=
;executable&gt;` is needed to interpret this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Anyone see this before or have any suggestions?<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Orlando<o:p></o:p></p>
</div>
</body>
</html>

--_000_034AAD465C6CBE4F96D9FB98573A79A63719E2D5FMSMSX108amrcor_--

--===============1598287641255764632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1598287641255764632==--
