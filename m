From: "Trivedi, Narendra" <Narendra.Trivedi-N6E5BMIblqrQT0dZR+AlfA@public.gmane.org>
Subject: Re: testing ceph
Date: Mon, 4 Nov 2013 15:56:17 +0000
Message-ID: <776ECADDC3FA214BB89434DD0C805BB902764120@DC2EXCHMULTI1.savvis.ad.savvis.net>
References: <DUB116-W8372DACD4F54B9145260E4E00B0@phx.gbl>,
	<5272373C.4020906@inktank.com>
	<DUB116-W91D38BDD6BED25D0F26267E0F60@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1260095107=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <DUB116-W91D38BDD6BED25D0F26267E0F60-MsuGFMq8XAE@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: charles L <charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1260095107==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_776ECADDC3FA214BB89434DD0C805BB902764120DC2EXCHMULTI1sa_"

--_000_776ECADDC3FA214BB89434DD0C805BB902764120DC2EXCHMULTI1sa_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bingo! A lot of people are getting this dreadful GenericErro and Failed to=
 create 1 OSD. Does anyone know why despite /etc/ceph being there on each =
node?  Also, FYI purgedata on multiple nodes doesn't work sometime i.e. it=
 says it is uninstalled ceph and removed /etc/ceph from all nodes but they=
 are there on all nodes except the first one (i.e. the first argument to t=
he purgedata command ). Hence sometimes, I have to issue purgedata to indi=
vidual nodes.

From: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-bounces@lists.c=
eph.com] On Behalf Of charles L
Sent: Monday, November 04, 2013 9:26 AM
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
Subject: Re: [ceph-users] testing ceph


 Pls can somebody help?  Im  getting this error.

