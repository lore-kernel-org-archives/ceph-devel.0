From: Tony Harris <nethfel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: The first infernalis dev release will be v9.0.0
Date: Tue, 5 May 2015 11:50:23 -0500
Message-ID: <CADA4hP+aeXmLqv2YGQsG7Hh72ZM8S9D8YTsvVktt22jGdYqTAg@mail.gmail.com>
References: <alpine.DEB.2.00.1504301528410.5458@cobra.newdream.net>
	<5548D1C0.30204@suse.de>
	<alpine.DEB.2.00.1505050945230.13336@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0396277523=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1505050945230.13336-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0396277523==
Content-Type: multipart/alternative; boundary=089e010d89e2c116e20515587a1b

--089e010d89e2c116e20515587a1b
Content-Type: text/plain; charset=UTF-8

So with this, will even numbers then be LTS?  Since 9.0.0 is following
0.94.x/Hammer, and every other release is normally LTS, I'm guessing
10.x.x, 12.x.x, etc. will be LTS...

On Tue, May 5, 2015 at 11:45 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, 5 May 2015, Joao Eduardo Luis wrote:
> > On 05/04/2015 05:09 PM, Sage Weil wrote:
> > > The first Ceph release back in Jan of 2008 was 0.1.  That made sense at
> > > the time.  We haven't revised the versioning scheme since then,
> however,
> > > and are now at 0.94.1 (first Hammer point release).  To avoid reaching
> > > 0.99 (and 0.100 or 1.00?) we have a new strategy.  This was discussed a
> > > bit on ceph-devel and in #ceph-devel and there doesn't appear to be any
> > > scheme that everyone likes.
> > >
> > > So, we're going to go with something that only a few people dislike:
> > >
> > >  x.0.z - development releases (for early testers and the brave at
> heart)
> > >  x.1.z - release candidates (for test clusters, brave users)
> > >  x.2.z - stable/bugfix releases (for users)
> > >
> > > x will start at 9 for Infernalis ("I" is the 9th letter), making our
> first
> > > development release of the 9th release cycle 9.0.0.  Subsequent
> > > development releases will be 9.0.1, 9.0.2, etc.
> > >
> > > In a couple months we'll have a 9.1.0 (and maybe 9.1.1) release
> candidate.
> > >
> > > A few weeks after that we'll have the Infernalis release 9.2.0,
> followed
> > > by stable bug fix updates 9.2.1, 9.2.2, etc., and then begin work on
> the
> > > Jewel (10.y.z) release.
> > >
> > > We'll see how this works out.  We can adjust this in the future to any
> > > other 9.y.z scheme (e.g., 9.1, 9.2 etc dev releases and 9.8.z stable
> > > releases); the main commitment here is to the 9 part, indicating
> > > Infernalis is the 9th major release cycle.
> >
> > Looks sane!
> >
> > I'm guessing once 9.1.0 is frozen the dev cycles will move on to 10.0.1?
>
> Yep!  Or 10.0.0 I guess since we just did 9.0.0.
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e010d89e2c116e20515587a1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So with this, will even numbers then be LTS?=C2=A0 Since 9=
.0.0 is following 0.94.x/Hammer, and every other release is normally LTS, I=
&#39;m guessing 10.x.x, 12.x.x, etc. will be LTS...</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Tue, May 5, 2015 at 11:45 AM, Sa=
ge Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D=
"_blank">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Tue, 5 May 2015, Joao Edu=
ardo Luis wrote:<br>
&gt; On 05/04/2015 05:09 PM, Sage Weil wrote:<br>
&gt; &gt; The first Ceph release back in Jan of 2008 was 0.1.=C2=A0 That ma=
de sense at<br>
&gt; &gt; the time.=C2=A0 We haven&#39;t revised the versioning scheme sinc=
e then, however,<br>
&gt; &gt; and are now at 0.94.1 (first Hammer point release).=C2=A0 To avoi=
d reaching<br>
&gt; &gt; 0.99 (and 0.100 or 1.00?) we have a new strategy.=C2=A0 This was =
discussed a<br>
&gt; &gt; bit on ceph-devel and in #ceph-devel and there doesn&#39;t appear=
 to be any<br>
&gt; &gt; scheme that everyone likes.<br>
&gt; &gt;<br>
&gt; &gt; So, we&#39;re going to go with something that only a few people d=
islike:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 x.0.z - development releases (for early testers and the bra=
ve at heart)<br>
&gt; &gt;=C2=A0 x.1.z - release candidates (for test clusters, brave users)=
<br>
&gt; &gt;=C2=A0 x.2.z - stable/bugfix releases (for users)<br>
&gt; &gt;<br>
&gt; &gt; x will start at 9 for Infernalis (&quot;I&quot; is the 9th letter=
), making our first<br>
&gt; &gt; development release of the 9th release cycle 9.0.0.=C2=A0 Subsequ=
ent<br>
&gt; &gt; development releases will be 9.0.1, 9.0.2, etc.<br>
&gt; &gt;<br>
&gt; &gt; In a couple months we&#39;ll have a 9.1.0 (and maybe 9.1.1) relea=
se candidate.<br>
&gt; &gt;<br>
&gt; &gt; A few weeks after that we&#39;ll have the Infernalis release 9.2.=
0, followed<br>
&gt; &gt; by stable bug fix updates 9.2.1, 9.2.2, etc., and then begin work=
 on the<br>
&gt; &gt; Jewel (10.y.z) release.<br>
&gt; &gt;<br>
&gt; &gt; We&#39;ll see how this works out.=C2=A0 We can adjust this in the=
 future to any<br>
&gt; &gt; other 9.y.z scheme (e.g., 9.1, 9.2 etc dev releases and 9.8.z sta=
ble<br>
&gt; &gt; releases); the main commitment here is to the 9 part, indicating<=
br>
&gt; &gt; Infernalis is the 9th major release cycle.<br>
&gt;<br>
&gt; Looks sane!<br>
&gt;<br>
&gt; I&#39;m guessing once 9.1.0 is frozen the dev cycles will move on to 1=
0.0.1?<br>
<br>
</div></div>Yep!=C2=A0 Or 10.0.0 I guess since we just did 9.0.0.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
sage<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--089e010d89e2c116e20515587a1b--

--===============0396277523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0396277523==--
