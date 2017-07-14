From: Roshni Chatterjee <roshni.chatterjee-gmN/nmo4RJN0+Iju73vM4Z/QNRX+jHPU@public.gmane.org>
Subject: Regarding Ceph Debug Logs
Date: Fri, 14 Jul 2017 11:05:42 +0000
Message-ID: <FBF2027374433749866CFD13796768DC54D4B946@EXCH-MB01-DEL.nectechnologies.in>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_005_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_"
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
To: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--_005_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_
Content-Type: multipart/alternative;
	boundary="_000_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_"

--_000_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi All,

I am new to ceph and I am trying to debug a few scenarios . I have 2 querie=
s as listed below  -
1.Regarding enabling debug logs for ceph
2.Regarding internal processes of ceph

QUERY 1 >>
I have enabled the logs by setting the log level in /etc/ceph/ceph.conf att=
ached above -

But none of this is generating information that could be used in debugging =
.
Also ,
The following CLI generates log as attached in cli_log attachment -
What are the following codes in the log like -
7f12a474c700 , 7f12895af700

QUERY 2>>

While running Ceph on LTTng , I came across multiple processes spawned like=
 tp_osd_tp ,tp_osd_recov, tp_osd_disk, osd_op ,tp_osd_cmd.
Why are these processes being spawned so many times and what is the functio=
n if each ?
If someone can share any document/link to understand the ceph internals pro=
cesses/functions/working would be highly appreciated.
Regards,
Roshni

--_000_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_
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
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hi All,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I am new to ceph and I=
 am trying to debug a few scenarios . I have 2 queries as listed below&nbsp=
; -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">1.Regarding enabling d=
ebug logs for ceph
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">2.Regarding internal p=
rocesses of ceph<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">QUERY 1 &gt;&gt;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I have enabled the log=
s by setting the log level in /etc/ceph/ceph.conf attached above &#8211;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">But none of this is ge=
nerating information that could be used in debugging .<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Also ,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">The following CLI gene=
rates log as attached in cli_log attachment &#8211;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">What are the following=
 codes in the log like &#8211;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">7f12a474c700 , 7f12895=
af700<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">QUERY 2&gt;&gt;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">While running Ceph on =
LTTng , I came across multiple processes spawned like tp_osd_tp ,tp_osd_rec=
ov, tp_osd_disk, osd_op ,tp_osd_cmd.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Why are these processe=
s being spawned so many times and what is the function if each ?<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">If someone can share a=
ny document/link to understand the ceph internals processes/functions/worki=
ng would be highly appreciated.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Regards,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Roshni<o:p></o:p></spa=
n></p>
</div>
</body>
</html>

--_000_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_--

--_005_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_
Content-Type: text/plain; name="ceph_config.txt"
Content-Description: ceph_config.txt
Content-Disposition: attachment; filename="ceph_config.txt"; size=900;
	creation-date="Fri, 14 Jul 2017 10:55:21 GMT";
	modification-date="Fri, 14 Jul 2017 10:55:21 GMT"
Content-Transfer-Encoding: base64