ceph@CephAdmin:~$ ceph-deploy osd create server1:sda:/dev/sdj1
[ceph_deploy.cli][INFO  ] Invoked (1.3): /usr/bin/ceph-deploy osd create s=
erver1:sda:/dev/sdj1
[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks server1:/dev/sda:/d=
ev/sdj1
[server1][DEBUG ] connected to host: server1
[server1][DEBUG ] detect platform information from remote host
[server1][DEBUG ] detect machine type
[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] Deploying osd to server1
[server1][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[server1][INFO  ] Running command: sudo udevadm trigger --subsystem-match=3D=
block --action=3Dadd
[ceph_deploy.osd][DEBUG ] Preparing host server1 disk /dev/sda journal /de=
v/sdj1 activate True
[server1][INFO  ] Running command: sudo ceph-disk-prepare --fs-type xfs --=
cluster ceph -- /dev/sda /dev/sdj1
[server1][ERROR ] WARNING:ceph-disk:OSD will not be hot-swappable if journ=
al is not the same device as the osd data
[server1][ERROR ] Could not create partition 1 from 34 to 2047
[server1][ERROR ] Error encountered; not saving changes.
[server1][ERROR ] ceph-disk: Error: Command '['sgdisk', '--largest-new=3D1=
', '--change-name=3D1:ceph data', '--partition-guid=3D1:d3ca8a92-7ba5-412e=
-abf5-06af958b788d', '--typecode=3D1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be'=
, '--', '/dev/sda']' returned non-zero exit status 4
[server1][ERROR ] Traceback (most recent call last):
[server1][ERROR ]   File "/usr/lib/python2.7/dist-packages/ceph_deploy/lib=
/remoto/process.py", line 68, in run
[server1][ERROR ]     reporting(conn, result, timeout)
[server1][ERROR ]   File "/usr/lib/python2.7/dist-packages/ceph_deploy/lib=
/remoto/log.py", line 13, in reporting
[server1][ERROR ]     received =3D result.receive(timeout)
[server1][ERROR ]   File "/usr/lib/python2.7/dist-packages/ceph_deploy/lib=
/remoto/lib/execnet/gateway_base.py", line 455, in receive
[server1][ERROR ]     raise self._getremoteerror() or EOFError()
[server1][ERROR ] RemoteError: Traceback (most recent call last):
[server1][ERROR ]   File "<string>", line 806, in executetask
[server1][ERROR ]   File "", line 35, in _remote_run
[server1][ERROR ] RuntimeError: command returned non-zero exit status: 1
[server1][ERROR ]
[server1][ERROR ]
[ceph_deploy.osd][ERROR ] Failed to execute command: ceph-disk-prepare --f=
s-type xfs --cluster ceph -- /dev/sda /dev/sdj1
[ceph_deploy][ERROR ] GenericError: Failed to create 1 OSDs






> Date: Thu, 31 Oct 2013 10:55:56 +0000
> From: joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org<mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
> To: charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org<mailto:charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>; ceph-de=
vel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Subject: Re: testing ceph
>
> On 10/31/2013 04:54 AM, charles L wrote:
> > Hi,
> > Pls is this a good setup for a production environment test of ceph? My=
 focus is on the SSD ... should it be partitioned(sdf1,2 ,3,4) and shared =
by the four OSDs on a host? or is this a better configuration for the SSD =
to be just one partition(sdf1) while all osd uses that one partition?
> > my setup:
> > - 6 Servers with one 250gb boot disk for OS(sda),
> > four-2Tb Disks each for the OSDs i.e Total disks =3D 6x4 =3D 24 disks =
(sdb -sde)
> > and one-60GB SSD for Osd Journal(sdf).
> > -RAM =3D 32GB on each server with 2 GB network link.
> > hostname for servers: Server1 -Server6
>
> Charles,
>
> What you are describing on the ceph.conf below is definitely not a good
> idea. If you really want to use just one SSD and share it across
> multiple OSDs, then you have two possible approaches:
>
> - partition that disk and assign a *different* partition to each OSD; or=

> - keep only one partition, format it with some filesystem, and assign a
> *different* journal file within that fs to each OSD.
>
> What you are describing has you using the same partition for all OSDs.
> This will likely create issues due to multiple OSDs writing and reading
> from a single journal. TBH I'm not familiar enough with the journal
> mechanism to know whether the OSDs will detect that situation.
>
> -Joao
>
> >
> > [osd.0]
> > host =3D server1
> > devs =3D /dev/sdb
> > osd journal =3D /dev/sdf1
> > [osd.1]
> > host =3D server1
> > devs =3D /dev/sdc
> > osd journal =3D /dev/sdf2
> >
> > [osd.3]
> > host =3D server1
> > devs =3D /dev/sdd
> > osd journal =3D /dev/sdf2
> >
> > [osd.4]
> > host =3D server1
> > devs =3D /dev/sde
> > osd journal =3D /dev/sdf2
> > [osd.5]
> > host =3D server2
> > devs =3D /dev/sdb
> > osd journal =3D /dev/sdf2
> > ...
> > [osd.23]
> > host =3D server6
> > devs =3D /dev/sde
> > osd journal =3D /dev/sdf2
> >
> > Thanks. --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:majordomo@vg=
er.kernel.org>
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> >
>
>
> --
> Joao Eduardo Luis
> Software Engineer | http://inktank.com | http://ceph.com

This message contains information which may be confidential and/or privile=
ged. Unless you are the intended recipient (or authorized to receive for t=
he intended recipient), you may not read, use, copy or disclose to anyone =
the message or any information contained in the message. If you have recei=
ved the message in error, please advise the sender by reply e-mail and del=
ete the message and any attachment(s) thereto without retaining any copies=
.
--_000_776ECADDC3FA214BB89434DD0C805BB902764120DC2EXCHMULTI1sa_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mic=
rosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"ht=
tp://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii=
">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p
=09{mso-style-priority:99;
=09mso-margin-top-alt:auto;
=09margin-right:0in;
=09mso-margin-bottom-alt:auto;
=09margin-left:0in;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
span.EmailStyle18
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Bingo! A lot of people =
are getting this dreadful GenericErro and Failed to create 1 OSD. Does any=
one know why despite /etc/ceph being there on each node? &nbsp;Also,
 FYI purgedata on multiple nodes doesn&#8217;t work sometime i.e. it says =
it is uninstalled ceph and removed /etc/ceph from all nodes but they are t=
here on all nodes except the first one (i.e. the first argument to the pur=
gedata command ). Hence sometimes, I have
 to issue purgedata to individual nodes. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span=
></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in=
 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quo=
t;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font=
-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> ceph-=
users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org]
<b>On Behalf Of </b>charles L<br>
<b>Sent:</b> Monday, November 04, 2013 9:26 AM<br>
<b>To:</b> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org<br>
<b>Subject:</b> Re: [ceph-users] testing ceph<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">&nbsp;Pls can somebody help? &nbsp;Im &nbsp;getting th=
is error.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">ceph@CephAdmin:~$ ceph-deploy osd create server1:sda:/=
dev/sdj1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy.cli][INFO &nbsp;] Invoked (1.3): /usr/bin=
/ceph-deploy osd create server1:sda:/dev/sdj1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks=
 server1:/dev/sda:/dev/sdj1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][DEBUG ] connected to host: server1<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][DEBUG ] detect platform information from rem=
