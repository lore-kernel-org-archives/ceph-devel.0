From: <ghislain.chevalier-C0LM0jrOve7QT0dZR+AlfA@public.gmane.org>
Subject: Re: Placement rule not resolved
Date: Thu, 8 Oct 2015 08:46:51 +0000
Message-ID: <12568_1444294012_56162D7C_12568_6432_1_B9C8EFBF13B1354DB5FA000660D66DD00D62A344@OPEXCLILM22.corporate.adroot.infra.ftgroup>
References: <23204_1444133907_5613BC13_23204_5280_1_B9C8EFBF13B1354DB5FA000660D66DD00D628B08@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0384664275=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <23204_1444133907_5613BC13_23204_5280_1_B9C8EFBF13B1354DB5FA000660D66DD00D628B08-k51ZJH/FVDxQjRhWRvBICp/8k8S00WyQ9RRJHHJ2uONh6fmJljyAuS2tgHokHsZO@public.gmane.org>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0384664275==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_B9C8EFBF13B1354DB5FA000660D66DD00D62A344OPEXCLILM22corp_"


--_000_B9C8EFBF13B1354DB5FA000660D66DD00D62A344OPEXCLILM22corp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI all,

I didn't notice that osd reweight for ssd was curiously set to a low value.
I don't know how and when these values were set so low.
Our environment is Mirantis-driven and the installation was powered by fuel=
 and puppet.
(the installation was run by the openstack team and I checked the ceph clus=
ter configuration afterwards)

After reweighing them to 1, the ceph-cluster is working properly.
Thanks to object lookup module of inkscope, I checked that the osd allocati=
on was ok.

What is not normal is that crush tried to allocated osd that are not target=
ed by the rule in that case sas disks instead of ssd disks?
Must the cluster normal behavior ,i.e. the pg allocation, be  to be frozen?
I can say that because if I analyze the stuck pgs (inkscope module) and not=
iced that osd allocation for these pgs were either not correct (acting list=
) or uncomplete.

Best regards

De : ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] De la part de gh=
islain.chevalier-C0LM0jrOve7QT0dZR+AlfA@public.gmane.org
Envoy=E9 : mardi 6 octobre 2015 14:18
=C0 : ceph-users
Objet : [ceph-users] Placement rule not resolved

Hi,

Context:
Firefly 0.80.9
8 storage nodes
176 osds : 14*8 sas and 8*8 ssd
3 monitors

I create an alternate crushmap in order to fulfill tiering requirement i.e.=
 select ssd or sas.
I created specific buckets "host-ssd" and "host-sas" and regroup them in "t=
ier-ssd" and "tier-sas" under a "tier-root"
E.g. I want to select 1 ssd in 3 distinct hosts

I don't understand why the placement rule for sas is working and not for ss=
d.
Sas are selected even if ,according to the crushmap,  they are not in the r=
ight tree.
When sometimes 3 ssd are selected, the pgs stay stuck but active

I attached the crushmap and ceph osd tree.

Can someone have a look and tell me where the default is?

Bgrds
- - - - - - - - - - - - - - - - -
Ghislain Chevalier
ORANGE/IMT/OLPS/ASE/DAPI/CSE
Architecte de services d'infrastructure de stockage
Sofware-Defined Storage Architect
+33299124432
+33788624370
ghislain.chevalier-C0LM0jrOve7QT0dZR+AlfA@public.gmane.org<mailto:ghislain.chevalier-XHOcgOChp64iX52Nu+e+E9BPR1lH4CV8@public.gmane.org>
P Pensez =E0 l'Environnement avant d'imprimer ce message !


___________________________________________________________________________=
______________________________________________



Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc

pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler

a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,

Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.



This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;

they should not be distributed, used or copied without authorisation.

If you have received this email in error, please notify the sender and dele=
te this message and its attachments.

As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.

Thank you.

___________________________________________________________________________=
______________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.


