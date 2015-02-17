From: Tyler Brekke <tbrekke-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance comparison
Date: Tue, 17 Feb 2015 12:24:15 -0800
Message-ID: <CA+MRXrFX_Z14JXoMY47uZHKTmDxrHNUGYjkw16XtoES9ieAnCg@mail.gmail.com>
References: <54E37C3D.5030702@redhat.com>
	<CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1550415790=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Stephen Hindle <shindle-zIyXdg6N6CA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1550415790==
Content-Type: multipart/alternative; boundary=001a1134fd4c96a1ae050f4e7c0e

--001a1134fd4c96a1ae050f4e7c0e
Content-Type: text/plain; charset=UTF-8

https://github.com/ceph/ceph-tools/tree/master/cbt

On Tue, Feb 17, 2015 at 12:16 PM, Stephen Hindle <shindle-zIyXdg6N6CA@public.gmane.org> wrote:

> I was wondering what the 'CBT' tool is ?  Google is useless for that
> acronym...
>
> Thanks!
> Steve
>
> On Tue, Feb 17, 2015 at 10:37 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Hi All,
> >
> > I wrote up a short document describing some tests I ran recently to look
> at
> > how SSD backed OSD performance has changed across our LTS releases. This
> is
> > just looking at RADOS performance and not RBD or RGW.  It also doesn't
> offer
> > any real explanations regarding the results.  It's just a first high
> level
> > step toward understanding some of the behaviors folks on the mailing list
> > have reported over the last couple of releases.  I hope you find it
> useful.
> >
> > Mark
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>
> --
> The information in this message may be confidential.  It is intended solely
> for
> the addressee(s).  If you are not the intended recipient, any disclosure,
> copying or distribution of the message, or any action or omission taken by
> you
> in reliance on it, is prohibited and may be unlawful.  Please immediately
> contact the sender if you have received this message in error.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a1134fd4c96a1ae050f4e7c0e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a href=3D"https://github.com/ceph/ceph-tools/tree/master/=
cbt">https://github.com/ceph/ceph-tools/tree/master/cbt</a><br></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Feb 17, 2015 at=
 12:16 PM, Stephen Hindle <span dir=3D"ltr">&lt;<a href=3D"mailto:shindle@l=
lnw.com" target=3D"_blank">shindle-zIyXdg6N6CA@public.gmane.org</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">I was wondering what the &#39;CBT&#39; tool is ?=
=C2=A0 Google is useless for that acronym...<br>
<br>
Thanks!<br>
Steve<br>
<div><div class=3D"h5"><br>
On Tue, Feb 17, 2015 at 10:37 AM, Mark Nelson &lt;<a href=3D"mailto:mnelson=
@redhat.com">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; I wrote up a short document describing some tests I ran recently to lo=
ok at<br>
&gt; how SSD backed OSD performance has changed across our LTS releases. Th=
is is<br>
&gt; just looking at RADOS performance and not RBD or RGW.=C2=A0 It also do=
esn&#39;t offer<br>
&gt; any real explanations regarding the results.=C2=A0 It&#39;s just a fir=
st high level<br>
&gt; step toward understanding some of the behaviors folks on the mailing l=
ist<br>
&gt; have reported over the last couple of releases.=C2=A0 I hope you find =
it useful.<br>
&gt;<br>
&gt; Mark<br>
&gt;<br>
</div></div><span class=3D"">&gt; _________________________________________=
______<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt;<br>
<br>
--<br>
</span>The information in this message may be confidential.=C2=A0 It is int=
ended solely<br>
for<br>
the addressee(s).=C2=A0 If you are not the intended recipient, any disclosu=
re,<br>
copying or distribution of the message, or any action or omission taken by<=
br>
you<br>
in reliance on it, is prohibited and may be unlawful.=C2=A0 Please immediat=
ely<br>
contact the sender if you have received this message in error.<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div><br></div>

--001a1134fd4c96a1ae050f4e7c0e--

--===============1550415790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1550415790==--
