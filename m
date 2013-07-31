From: Luke Jing Yuan <jyluke-YhiXQ1Q1pWA@public.gmane.org>
Subject: Problem with MON after reboot
Date: Wed, 31 Jul 2013 10:09:08 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A4F9C66@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1521396591=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1521396591==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E0E280CCE0E1A44898C992A9190D929A4F9C66MBX02TPMmimosloca_"

--_000_E0E280CCE0E1A44898C992A9190D929A4F9C66MBX02TPMmimosloca_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,

I am having a issue with MON after reboot, I had originally 3 MONs but afte=
r rebooting one of them, the quorum cannot be established. Digging through =
the log of the problematic MON, I found the following messages:

2013-07-31 18:04:18.536331 7f4f41bfd700  0 -- 10.4.132.18:6804/0 >> 10.4.13=
1.21:6800/0 pipe(0x305da00 sd=3D28 :41077 s=3D1 pgs=3D0 cs=3D0 l=3D0).faile=
d verifying authorize reply
2013-07-31 18:04:20.536270 7f4f48b3e700  0 cephx: verify_reply coudln't dec=
rypt with error: error decoding block for decryption
2013-07-31 18:04:20.536276 7f4f48b3e700  0 -- 10.4.132.18:6804/0 >> 10.4.12=
0.21:6789/0 pipe(0x305dc80 sd=3D27 :38003 s=3D1 pgs=3D0 cs=3D0 l=3D0).faile=
d verifying authorize reply
2013-07-31 18:04:20.536302 7f4f41bfd700  0 cephx: verify_reply coudln't dec=
rypt with error: error decoding block for decryption

Wonder if someone can shed some light on the issue and how to solve this pr=
oblem. Thanks.

Regards,
Luke



------------------------------------------------------------------
-
-
DISCLAIMER: 

This e-mail (including any attachments) is for the addressee(s) 
only and may contain confidential information. If you are not the 
intended recipient, please note that any dealing, review, 
distribution, printing, copying or use of this e-mail is strictly 
prohibited. If you have received this email in error, please notify 
the sender  immediately and delete the original message. 
MIMOS Berhad is a research and development institution under 
the purview of the Malaysian Ministry of Science, Technology and 
Innovation. Opinions, conclusions and other information in this e-
mail that do not relate to the official business of MIMOS Berhad 
and/or its subsidiaries shall be understood as neither given nor 
endorsed by MIMOS Berhad and/or its subsidiaries and neither 
MIMOS Berhad nor its subsidiaries accepts responsibility for the 
same. All liability arising from or in connection with computer 
viruses and/or corrupted e-mails is excluded to the fullest extent 
permitted by law.


--_000_E0E280CCE0E1A44898C992A9190D929A4F9C66MBX02TPMmimosloca_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
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
<body lang=3D"EN-MY" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Dear all,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am having a issue with MON af=
ter reboot, I had originally 3 MONs but after rebooting one of them, the qu=
orum cannot be established. Digging through the log of the problematic MON,=
 I found the following messages:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-07-31 18:04:18.536331 7f4f=
41bfd700&nbsp; 0 -- 10.4.132.18:6804/0 &gt;&gt; 10.4.131.21:6800/0 pipe(0x3=
05da00 sd=3D28 :41077 s=3D1 pgs=3D0 cs=3D0 l=3D0).failed verifying authoriz=
e reply<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-07-31 18:04:20.536270 7f4f=
48b3e700&nbsp; 0 cephx: verify_reply coudln't decrypt with error: error dec=
oding block for decryption<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-07-31 18:04:20.536276 7f4f=
48b3e700&nbsp; 0 -- 10.4.132.18:6804/0 &gt;&gt; 10.4.120.21:6789/0 pipe(0x3=
05dc80 sd=3D27 :38003 s=3D1 pgs=3D0 cs=3D0 l=3D0).failed verifying authoriz=
e reply<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-07-31 18:04:20.536302 7f4f=
41bfd700&nbsp; 0 cephx: verify_reply coudln't decrypt with error: error dec=
oding block for decryption<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Wonder if someone can shed some=
 light on the issue and how to solve this problem. Thanks.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Luke<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

<p>

------------------------------------------------------------------
-
-
DISCLAIMER: 

This e-mail (including any attachments) is for the addressee(s) 
only and may contain confidential information. If you are not the 
intended recipient, please note that any dealing, review, 
distribution, printing, copying or use of this e-mail is strictly 
prohibited. If you have received this email in error, please notify 
the sender  immediately and delete the original message. 
MIMOS Berhad is a research and development institution under 
the purview of the Malaysian Ministry of Science, Technology and 
Innovation. Opinions, conclusions and other information in this e-
mail that do not relate to the official business of MIMOS Berhad 
and/or its subsidiaries shall be understood as neither given nor 
endorsed by MIMOS Berhad and/or its subsidiaries and neither 
MIMOS Berhad nor its subsidiaries accepts responsibility for the 
same. All liability arising from or in connection with computer 
viruses and/or corrupted e-mails is excluded to the fullest extent 
permitted by law.


</p>
--_000_E0E280CCE0E1A44898C992A9190D929A4F9C66MBX02TPMmimosloca_--

--===============1521396591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1521396591==--