ote host<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][DEBUG ] detect machine type<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy.osd][INFO &nbsp;] Distro info: Ubuntu 12.=
04 precise<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy.osd][DEBUG ] Deploying osd to server1<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][DEBUG ] write cluster configuration to /etc/=
ceph/{cluster}.conf<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][INFO &nbsp;] Running command: sudo udevadm t=
rigger --subsystem-match=3Dblock --action=3Dadd<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy.osd][DEBUG ] Preparing host server1 disk =
/dev/sda journal /dev/sdj1 activate True<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][INFO &nbsp;] Running command: sudo ceph-disk=
-prepare --fs-type xfs --cluster ceph -- /dev/sda /dev/sdj1<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] WARNING:ceph-disk:OSD will not be ho=
t-swappable if journal is not the same device as the osd data<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] Could not create partition 1 from 34=
 to 2047<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] Error encountered; not saving change=
s.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] ceph-disk: Error: Command '['sgdisk'=
, '--largest-new=3D1', '--change-name=3D1:ceph data', '--partition-guid=3D=
1:d3ca8a92-7ba5-412e-abf5-06af958b788d', '--typecode=3D1:89c57f98-2fe5-4dc=
0-89c1-f3ad0ceff2be',
 '--', '/dev/sda']' returned non-zero exit status 4<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] Traceback (most recent call last):<o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; File &quot;/usr/lib/python2.7=
/dist-packages/ceph_deploy/lib/remoto/process.py&quot;, line 68, in run<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; &nbsp; reporting(conn, result=
, timeout)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; File &quot;/usr/lib/python2.7=
/dist-packages/ceph_deploy/lib/remoto/log.py&quot;, line 13, in reporting<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; &nbsp; received =3D result.re=
ceive(timeout)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; File &quot;/usr/lib/python2.7=
/dist-packages/ceph_deploy/lib/remoto/lib/execnet/gateway_base.py&quot;, l=
ine 455, in receive<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; &nbsp; raise self._getremotee=
rror() or EOFError()<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] RemoteError: Traceback (most recent =
call last):<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; File &quot;&lt;string&gt;&quo=
t;, line 806, in executetask<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] &nbsp; File &quot;&quot;, line 35, i=
n _remote_run<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ] RuntimeError: command returned non-z=
ero exit status: 1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[server1][ERROR ]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy.osd][ERROR ] Failed to execute command: c=
eph-disk-prepare --fs-type xfs --cluster ceph -- /dev/sda /dev/sdj1<o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">[ceph_deploy][ERROR ] GenericError: Failed to create 1=
 OSDs<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">&gt; Date: Thu, 31 Oct 2013 10:55:56 &#43;0000<br>
&gt; From: <a href=3D"mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org<=
/a><br>
&gt; To: <a href=3D"mailto:charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org">charlesboy009@hotmai=
l.com</a>; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">
ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; Subject: Re: testing ceph<br>
&gt; <br>
&gt; On 10/31/2013 04:54 AM, charles=20L wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt; Pls is this a good setup for a production environment test of ce=
ph? My focus is on the SSD ... should it be partitioned(sdf1,2 ,3,4) and s=
hared by the four OSDs on a host? or is this a better configuration for th=
e SSD to be just one partition(sdf1) while
 all osd uses that one partition?<br>
