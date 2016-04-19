From: =?UTF-8?B?5bit5pm65YuH?= <xizhiyong18-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph Day Sunnyvale Presentations
Date: Tue, 19 Apr 2016 17:34:27 +0800
Message-ID: <CAPBvRV-gnmNdOCJ_3TZppethZP=cf=xFnCPf0r4Eu=9gBB_c-Q@mail.gmail.com>
References: <CAAZbbf0FKTCOrxBcdKCma+f2Z6faXocqt11p8v6urE-4hu9irA@mail.gmail.com>
	<754505492.304458062.1460519131018.JavaMail.zimbra@oxygem.tv>
	<1638204634.9581897.1460519761671.JavaMail.zimbra@redhat.com>
	<1709620787.306483306.1460542270487.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0156096171=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1709620787.306483306.1460542270487.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, bspark8-AlITWu1pwT4@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0156096171==
Content-Type: multipart/alternative; boundary=001a113efaaef1da0a0530d32e13

--001a113efaaef1da0a0530d32e13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have read the SK=E2=80=98s performance tuning work too, it's a good
job especially the analysis of write/read latancy on OSD.
I want to ask a question about the optimize on 'Long logging time', what's
the meaning about 'split logging into another thread and do it later',
AFAIK, ceph does logging async by logging thread.
Can you share more info?

2016-04-13 18:11 GMT+08:00 Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>:

> >>Based on discussion with them at Ceph day in Tokyo JP, they have their
> own frozen the Ceph repository.
> >>And they've been optimizing codes by their own team to meet their
> requirements.
> >>AFAICT they had not done any do PR.
>
> Thanks for the info
>
> @cc bspark8.sk.com : maybe can you give us more informations ?
>
>
> ----- Mail original -----
> De: "Shinobu Kinjo" <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> Cc: "Patrick McGarry" <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
> Envoy=C3=A9: Mercredi 13 Avril 2016 05:56:01
> Objet: Re: [ceph-users] Ceph Day Sunnyvale Presentations
>
> Alexandre,
>
> Based on discussion with them at Ceph day in Tokyo JP, they have their ow=
n
> frozen the Ceph repository.
> And they've been optimizing codes by their own team to meet their
> requirements.
> AFAICT they had not done any do PR.
>
> Cheers,
> Shinobu
>
> ----- Original Message -----
> From: "Alexandre DERUMIER" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> To: "Patrick McGarry" <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-Qp0mS5GaXlQ@public.gmane.org>
> Sent: Wednesday, April 13, 2016 12:45:31 PM
> Subject: Re: [ceph-users] Ceph Day Sunnyvale Presentations
>
> Hi,
>
> I was reading this presentation from SK telecom about flash optimisations
>
> AFCeph: Ceph Performance Analysis & Improvement on Flash [Slides]
>
> http://fr.slideshare.net/Inktank_Ceph/af-ceph-ceph-performance-analysis-a=
nd-improvement-on-flash
> Byung-Su Park, SK Telecom
>
>
> They seem to have made optimisations in ceph code. Is there any patches
> reference ? (applied to infernalis/jewel ?)
>
>
> They seem also to have done ceph config tuning and system tunning, but no
> config details is provided :(
> It could be great to share with the community :)
>
> Regards,
>
> Alexandre
>
> ----- Mail original -----
> De: "Patrick McGarry" <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =C3=80: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-Qp0mS5GaXlQ@public.gmane.org>
> Envoy=C3=A9: Mercredi 6 Avril 2016 18:18:28
> Objet: [ceph-users] Ceph Day Sunnyvale Presentations
>
> Hey cephers,
>
> I have all but one of the presentations from Ceph Day Sunnyvale, so
> rather than wait for a full hand I went ahead and posted the link to
> the slides on the event page:
>
> http://ceph.com/cephdays/ceph-day-sunnyvale/
>
> The videos probably wont be processed until after next week, but I=E2=80=
=99ll
> add those once we get them. Thanks to all of the presenters and
> attendees that made this another great event.
>
>
> --
>
> Best Regards,
>
> Patrick McGarry
> Director Ceph Community || Red Hat
> http://ceph.com || http://community.redhat.com
> @scuttlemonkey || @ceph
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113efaaef1da0a0530d32e13
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have read the SK=E2=80=98s performance tuning work too, =
it&#39;s a good job=C2=A0especially the=C2=A0analysis of write/read latancy=
 on OSD.<div>I want to ask a question about the optimize on &#39;Long loggi=
