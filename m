From: =?UTF-8?B?0JjRgNC10Log0KTQsNGB0LjRhdC+0LI=?= <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: firefly timing
Date: Tue, 18 Mar 2014 11:13:45 +0400
Message-ID: <CAF-rypyVjvuddtaj=cW_yJowzGzCq0m7LgW6S=2zK1aAvsfrTA@mail.gmail.com>
References: <alpine.DEB.2.00.1403172115140.24236@cobra.newdream.net>
	<5327F0A7.8010105@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0320427989=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5327F0A7.8010105-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0320427989==
Content-Type: multipart/alternative; boundary=485b397dd299ddab8e04f4dc46b7

--485b397dd299ddab8e04f4dc46b7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm ready to test the tiering.


2014-03-18 11:07 GMT+04:00 Stefan Priebe - Profihost AG <
s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>:

> Hi Sage,
>
> i really would like to test the tiering. Is there any detailed
> documentation about it and how it works?
>
> Greets,
> Stefan
>
> Am 18.03.2014 05:45, schrieb Sage Weil:
> > Hi everyone,
> >
> > It's taken longer than expected, but the tests for v0.78 are calming do=
wn
> > and it looks like we'll be able to get the release out this week.
> >
> > However, we've decided NOT to make this release firefly.  It will be a
> > normal development release.  This will be the first release that includ=
es
> > some key new functionality (erasure coding and cache tiering) and
> although
> > it is passing our tests we'd like to have some operational experience
> with
> > it in more users' hands before we commit to supporting it long term.
> >
> > The tentative plan is to freeze and then release v0.79 after a normal t=
wo
> > week cycle.  This will serve as a 'release candidate' that shaves off a
> > few rough edges from the pending release (including some improvements
> with
> > the API for setting up erasure coded pools).  It is possible that 0.79
> > will turn into firefly, but more likely that we will opt for another tw=
o
> > weeks of hardening and make 0.80 the release we name firefly and mainta=
in
> > for the long term.
> >
> > Long story short: 0.78 will be out soon, and you should test it!  It is
> > will vary from the final firefly in a few subtle ways, but any feedback
> or
> > usability and bug reports at this point will be very helpful in shaping
> > things.
> >
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
=D0=9C=D0=BE=D0=B1.: +79229045757

--485b397dd299ddab8e04f4dc46b7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m ready to test the tiering.</div><div class=3D"gmai=
l_extra"><br><br><div class=3D"gmail_quote">2014-03-18 11:07 GMT+04:00 Stef=
an Priebe - Profihost AG <span dir=3D"ltr">&lt;<a href=3D"mailto:s.priebe@p=
rofihost.ag" target=3D"_blank">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Sage,<br>
<br>
i really would like to test the tiering. Is there any detailed<br>
documentation about it and how it works?<br>
<br>
Greets,<br>
Stefan<br>
<br>
Am 18.03.2014 05:45, schrieb Sage Weil:<br>
<div class=3D"im HOEnZb">&gt; Hi everyone,<br>
&gt;<br>
&gt; It&#39;s taken longer than expected, but the tests for v0.78 are calmi=
ng down<br>
&gt; and it looks like we&#39;ll be able to get the release out this week.<=
br>
&gt;<br>
&gt; However, we&#39;ve decided NOT to make this release firefly. =C2=A0It =
will be a<br>
&gt; normal development release. =C2=A0This will be the first release that =
includes<br>
&gt; some key new functionality (erasure coding and cache tiering) and alth=
ough<br>
&gt; it is passing our tests we&#39;d like to have some operational experie=
nce with<br>
&gt; it in more users&#39; hands before we commit to supporting it long ter=
m.<br>
&gt;<br>
&gt; The tentative plan is to freeze and then release v0.79 after a normal =
two<br>
&gt; week cycle. =C2=A0This will serve as a &#39;release candidate&#39; tha=
t shaves off a<br>
&gt; few rough edges from the pending release (including some improvements =
with<br>
&gt; the API for setting up erasure coded pools). =C2=A0It is possible that=
 0.79<br>
&gt; will turn into firefly, but more likely that we will opt for another t=
wo<br>
&gt; weeks of hardening and make 0.80 the release we name firefly and maint=
ain<br>
&gt; for the long term.<br>
&gt;<br>
&gt; Long story short: 0.78 will be out soon, and you should test it! =C2=
=A0It is<br>
&gt; will vary from the final firefly in a few subtle ways, but any feedbac=
k or<br>
&gt; usability and bug reports at this point will be very helpful in shapin=
g<br>
&gt; things.<br>
&gt;<br>
&gt; Thanks!<br>
&gt; sage<br>
</div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordo=
mo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html<=
/a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div dir=3D"ltr">=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=
=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =
=D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87<div>=D0=
=9C=D0=BE=D0=B1.: +79229045757</div></div>
</div>

--485b397dd299ddab8e04f4dc46b7--

--===============0320427989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0320427989==--
