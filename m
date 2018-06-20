From: "Raju  Rangoju" <rajur-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>
Subject: issues with ceph nautilus version
Date: Wed, 20 Jun 2018 15:41:26 +0000
Message-ID: <CY1PR12MB0774E4B82E4528FE9DA7D162BC770@CY1PR12MB0774.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4624601321240055373=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4624601321240055373==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB0774E4B82E4528FE9DA7D162BC770CY1PR12MB0774namp_"

--_000_CY1PR12MB0774E4B82E4528FE9DA7D162BC770CY1PR12MB0774namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Recently I have upgraded my ceph cluster to version 14.0.0 - nautilus(dev) =
from ceph version 13.0.1, after this, I noticed some weird data usage numbe=
rs on the cluster.
Here are the issues I'm seeing...

  1.  The data usage reported is much more than what is available

usage:   16 EiB used, 164 TiB / 158 TiB avail



before this upgradation, it used to report properly

usage:   1.10T used, 157T / 158T avail



  1.  it reports that all the osds/pool are full

Can someone please shed some light? Any helps is greatly appreciated.

[root@hadoop1 my-ceph]# ceph --version
ceph version 14.0.0-480-g6c1e8ee (6c1e8ee14f9b25dc96684dbc1f8c8255c47f0bb9)=
 nautilus (dev)

[root@hadoop1 my-ceph]# ceph -s
  cluster:
    id:     ee4660fd-167b-42e6-b27b-126526dab04d
    health: HEALTH_ERR
            87 full osd(s)
            11 pool(s) full

  services:
    mon: 3 daemons, quorum hadoop1,hadoop4,hadoop6
    mgr: hadoop6(active), standbys: hadoop1, hadoop4
    mds: cephfs-1/1/1 up  {0=3Dhadoop3=3Dup:creating}, 2 up:standby
    osd: 88 osds: 87 up, 87 in

  data:
    pools:   11 pools, 32588 pgs
    objects: 0  objects, 0 B
    usage:   16 EiB used, 164 TiB / 158 TiB avail
    pgs:     32588 active+clean

Thanks in advance
-Raj


--_000_CY1PR12MB0774E4B82E4528FE9DA7D162BC770CY1PR12MB0774namp_
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:262538479;
	mso-list-type:hybrid;
	mso-list-template-ids:-895568224 1074331663 1074331673 1074331675 10743316=
63 1074331673 1074331675 1074331663 1074331673 1074331675;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Recently I have upgraded my ceph cluster to version =
14.0.0 - nautilus(dev) from ceph version 13.0.1, after this, I noticed some=
 weird data usage numbers on the cluster.<o:p></o:p></p>
<p class=3D"MsoNormal">Here are the issues I&#8217;m seeing&#8230;<o:p></o:=
p></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1">The data usage reported is much more than what is available
<o:p></o:p></li></ol>
<p class=3D"MsoListParagraph">usage:&nbsp;&nbsp; 16 EiB used, 164 TiB / 158=
 TiB avail<o:p></o:p></p>
<p class=3D"MsoListParagraph"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph">before this upgradation, it used to report pr=
operly<o:p></o:p></p>
<p class=3D"MsoListParagraph">usage:&nbsp;&nbsp; 1.10T used, 157T / 158T av=
ail<o:p></o:p></p>
<p class=3D"MsoListParagraph"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l0 level1 =
lfo1">it reports that all the osds/pool are full<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can someone please shed some light? Any helps is gre=
atly appreciated.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[root@hadoop1 my-ceph]# ceph --version<o:p></o:p></p=
>
<p class=3D"MsoNormal">ceph version 14.0.0-480-g6c1e8ee (6c1e8ee14f9b25dc96=
684dbc1f8c8255c47f0bb9) nautilus (dev)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[root@hadoop1 my-ceph]# ceph -s<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; cluster:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; id:&nbsp;&nbsp;&nbsp;&nbsp; ee466=
0fd-167b-42e6-b27b-126526dab04d<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; health: HEALTH_ERR<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 87 full osd(s)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 11 pool(s) full<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; services:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; mon: 3 daemons, quorum hadoop1,ha=
doop4,hadoop6<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; mgr: hadoop6(active), standbys: h=
adoop1, hadoop4<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; mds: cephfs-1/1/1 up&nbsp; {0=3Dh=
adoop3=3Dup:creating}, 2 up:standby<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; osd: 88 osds: 87 up, 87 in<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; data:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; pools:&nbsp;&nbsp; 11 pools, 3258=
8 pgs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; objects: 0&nbsp; objects, 0 B<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; usage:&nbsp;&nbsp; 16 EiB used, 1=
64 TiB / 158 TiB avail<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; pgs:&nbsp;&nbsp;&nbsp;&nbsp; 3258=
8 active&#43;clean<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advance<o:p></o:p></p>
<p class=3D"MsoNormal">-Raj<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CY1PR12MB0774E4B82E4528FE9DA7D162BC770CY1PR12MB0774namp_--

--===============4624601321240055373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4624601321240055373==--
