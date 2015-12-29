From: gongfengguang <gongfengguang-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Create one millon empty files with cephfs
Date: Tue, 29 Dec 2015 18:11:05 +0800
Message-ID: <BAY403-EAS291EDAEC6F18236762EF719ADFC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1696548318=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: zh-cn
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1696548318==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0054_01D14264.4914D580"
Content-Language: zh-cn

------=_NextPart_000_0054_01D14264.4914D580
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

We create one millon empty files through filebench, here is the test env:

MDS: one  MDS  

MON: one  MON

OSD: two OSD , each with one Intel P3700; data on OSD with 2x replica

NetWork: all the nodes are connectted through 10 gigabit network

 

We use more than one client to create files, to test the scalability of MDS.
Here are the results:

IOPS under one client: 850

IOPS under two client: 1150

IOPS under four client: 1180

As we can see,the IOPS almost maintains unchanged when the number of client
increase from 2 to 4. 

Cephfs may have a low scalability under one MDS, and we think its the big
lock in MDSDamon::ms_dispatch()::Mutex::locker(every request acquires this
lock), who limits the scalability of MDS.

 

We think this big lock could be removed through the following steps:

1. separate the process of ClientRequest with other requests, so we can
parallel the process of ClientRequest

2. use some small granularity locks instead of big lock to ensure
consistency 

 

Wondering this idea is reasonable ?

 

thanks

 


------=_NextPart_000_0054_01D14264.4914D580
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:\7B49\7EBF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@\7B49\7EBF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:\7B49\7EBF;}
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
	font-family:\7B49\7EBF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:\7B49\7EBF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN =
link=3D"#0563C1" vlink=3D"#954F72" =
style=3D'text-justify-trim:punctuation'><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>Hi,<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:14.0pt'>We =
create one millon empty files through filebench, here is the test =
env:<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>MDS: one&nbsp; MDS&nbsp; =
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>MON: one&nbsp; MON<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:14.0pt'>OSD: two =
OSD , each with one Intel P3700; data on OSD with 2x =
replica<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>NetWork: all the nodes are connectted through =
10 gigabit network<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:14.0pt'>We use =
more than one client to create files, to test the scalability of MDS. =
Here are the results:<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-size:14.0pt'>IOPS under one client: =
850<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>IOPS under two client: =
1150<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>IOPS under four client: =
1180<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>As we can see,the IOPS almost maintains =
unchanged when the number of client increase from 2 to 4. =
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>Cephfs may have a low scalability under one =
MDS, and we think its the big lock in =
MDSDamon::ms_dispatch()::Mutex::locker(every request acquires this =
lock), who limits the scalability of MDS.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:14.0pt'>We think =
this big lock could be removed through the following =
steps:<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>1. separate the process of ClientRequest with =
other requests, so we can parallel the process of =
ClientRequest<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-size:14.0pt'>2. use some small granularity =
locks instead of big lock to ensure consistency <o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>Wondering this idea is reasonable =
?<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'>thanks<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:14.0pt'><o:p>&nbsp;</o:p></span></p></div></body></htm=
l>
------=_NextPart_000_0054_01D14264.4914D580--

--===============1696548318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1696548318==--
