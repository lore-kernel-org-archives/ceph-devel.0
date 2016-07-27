From: David Blundell <David.Blundell-7ie3GnOy+6yuWcBOZErdyg@public.gmane.org>
Subject: Listing objects in a specified placement group / OSD
Date: Wed, 27 Jul 2016 15:10:05 +0000
Message-ID: <VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0@VI1PR0701MB2542.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1018313355=="
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
To: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1018313355==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0VI1PR0701MB2542_"

--_000_VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0VI1PR0701MB2542_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I wasn't sure if this is a ceph-users or ceph-devel question as it's about =
the API (users) but the answer may involve me writing a RADOS method (devel=
).

At the moment in Ceph Jewel I can find which objects are held in an OSD or =
placement group by looking on the filesystem under /var/lib/ceph/osd/ceph-*=
/current

This requires access to the OSD host and may well break when using Bluestor=
e if there is no filesystem to look through.  I would like to be able to li=
st objects in a specified PG/OSD from outside of the OSD host using Ceph co=
mmands.

I can list all PGs hosted on OSD 1 using "ceph pg ls-by-osd osd.1" and coul=
d loop through this output if there was a way to list the objects in a PG.

I have checked the API and librados docs (I would be happy to hack somethin=
g together using librados) and can't see any obvious way to list the object=
s in a PG.

I have seen a post on this mailing list from Ilya last September saying:
"Internally there is a way to list objects within a specific PG (actually m=
ore than one way IIRC), but I don't think anything like that is exposed in =
a CLI (it might be exposed in librados though)."

but could not find any follow up posts with details.

Does anyone have any more details on these internal methods and how to call=
 them?

Cheers,

David

--_000_VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0VI1PR0701MB2542_
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
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I wasn&#8217;t sure if this is a ceph-users or ceph-=
devel question as it&#8217;s about the API (users) but the answer may invol=
ve me writing a RADOS method (devel).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At the moment in Ceph Jewel I can find which objects=
 are held in an OSD or placement group by looking on the filesystem under /=
var/lib/ceph/osd/ceph-*/current<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This requires access to the OSD host and may well br=
eak when using Bluestore if there is no filesystem to look through.&nbsp; I=
 would like to be able to list objects in a specified PG/OSD from outside o=
f the OSD host using Ceph commands.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I can list all PGs hosted on OSD 1 using &#8220;ceph=
 pg ls-by-osd osd.1&#8221; and could loop through this output if there was =
a way to list the objects in a PG.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have checked the API and librados docs (I would be=
 happy to hack something together using librados) and can&#8217;t see any o=
bvious way to list the objects in a PG.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have seen a post on this mailing list from Ilya la=
st September saying:<o:p></o:p></p>
<p class=3D"MsoNormal">&#8220;Internally there is a way to list objects wit=
hin a specific PG (actually more than one way IIRC), but I don't think anyt=
hing like that is exposed in a CLI (it might be exposed in librados though)=
.&#8221;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">but could not find any follow up posts with details.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does anyone have any more details on these internal =
methods and how to call them?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Cheers,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">David<o:p></o:p></p>
</div>
</body>
</html>

--_000_VI1PR0701MB25427A0DF5F4308CC5D8C135A60F0VI1PR0701MB2542_--

--===============1018313355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1018313355==--