W2dsb2JhbF0NCmZzaWQgPSBlYmM1MjhmYS02MWY1LTQ0YmUtYjNkZi01YWY5MmZjZTkzNzkNCm1v
bl9pbml0aWFsX21lbWJlcnMgPSBjZXBoLWFkbWluDQptb25faG9zdCA9IDEwLjAuNC4xMTgNCmF1
dGhfY2x1c3Rlcl9yZXF1aXJlZCA9IGNlcGh4DQphdXRoX3NlcnZpY2VfcmVxdWlyZWQgPSBjZXBo
eA0KYXV0aF9jbGllbnRfcmVxdWlyZWQgPSBjZXBoeA0Kb3NkIHBvb2wgZGVmYXVsdCBzaXplID0g
MSAgIyBXcml0ZSBhbiBvYmplY3QgbiB0aW1lcy4NCm9zZCBwb29sIGRlZmF1bHQgbWluIHNpemUg
PSAxICMgQWxsb3cgd3JpdGluZyBuIGNvcHkgaW4gYSBkZWdyYWRlZCBzdGF0ZS4NCm9zZCBwb29s
IGRlZmF1bHQgcGcgbnVtID0gMTI4DQpvc2QgcG9vbCBkZWZhdWx0IHBncCBudW0gPSAxMjgNCmRl
YnVnIG1zID0gMS81DQpkZWJ1ZyB0cCBsb2cgPSAxLzIwDQpvc2RfdHJhY2luZyA9IHRydWUNCm9z
ZF9vYmplY3RzdG9yZV90cmFjaW5nID0gdHJ1ZQ0KcmFkb3NfdHJhY2luZyA9IHRydWUNCnJiZF90
cmFjaW5nID0gdHJ1ZQ0KDQpbbW9uXQ0KICAgICAgICBkZWJ1ZyBtb24gPSAyMA0KICAgICAgICBk
ZWJ1ZyBwYXhvcyA9IDEvNQ0KICAgICAgICBkZWJ1ZyBhdXRoID0gMg0KDQpbb3NkXQ0KICAgICAg
ICBkZWJ1ZyBvc2QgPSAxLzUNCiAgICAgICAgZGVidWcgZmlsZXN0b3JlID0gMS81DQogICAgICAg
IGRlYnVnIGpvdXJuYWwgPSAxDQogICAgICAgIGRlYnVnIG1vbmMgPSA1LzIwDQoNClttZHNdDQog
ICAgICAgIGRlYnVnIG1kcyA9IDENCiAgICAgICAgZGVidWcgbWRzIGJhbGFuY2VyID0gMQ0KICAg
ICAgICBkZWJ1ZyBtZHMgbG9nID0gMQ0KICAgICAgICBkZWJ1ZyBtZHMgbWlncmF0b3IgPSAxDQoN
CmxvZyB0byBzeXNsb2cgPSB0cnVlDQplcnIgdG8gc3lzbG9nID0gdHJ1ZQ0K

--_005_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_
Content-Type: text/plain; name="cli_log.txt"
Content-Description: cli_log.txt
Content-Disposition: attachment; filename="cli_log.txt"; size=627;
	creation-date="Fri, 14 Jul 2017 10:57:03 GMT";
	modification-date="Fri, 14 Jul 2017 10:57:03 GMT"
Content-Transfer-Encoding: base64

cm9vdEBjZXBoLWFkbWluOi9ob21lL2NlcGh1c2VyL2NsdXN0ZXIjIHJiZCAtLXBvb2wgbXlwb29s
IHNuYXAgY3JlYXRlIC0tc25hcCBteXNuYXBfbXlpbWFnZTE4IG15aW1hZ2UNCjIwMTctMDctMTMg
MTc6MjA6NDEuMTA3MjEwIDdmMTJhNDc1OTEwMCAgMSAtLSA6LzAgbWVzc2VuZ2VyLnN0YXJ0DQoy
MDE3LTA3LTEzIDE3OjIwOjQxLjEwODMwOCA3ZjEyYTQ3NTkxMDAgIDEgLS0gOi83ODIzNTEzNzAg
LS0+IDEwLjAuNC4xMTg6Njc4OS8wIC0tIGF1dGgocHJvdG8gMCAzMCBieXRlcyBlcG9jaCAwKSB2
MSAtLSA/KzAgMHg1NTdiOTcxZDc1YTAgY29uIDB4NTU3Yjk3MWQ3MDIwDQoyMDE3LTA3LTEzIDE3
OjIwOjQxLjExMTk3MiA3ZjEyYTQ3NGM3MDAgIDEgLS0gMTAuMC40LjExODowLzc4MjM1MTM3MCBs
ZWFybmVkIG15IGFkZHIgMTAuMC40LjExODowLzc4MjM1MTM3MA0KMjAxNy0wNy0xMyAxNzoyMDo0
MS4xMTI2MjUgN2YxMjg5NWFmNzAwICAxIC0tIDEwLjAuNC4xMTg6MC83ODIzNTEzNzAgPD09IG1v
bi4wIDEwLjAuNC4xMTg6Njc4OS8wIDEgPT09PSBtb25fbWFwIG1hZ2ljOiAwIHYxID09PT0gMjAw
KzArMCAoMjAxNDgyNjA0NiAwIDApIDB4N2YxMjc0MDAwYmMwIGNvbiAweDU1N2I5NzFkNzAyMA0K

--_005_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--_005_FBF2027374433749866CFD13796768DC54D4B946EXCHMB01DELnect_--
