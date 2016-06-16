From: Mykola <mykola.dvornik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number
 ofobjects in pool
Date: Thu, 16 Jun 2016 16:20:52 +0200
Message-ID: <5762b5c4.845b190a.8e665.ffff860e@mx.google.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<CA+z5Dsz=e1N9RxRoF5Wao8Dogf_S1UstNZaCJ=oj-efj83HBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0632945008=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5Dsz=e1N9RxRoF5Wao8Dogf_S1UstNZaCJ=oj-efj83HBig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0632945008==
Content-Type: multipart/alternative;
	boundary="_64B4CC98-29D4-4F9F-9C6C-1FA39B4C80A6_"

--_64B4CC98-29D4-4F9F-9C6C-1FA39B4C80A6_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

I see the same behavior with the threshold of around 20M objects for 4 node=
s, 16 OSDs, 32TB, hdd-based cluster. The issue dates back to hammer.=20

Sent from my Windows 10 phone

From: Blair Bethwaite
Sent: Thursday, June 16, 2016 2:48 PM
To: Wade Holler
Cc: Ceph Development; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] Dramatic performance drop at certain number ofobj=
ects in pool

Hi Wade,

What IO are you seeing on the OSD devices when this happens (see e.g.
iostat), are there short periods of high read IOPS where (almost) no
writes occur? What does your memory usage look like (including slab)?

Cheers,

On 16 June 2016 at 22:14, Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi All,
>
> I have a repeatable condition when the object count in a pool gets to
> 320-330 million the object write time dramatically and almost
> instantly increases as much as 10X, exhibited by fs_apply_latency
> going from 10ms to 100s of ms.
>
> Can someone point me in a direction / have an explanation ?
>
> I can add a new pool and it performs normally.
>
> Config is generally
> 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
> with NVME for journals. Centos 7.2, XFS
>
> Jewell is the release; inserting objects with librados via some Python
> test code.
>
> Best Regards
> Wade
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Cheers,
~Blairo
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--_64B4CC98-29D4-4F9F-9C6C-1FA39B4C80A6_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
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
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DEN-US link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal>I see the same behavior with the thr=
eshold of around 20M objects for 4 nodes, 16 OSDs, 32TB, hdd-based cluster.=
 The issue dates back to hammer. <o:p></o:p></p><p class=3DMsoNormal><o:p>&=
nbsp;</o:p></p><p class=3DMsoNormal>Sent from my Windows 10 phone</p><p cla=
ss=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times New Roman=
",serif'><o:p>&nbsp;</o:p></span></p><div style=3D'mso-element:para-border-=
div;border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in'><=
p class=3DMsoNormal style=3D'border:none;padding:0in'><b>From: </b><a href=
=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">Blair Bethwaite</a><br><b>Sent: </b>T=
hursday, June 16, 2016 2:48 PM<br><b>To: </b><a href=3D"mailto:wade.holler@=
gmail.com">Wade Holler</a><br><b>Cc: </b><a href=3D"mailto:ceph-devel@vger.=
kernel.org">Ceph Development</a>; <a href=3D"mailto:ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br><b>Subject: </b>Re: [ceph-users] Drama=
tic performance drop at certain number ofobjects in pool</p></div><p class=
=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times New Roman",=
serif'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>Hi Wade,</p><p clas=
s=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>What IO are you see=
ing on the OSD devices when this happens (see e.g.</p><p class=3DMsoNormal>=
iostat), are there short periods of high read IOPS where (almost) no</p><p =
class=3DMsoNormal>writes occur? What does your memory usage look like (incl=
uding slab)?</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNor=
mal>Cheers,</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNorm=
al>On 16 June 2016 at 22:14, Wade Holler &lt;wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrot=
e:</p><p class=3DMsoNormal>&gt; Hi All,</p><p class=3DMsoNormal>&gt;<o:p>&n=
bsp;</o:p></p><p class=3DMsoNormal>&gt; I have a repeatable condition when =
the object count in a pool gets to</p><p class=3DMsoNormal>&gt; 320-330 mil=
lion the object write time dramatically and almost</p><p class=3DMsoNormal>=
&gt; instantly increases as much as 10X, exhibited by fs_apply_latency</p><=
p class=3DMsoNormal>&gt; going from 10ms to 100s of ms.</p><p class=3DMsoNo=
rmal>&gt;<o:p>&nbsp;</o:p></p><p class=3DMsoNormal>&gt; Can someone point m=
e in a direction / have an explanation ?</p><p class=3DMsoNormal>&gt;<o:p>&=
nbsp;</o:p></p><p class=3DMsoNormal>&gt; I can add a new pool and it perfor=
ms normally.</p><p class=3DMsoNormal>&gt;<o:p>&nbsp;</o:p></p><p class=3DMs=
oNormal>&gt; Config is generally</p><p class=3DMsoNormal>&gt; 3 Nodes 24 ph=
ysical core each, 768GB Ram each, 16 OSD / node , all SSD</p><p class=3DMso=
Normal>&gt; with NVME for journals. Centos 7.2, XFS</p><p class=3DMsoNormal=
>&gt;<o:p>&nbsp;</o:p></p><p class=3DMsoNormal>&gt; Jewell is the release; =
inserting objects with librados via some Python</p><p class=3DMsoNormal>&gt=
; test code.</p><p class=3DMsoNormal>&gt;<o:p>&nbsp;</o:p></p><p class=3DMs=
oNormal>&gt; Best Regards</p><p class=3DMsoNormal>&gt; Wade</p><p class=3DM=
soNormal>&gt; --</p><p class=3DMsoNormal>&gt; To unsubscribe from this list=
: send the line &quot;unsubscribe ceph-devel&quot; in</p><p class=3DMsoNorm=
al>&gt; the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</p><p class=3DMs=
oNormal>&gt; More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-=
info.html</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal=
><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3D=
MsoNormal>-- </p><p class=3DMsoNormal>Cheers,</p><p class=3DMsoNormal>~Blai=
ro</p><p class=3DMsoNormal>_______________________________________________<=
/p><p class=3DMsoNormal>ceph-users mailing list</p><p class=3DMsoNormal>cep=
h-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</p><p class=3DMsoNormal>http://lists.ceph.com/listin=
fo.cgi/ceph-users-ceph.com</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></d=
iv></body></html>=

--_64B4CC98-29D4-4F9F-9C6C-1FA39B4C80A6_--


--===============0632945008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0632945008==--