ng time&#39;, what&#39;s the meaning about &#39;split logging into another =
thread and do it later&#39;, AFAIK, ceph does logging async by logging thre=
ad.</div><div>Can you share more info?</div></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">2016-04-13 18:11 GMT+08:00 Alexandre DERUM=
IER <span dir=3D"ltr">&lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;</span>:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><span class=3D"">&gt;&gt;Based on discussion with them at Ceph day in To=
kyo JP, they have their own frozen the Ceph repository.<br>
&gt;&gt;And they&#39;ve been optimizing codes by their own team to meet the=
ir requirements.<br>
&gt;&gt;AFAICT they had not done any do PR.<br>
<br>
</span>Thanks for the info<br>
<br>
@cc <a href=3D"http://bspark8.sk.com" rel=3D"noreferrer" target=3D"_blank">=
bspark8.sk.com</a> : maybe can you give us more informations ?<br>
<br>
<br>
----- Mail original -----<br>
De: &quot;Shinobu Kinjo&quot; &lt;<a href=3D"mailto:skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">skin=
jo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
=C3=80: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">ad=
erumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: &quot;Patrick McGarry&quot; &lt;<a href=3D"mailto:pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;, &quot;ceph-devel&quot; &lt;<a href=3D"mailto:c=
eph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-u=
sers&quot; &lt;<a href=3D"mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org">ceph-users-Qp0mS5GaXlQ@public.gmane.org</=
a>&gt;<br>
Envoy=C3=A9: Mercredi 13 Avril 2016 05:56:01<br>
Objet: Re: [ceph-users] Ceph Day Sunnyvale Presentations<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
Alexandre,<br>
<br>
Based on discussion with them at Ceph day in Tokyo JP, they have their own =
frozen the Ceph repository.<br>
And they&#39;ve been optimizing codes by their own team to meet their requi=
rements.<br>
AFAICT they had not done any do PR.<br>
<br>
Cheers,<br>
Shinobu<br>
<br>
----- Original Message -----<br>
From: &quot;Alexandre DERUMIER&quot; &lt;<a href=3D"mailto:aderumier@odiso.=
com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
To: &quot;Patrick McGarry&quot; &lt;<a href=3D"mailto:pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Cc: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=
">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<a href=3D=
"mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org">ceph-users-Qp0mS5GaXlQ@public.gmane.org</a>&gt;<br>
Sent: Wednesday, April 13, 2016 12:45:31 PM<br>
Subject: Re: [ceph-users] Ceph Day Sunnyvale Presentations<br>
<br>
Hi,<br>
<br>
I was reading this presentation from SK telecom about flash optimisations<b=
r>
<br>
AFCeph: Ceph Performance Analysis &amp; Improvement on Flash [Slides]<br>
<a href=3D"http://fr.slideshare.net/Inktank_Ceph/af-ceph-ceph-performance-a=
nalysis-and-improvement-on-flash" rel=3D"noreferrer" target=3D"_blank">http=
://fr.slideshare.net/Inktank_Ceph/af-ceph-ceph-performance-analysis-and-imp=
rovement-on-flash</a><br>
Byung-Su Park, SK Telecom<br>
<br>
<br>
They seem to have made optimisations in ceph code. Is there any patches ref=
erence ? (applied to infernalis/jewel ?)<br>
<br>
<br>
They seem also to have done ceph config tuning and system tunning, but no c=
onfig details is provided :(<br>
It could be great to share with the community :)<br>
<br>
Regards,<br>
<br>
Alexandre<br>
<br>
----- Mail original -----<br>
De: &quot;Patrick McGarry&quot; &lt;<a href=3D"mailto:pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
=C3=80: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<a hre=
f=3D"mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org">ceph-users-Qp0mS5GaXlQ@public.gmane.org</a>&gt;<br>
Envoy=C3=A9: Mercredi 6 Avril 2016 18:18:28<br>
Objet: [ceph-users] Ceph Day Sunnyvale Presentations<br>
<br>
Hey cephers,<br>
<br>
I have all but one of the presentations from Ceph Day Sunnyvale, so<br>
rather than wait for a full hand I went ahead and posted the link to<br>
the slides on the event page:<br>
<br>
<a href=3D"http://ceph.com/cephdays/ceph-day-sunnyvale/" rel=3D"noreferrer"=
 target=3D"_blank">http://ceph.com/cephdays/ceph-day-sunnyvale/</a><br>
<br>
The videos probably wont be processed until after next week, but I=E2=80=99=
ll<br>
add those once we get them. Thanks to all of the presenters and<br>
attendees that made this another great event.<br>
<br>
<br>
--<br>
<br>
Best Regards,<br>
<br>
Patrick McGarry<br>
Director Ceph Community || Red Hat<br>
<a href=3D"http://ceph.com" rel=3D"noreferrer" target=3D"_blank">http://cep=
h.com</a> || <a href=3D"http://community.redhat.com" rel=3D"noreferrer" tar=
get=3D"_blank">http://community.redhat.com</a><br>
@scuttlemonkey || @ceph<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</div></div></blockquote></div><br></div>

--001a113efaaef1da0a0530d32e13--

--===============0156096171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0156096171==--