--_000_B9C8EFBF13B1354DB5FA000660D66DD00D62A344OPEXCLILM22corp_
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
@font-face
	{font-family:Georgia;
	panose-1:2 4 5 2 5 4 5 2 3 3;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:Webdings;
	panose-1:5 3 1 2 1 5 9 6 7 3;}
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
pre
	{mso-style-priority:99;
	mso-style-link:"Pr=E9format=E9 HTML Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PrformatHTMLCar
	{mso-style-name:"Pr=E9format=E9 HTML Car";
	mso-style-priority:99;
	mso-style-link:"Pr=E9format=E9 HTML";
	font-family:Consolas;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">HI all,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I didn&#8217;t notice =
that osd reweight for ssd was curiously set to a low value.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I don&#8217;t know how=
 and when these values were set so low.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Our environment is Mir=
antis-driven and the installation was powered by fuel and puppet.<br>
(the installation was run by the openstack team and I checked the ceph clus=
ter configuration afterwards)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">After reweighing them =
to 1, the ceph-cluster is working properly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Thanks to object looku=
p module of inkscope, I checked that the osd allocation was ok.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">What is not normal is =
that crush tried to allocated osd that are not targeted by the rule in that=
 case sas disks instead of ssd disks?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Must the cluster norma=
l behavior ,i.e. the pg allocation, be&nbsp; to be frozen?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I can say that because=
 if I analyze the stuck pgs (inkscope module) and noticed that osd allocati=
on for these pgs were either not correct (acting list) or uncomplete.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Best regards<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">De&nbsp;:</span></b><span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> ceph=
-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org]
<b>De la part de</b> ghislain.chevali</span><span lang=3D"FR" style=3D"font=
-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">er@oran=
ge.com<br>
<b>Envoy=E9&nbsp;:</b> mardi 6 octobre 2015 14:18<br>
<b>=C0&nbsp;:</b> ceph-users<br>
<b>Objet&nbsp;:</b> [ceph-users] Placement rule not resolved<o:p></o:p></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Context:<o:p></o:p></p>
<p class=3D"MsoNormal">Firefly 0.80.9<o:p></o:p></p>
<p class=3D"MsoNormal">8 storage nodes<o:p></o:p></p>
<p class=3D"MsoNormal">176 osds : 14*8 sas and 8*8 ssd<o:p></o:p></p>
<p class=3D"MsoNormal">3 monitors <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I create an alternate crushmap in order to fulfill t=
iering requirement i.e. select ssd or sas.<o:p></o:p></p>
<p class=3D"MsoNormal">I created specific buckets &#8220;host-ssd&#8221; an=
d &#8220;host-sas&#8221; and regroup them in &#8220;tier-ssd&#8221; and &#8=
220;tier-sas&#8221; under a &#8220;tier-root&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal">E.g. I want to select 1 ssd in 3 distinct hosts<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I don&#8217;t understand why the placement rule for =
sas is working and not for ssd.
<o:p></o:p></p>
<p class=3D"MsoNormal">Sas are selected even if ,according to the crushmap,=
 &nbsp;they are not in the right tree.<o:p></o:p></p>
<p class=3D"MsoNormal">When sometimes 3 ssd are selected, the pgs stay stuc=
k but active
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I attached the crushmap and ceph osd tree.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can someone have a look and tell me where the defaul=
t is?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Bgrds<o:p></o:p></p>
<p class=3D"MsoNormal"><b><span lang=3D"FR" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black">- - - - - - - =
- - - - - - - - - -</span></b><span lang=3D"FR">
<br>
</span><b><span lang=3D"FR" style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,&quot;sans-serif&quot;;color:black">Ghislain Chevalier</span></b><=
span lang=3D"FR"><br>
</span><span lang=3D"FR" style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,&quot;sans-serif&quot;;color:black">ORANGE/IMT/OLPS/ASE/DAPI/CSE<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black">Architecte de ser=
vices d&#8217;infrastructure de stockage<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:black">Sofware-Defined Storage Archi=
tect<br>
&#43;33299124432<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:black">&#43;33788624370<br>
</span><span lang=3D"FR"><a href=3D"mailto:ghislain.chevalier@orange-ftgrou=
p.com"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,&quot;sans-serif&quot;;color:#FF6600">ghislain.chevalier-C0LM0jrOve5hl2p70BpVqQ@public.gmane.org=
m</span></a>
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><b><span lang=3D"FR" style=3D"font-size:24.0pt;font-=
family:Webdings;color:green">P</span></b><b><span lang=3D"FR" style=3D"font=
-family:&quot;Georgia&quot;,&quot;serif&quot;;color:blue">&nbsp;</span></b>=
<span lang=3D"FR" style=3D"font-size:7.5pt;font-family:&quot;Tahoma&quot;,&=
quot;sans-serif&quot;;color:green">Pensez
 =E0</span><b><span lang=3D"FR"> </span></b><b><span lang=3D"FR" style=3D"f=
ont-size:7.5pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:=
green">l'Environnement avant d'imprimer ce message !</span></b><span lang=
=3D"FR">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR"><o:p>&nbsp;</o:p></span></p>
<pre>______________________________________________________________________=
___________________________________________________<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Ce message et ses pieces jointes peuvent contenir des informations con=
fidentielles ou privilegiees et ne doivent donc<o:p></o:p></pre>
<pre>pas etre diffuses, exploites ou copies sans autorisation. Si vous avez=
 recu ce message par erreur, veuillez le signaler<o:p></o:p></pre>
<pre>a l'expediteur et le detruire ainsi que les pieces jointes. Les messag=
es electroniques etant susceptibles d'alteration,<o:p></o:p></pre>
<pre>Orange decline toute responsabilite si ce message a ete altere, deform=
e ou falsifie. Merci.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>This message and its attachments may contain confidential or privilege=
d information that may be protected by law;<o:p></o:p></pre>
<pre>they should not be distributed, used or copied without authorisation.<=
o:p></o:p></pre>
<pre>If you have received this email in error, please notify the sender and=
 delete this message and its attachments.<o:p></o:p></pre>
<pre>As emails may be altered, Orange is not liable for messages that have =
been modified, changed or falsified.<o:p></o:p></pre>
<pre>Thank you.<o:p></o:p></pre>
</div>
<PRE>______________________________________________________________________=
___________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.
</PRE></body>
</html>

--_000_B9C8EFBF13B1354DB5FA000660D66DD00D62A344OPEXCLILM22corp_--

--===============0384664275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0384664275==--
