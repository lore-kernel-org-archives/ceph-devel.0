From: "Raju  Rangoju" <rajur-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>
Subject: permission errors rolling back ceph cluster to v13
Date: Wed, 8 Aug 2018 01:27:29 +0000
Message-ID: <SN6PR12MB270391A4AEF81C16E8A31B77BC260@SN6PR12MB2703.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3606639356975087987=="
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

--===============3606639356975087987==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB270391A4AEF81C16E8A31B77BC260SN6PR12MB2703namp_"

--_000_SN6PR12MB270391A4AEF81C16E8A31B77BC260SN6PR12MB2703namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have been running into some connection issues with the latest ceph-14 ver=
sion, so we thought the feasible solution would be to roll back the cluster=
 to previous version (ceph-13.0.1) where things are known to work properly.

I'm wondering if rollback/downgrade is supported at all ?

After compiling/starting ceph-13 I'm running into a permission error. Basic=
ally it complains about the incompatibility of disk layout (ceph-13 mimic v=
s ceph-14 nautilus)

2018-08-07 10:41:00.580 2b391528e080 -1 ERROR: on disk data includes unsupp=
orted features: compat=3D{},rocompat=3D{},incompat=3D{11=3Dnautilus ondisk =
layout}
2018-08-07 10:41:00.580 2b391528e080 -1 error checking features: (1) Operat=
ion not permitted
2018-08-07 10:41:11.161 2b16a7d14080  0 set uid:gid to 167:167 (ceph:ceph)
2018-08-07 10:41:11.161 2b16a7d14080  0 ceph version 13.0.1-3266-g6b59fbf (=
6b59fbfcc6bbfd67193e1c1e142b478ddd68aab4) mimic (dev), process (unknown), p=
id 14013
2018-08-07 10:41:11.161 2b16a7d14080  0 pidfile_write: ignore empty --pid-f=
ile


I thought allowing permissions to mon would fix it (see below), but apparen=
tly ceph command hangs. So it didn't allow permissions.

ceph auth add osd.44 osd 'allow *' mon 'allow profile osd' -i /var/lib/ceph=
/osd/ceph-44/keyring

[root@hadoop1 my-ceph]# ceph -s
2018-08-07 10:59:59.325 2b5c26347700  0 monclient(hunting): authenticate ti=
med out after 300
2018-08-07 10:59:59.325 2b5c26347700  0 librados: client.admin authenticati=
on error (110) Connection timed out
[errno 110] error connecting to the cluster

Has anyone tried ceph rollback before? Any help is greatly appreciated.

Thanks,
Raj


--_000_SN6PR12MB270391A4AEF81C16E8A31B77BC260SN6PR12MB2703namp_
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
<p class=3D"MsoNormal">I have been running into some connection issues with=
 the latest ceph-14 version, so we thought the feasible solution would be t=
o roll back the cluster to previous version (ceph-13.0.1) where things are =
known to work properly.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m wondering if rollback/downgrade is support=
ed at all ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After compiling/starting ceph-13 I&#8217;m running i=
nto a permission error. Basically it complains about the incompatibility of=
 disk
<span style=3D"font-size:9.0pt">layout (ceph-13 mimic vs </span>ceph-14 nau=
tilus<span style=3D"font-size:9.0pt">)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:41:00.580 2b391528e080 -1 ERROR: on disk data=
 includes unsupported features: compat=3D{},rocompat=3D{},incompat=3D{11=3D=
nautilus ondisk layout}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:41:00.580 2b391528e080 -1 error checking feat=
ures: (1) Operation not permitted<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:41:11.161 2b16a7d14080&nbsp; 0 set uid:gid to=
 167:167 (ceph:ceph)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:41:11.161 2b16a7d14080&nbsp; 0 ceph version 1=
3.0.1-3266-g6b59fbf (6b59fbfcc6bbfd67193e1c1e142b478ddd68aab4) mimic (dev),=
 process (unknown), pid 14013<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:41:11.161 2b16a7d14080&nbsp; 0 pidfile_write:=
 ignore empty --pid-file<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I thought allowing permissions to mon would fix it (=
see below), but apparently ceph command hangs. So it didn&#8217;t allow per=
missions.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ceph auth add osd.44 osd 'allow *' mon 'allow profil=
e osd' -i /var/lib/ceph/osd/ceph-44/keyring<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">[root@hadoop1 my-ceph]# ceph -s<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:59:59.325 2b5c26347700&nbsp; 0 monclient(hunt=
ing): authenticate timed out after 300<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">2018-08-07 10:59:59.325 2b5c26347700&nbsp; 0 librados: clie=
nt.admin authentication error (110) Connection timed out<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">[errno 110] error connecting to the cluster<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Has anyone tried ceph rollback before? Any help is g=
reatly appreciated.<span style=3D"font-size:9.0pt;font-family:&quot;Courier=
 New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Cou=
rier New&quot;">Raj<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN6PR12MB270391A4AEF81C16E8A31B77BC260SN6PR12MB2703namp_--

--===============3606639356975087987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3606639356975087987==--