&gt; &gt; my setup:<br>
&gt; &gt; - 6 Servers with one 250gb boot disk for OS(sda),<br>
&gt; &gt; four-2Tb Disks each for the OSDs i.e Total disks =3D 6x4 =3D 24 =
disks (sdb -sde)<br>
&gt; &gt; and one-60GB SSD for Osd Journal(sdf).<br>
&gt; &gt; -RAM =3D 32GB on each server with 2 GB network link.<br>
&gt; &gt; hostname for servers: Server1 -Server6<br>
&gt; <br>
&gt; Charles,<br>
&gt; <br>
&gt; What you are describing on the ceph.conf below is definitely not a go=
od <br>
&gt; idea. If you really want to use just one SSD and share it across <br>=

&gt; multiple OSDs, then you have two possible approaches:<br>
&gt; <br>
&gt; - partition that disk and assign a *different* partition to each OSD;=
 or<br>
&gt; - keep only one partition, format it with some filesystem, and assign=
 a <br>
&gt; *different* journal file within that fs to each OSD.<br>
&gt; <br>
&gt; What you are describing has you using the same partition for all OSDs=
. <br>
&gt; This will likely create issues due to multiple OSDs writing and readi=
ng <br>
&gt; from a single journal. TBH I'm not familiar enough with the journal <=
br>
&gt; mechanism to know whether the OSDs will detect that situation.<br>
&gt; <br>
&gt; -Joao<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; [osd.0]<br>
&gt; &gt; host =3D server1<br>
&gt; &gt; devs =3D /dev/sdb<br>
&gt; &gt; osd journal =3D /dev/sdf1<br>
&gt; &gt; [osd.1]<br>
&gt; &gt; host =3D server1<br>
&gt; &gt; devs =3D /dev/sdc<br>
&gt; &gt; osd journal =3D /dev/sdf2<br>
&gt; &gt;<br>
&gt; &gt; [osd.3]<br>
&gt; &gt; host =3D server1<br>
&gt; &gt; devs =3D /dev/sdd<br>
&gt; &gt; osd journal =3D /dev/sdf2<br>
&gt; &gt;<br>
&gt; &gt; [osd.4]<br>
&gt; &gt; host =3D server1<br>
&gt; &gt; devs =3D /dev/sde<br>
&gt; &gt; osd journal =3D /dev/sdf2<br>
&gt; &gt; [osd.5]<br>
&gt; &gt; host =3D server2<br>
&gt; &gt; devs =3D /dev/sdb<br>
&gt; &gt; osd journal =3D /dev/sdf2<br>
&gt; &gt; ...<br>
&gt; &gt; [osd.23]<br>
&gt; &gt; host =3D server6<br>
&gt; &gt; devs =3D /dev/sde<br>
&gt; &gt; osd journal =3D /dev/sdf2<br>
&gt; &gt;<br>
&gt; &gt; Thanks. --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe c=
eph-devel&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; &gt; More majordomo info at <a href=3D"http://vger.kernel.org/majordo=
mo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Joao Eduardo Luis<br>
&gt; Software Engineer | <a href=3D"http://inktank.com">http://inktank.com=
</a> | <a href=3D"http://ceph.com">
http://ceph.com</a><o:p></o:p></span></p>
</div>
</div>
</div>
<br clear=3D"both">
This message contains information which may be confidential and/or privile=
ged. Unless you are the intended recipient (or authorized to receive for t=
he intended recipient), you may not read, use, copy or disclose to anyone =
the message or any information contained in the message. If you have recei=
ved the message in error, please advise the sender by reply e-mail and del=
ete the message and any attachment(s) thereto without retaining any copies=
.<BR>
</body>
</html>

--_000_776ECADDC3FA214BB89434DD0C805BB902764120DC2EXCHMULTI1sa_--

--===============1260095107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1260095107==--
