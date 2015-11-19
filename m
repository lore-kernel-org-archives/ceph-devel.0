From: "Igor.Podoski-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org" <Igor.Podoski-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org>
Subject: ceph_monitor - monitor your cluster with parallel
	python
Date: Thu, 19 Nov 2015 07:53:06 +0000
Message-ID: <dd5d44e526f643e492959ebac2747801@R01UKEXCASM222.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1202562387=="
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1202562387==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_dd5d44e526f643e492959ebac2747801R01UKEXCASM222r01fujits_"

--_000_dd5d44e526f643e492959ebac2747801R01UKEXCASM222r01fujits_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Cephers!

I've created small tool to help track memory/cpu/io usage. It's useful for =
me so I thought I could share with you: https://github.com/aiicore/ceph_mon=
itor

In general this is a python script, that uses parallel python to run a func=
tion on remote host. Data is gathered from all hosts and presented on conso=
le or added to sqlite database, then can be plotted with e.g. gnuplot. You =
can define osd ranges, that you want to monitor, or monitor certain process=
, e.g. osds only from pool that has ssds.

The main concept is that monitor don't know and don't care on which host os=
d's are running, it treats them as a whole set.

Script uses psutil to get data related to processes (mon/osd/rgw/whatever).=
 In near feature I'd like to add modes that can modify process behavior e.g=
. psutil has .nice .ionice .cpu_affinity methods, that could be useful in s=
ome tests. Basically with parallel python you can run any function remotely=
, so tuning SO by changing some /proc/* files can be done too.

You can add labels to data to see when what happens.

Sample plot: https://raw.githubusercontent.com/aiicore/ceph_monitor/master/=
examples/avg_cpu_mem.png
Simple test: https://github.com/aiicore/ceph_monitor/blob/master/examples/e=
xample_test_with_rados.sh

Short readme:  https://github.com/aiicore/ceph_monitor
Full readme: https://github.com/aiicore/ceph_monitor/blob/master/readme.txt

I encourage You to use and develop it, if not just please read the full rea=
dme text, maybe you'll  come up with a better idea based on my this concept=
 and something interesting will happen.

p.s. This currently works with python 2.6 and psutil 0.6.1 on centos 6.6.  =
If you find any bug - report it on my github as an issue.

!!! Security notice !!!
Parallel python supports SHA authentication  - my version currently runs WI=
THOUT this so in certain environments it could be dangerous (you could run =
any function from untrusted client). For now use it only in test/dev isolat=
ed clusters.

Regards,
Igor.


--_000_dd5d44e526f643e492959ebac2747801R01UKEXCASM222r01fujits_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Cephers!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve created small tool to help track memory/c=
pu/io usage. It&#8217;s useful for me so I thought I could share with you:
<a href=3D"https://github.com/aiicore/ceph_monitor">https://github.com/aiic=
ore/ceph_monitor</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In general this is a python script, that uses parall=
el python to run a function on remote host. Data is gathered from all hosts=
 and presented on console or added to sqlite database, then can be plotted =
with e.g. gnuplot. You can define
 osd ranges, that you want to monitor, or monitor certain process, e.g. osd=
s only from pool that has ssds.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The main concept is that monitor don&#8217;t know an=
d don&#8217;t care on which host osd&#8217;s are running, it treats them as=
 a whole set.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Script uses psutil to get data related to processes =
(mon/osd/rgw/whatever). In near feature I&#8217;d like to add modes that ca=
n modify process behavior e.g. psutil has .nice .ionice .cpu_affinity metho=
ds, that could be useful in some tests.
 Basically with parallel python you can run any function remotely, so tunin=
g SO by changing some /proc/* files can be done too.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">You can add labels to data to see when what happens.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sample plot: <a href=3D"https://raw.githubuserconten=
t.com/aiicore/ceph_monitor/master/examples/avg_cpu_mem.png">
https://raw.githubusercontent.com/aiicore/ceph_monitor/master/examples/avg_=
cpu_mem.png</a>
<o:p></o:p></p>
<p class=3D"MsoNormal">Simple test: <a href=3D"https://github.com/aiicore/c=
eph_monitor/blob/master/examples/example_test_with_rados.sh">
https://github.com/aiicore/ceph_monitor/blob/master/examples/example_test_w=
ith_rados.sh</a>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Short readme:&nbsp; <a href=3D"https://github.com/ai=
icore/ceph_monitor">
https://github.com/aiicore/ceph_monitor</a> <o:p></o:p></p>
<p class=3D"MsoNormal">Full readme: <a href=3D"https://github.com/aiicore/c=
eph_monitor/blob/master/readme.txt">
https://github.com/aiicore/ceph_monitor/blob/master/readme.txt</a> <o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I encourage You to use and develop it, if not just p=
lease read the full readme text, maybe you&#8217;ll &nbsp;come up with a be=
tter idea based on my this concept and something interesting will happen.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">p.s. This currently works with python 2.6 and psutil=
 0.6.1 on centos 6.6. &nbsp;If you find any bug &#8211; report it on my git=
hub as an issue.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">!!! Security notice !!!<o:p></o:p></p>
<p class=3D"MsoNormal">Parallel python supports SHA authentication &nbsp;&#=
8211; my version currently runs WITHOUT this so in certain environments it =
could be dangerous (you could run any function from untrusted client). For =
now use it only in test/dev isolated clusters.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Igor.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_dd5d44e526f643e492959ebac2747801R01UKEXCASM222r01fujits_--

--===============1202562387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1202562387==--
