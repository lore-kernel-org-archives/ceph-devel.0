From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: firefly timing
Date: Tue, 18 Mar 2014 09:54:52 +0200
Message-ID: <5166D2E8-F73F-4F2C-8530-6666071908AD@csc.fi>
References: <alpine.DEB.2.00.1403172115140.24236@cobra.newdream.net>
	<5327F0A7.8010105@profihost.ag>
	<CAF-rypyVjvuddtaj=cW_yJowzGzCq0m7LgW6S=2zK1aAvsfrTA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============1406949297=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-rypyVjvuddtaj=cW_yJowzGzCq0m7LgW6S=2zK1aAvsfrTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============1406949297==
Content-Type: multipart/alternative; boundary="Apple-Mail=_CDD7CF69-663E-4BFB-8CBE-02EB01929904"


--Apple-Mail=_CDD7CF69-663E-4BFB-8CBE-02EB01929904
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Everyone

I am looking forward to test new features of 0.78 , it would be nice if =
erasure coding and tiering implementation notes available in ceph =
documentation.

Ceph documentation is in a good shape and its always nice to follow.

A humble request to add erasure coding and tiering in documentation if =
its not already in your pipeline.=20


Karan Singh
CSC - IT Center for Science Ltd.
P.O. Box 405, FI-02101 Espoo, FINLAND
http://www.csc.fi/ | +358 (0) 503 812758

On 18 Mar 2014, at 09:13, =D0=98=D1=80=D0=B5=D0=BA =D0=A4=D0=B0=D1=81=D0=B8=
=D1=85=D0=BE=D0=B2 <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I'm ready to test the tiering.
>=20
>=20
> 2014-03-18 11:07 GMT+04:00 Stefan Priebe - Profihost AG =
<s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>:
> Hi Sage,
>=20
> i really would like to test the tiering. Is there any detailed
> documentation about it and how it works?
>=20
> Greets,
> Stefan
>=20
> Am 18.03.2014 05:45, schrieb Sage Weil:
> > Hi everyone,
> >
> > It's taken longer than expected, but the tests for v0.78 are calming =
down
> > and it looks like we'll be able to get the release out this week.
> >
> > However, we've decided NOT to make this release firefly.  It will be =
a
> > normal development release.  This will be the first release that =
includes
> > some key new functionality (erasure coding and cache tiering) and =
although
> > it is passing our tests we'd like to have some operational =
experience with
> > it in more users' hands before we commit to supporting it long term.
> >
> > The tentative plan is to freeze and then release v0.79 after a =
normal two
> > week cycle.  This will serve as a 'release candidate' that shaves =
off a
> > few rough edges from the pending release (including some =
improvements with
> > the API for setting up erasure coded pools).  It is possible that =
0.79
> > will turn into firefly, but more likely that we will opt for another =
two
> > weeks of hardening and make 0.80 the release we name firefly and =
maintain
> > for the long term.
> >
> > Long story short: 0.78 will be out soon, and you should test it!  It =
is
> > will vary from the final firefly in a few subtle ways, but any =
feedback or
> > usability and bug reports at this point will be very helpful in =
shaping
> > things.
> >
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
>=20
> --=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =
=D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =
=D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
> =D0=9C=D0=BE=D0=B1.: +79229045757
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_CDD7CF69-663E-4BFB-8CBE-02EB01929904
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Hello Everyone</div><div><br></div><div>I am =
looking forward to test new features of 0.78 , it would be nice if =
erasure coding and tiering implementation notes available in ceph =
documentation.</div><div><br></div><div>Ceph documentation is in a good =
shape and its always nice to follow.</div><div><br></div><div>A humble =
request to add erasure coding and tiering in documentation if its not =
already in your pipeline.&nbsp;</div><div><br></div><div><div =
style=3D"font-family: 'times new roman', 'new york', times, serif; =
font-size: 13.63636302947998px;"><br></div><div =
id=3D"61cfb6a1-7aa9-4052-88b7-ba99a4d8d2ed" style=3D"font-family: 'times =
new roman', 'new york', times, serif; font-size: =
13.63636302947998px;"><span name=3D"x"></span>Karan Singh<br>CSC - IT =
Center for Science Ltd.<br>P.O. Box 405, FI-02101 Espoo, FINLAND<br><a =
href=3D"http://www.csc.fi/">http://www.csc.fi/</a> | +358 (0) 503 =
812758</div></div><br><div><div>On 18 Mar 2014, at 09:13, =D0=98=D1=80=D0=B5=
=D0=BA =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 &lt;<a =
href=3D"mailto:malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div dir=3D"ltr">I'm ready to test the tiering.</div><div =
class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2014-03-18 =
11:07 GMT+04:00 Stefan Priebe - Profihost AG <span dir=3D"ltr">&lt;<a =
href=3D"mailto:s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org" =
target=3D"_blank">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Sage,<br>
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
&gt; It's taken longer than expected, but the tests for v0.78 are =
calming down<br>
&gt; and it looks like we'll be able to get the release out this =
week.<br>
&gt;<br>
&gt; However, we've decided NOT to make this release firefly. &nbsp;It =
will be a<br>
&gt; normal development release. &nbsp;This will be the first release =
that includes<br>
&gt; some key new functionality (erasure coding and cache tiering) and =
although<br>
&gt; it is passing our tests we'd like to have some operational =
experience with<br>
&gt; it in more users' hands before we commit to supporting it long =
term.<br>
&gt;<br>
&gt; The tentative plan is to freeze and then release v0.79 after a =
normal two<br>
&gt; week cycle. &nbsp;This will serve as a 'release candidate' that =
shaves off a<br>
&gt; few rough edges from the pending release (including some =
improvements with<br>
&gt; the API for setting up erasure coded pools). &nbsp;It is possible =
that 0.79<br>
&gt; will turn into firefly, but more likely that we will opt for =
another two<br>
&gt; weeks of hardening and make 0.80 the release we name firefly and =
maintain<br>
&gt; for the long term.<br>
&gt;<br>
&gt; Long story short: 0.78 will be out soon, and you should test it! =
&nbsp;It is<br>
&gt; will vary from the final firefly in a few subtle ways, but any =
feedback or<br>
&gt; usability and bug reports at this point will be very helpful in =
shaping<br>
&gt; things.<br>
&gt;<br>
&gt; Thanks!<br>
&gt; sage<br>
</div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in<br>
&gt; the body of a message to <a =
href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br=
>
&gt; More majordomo info at &nbsp;<a =
href=3D"http://vger.kernel.org/majordomo-info.html" =
target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br=
>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" =
target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</=
a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- =
<br><div dir=3D"ltr">=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=
=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA=
 =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87<div>=D0=
=9C=D0=BE=D0=B1.: +79229045757</div></div>
</div>
_______________________________________________<br>ceph-users mailing =
list<br><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br=
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br></blockquote></=
div><br></body></html>=

--Apple-Mail=_CDD7CF69-663E-4BFB-8CBE-02EB01929904--

--===============1406949297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1406949297==--
