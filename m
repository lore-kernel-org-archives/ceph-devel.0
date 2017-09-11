From: Ben Hines <bhines-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Mon, 11 Sep 2017 15:38:32 -0700
Message-ID: <CABGPr5ko81W=4kekDNk1_UKcJH4HQ6udWLb0W9V-hnKAo8O=_w@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <CALe9h7eFV5sitW+8WAVqjmB+rJvYJw-5C4nizS0HTqffr-_bCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8392692237524731332=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7eFV5sitW+8WAVqjmB+rJvYJw-5C4nizS0HTqffr-_bCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============8392692237524731332==
Content-Type: multipart/alternative; boundary="001a114b454455a7c20558f197f6"

--001a114b454455a7c20558f197f6
Content-Type: text/plain; charset="UTF-8"

We have generally been running the latest non LTS 'stable' release since my
cluster is slightly less mission critical than others, and there were
important features to us added in both Infernalis and Kraken. But i really
only care about RGW. If the rgw component could be split out of ceph into a
plugin and independently updated, it'd be awesome for us.

A minor bugfix to radosgw shouldn't be blocked by issues with RBD, for
example. I don't care at all.
Could have packages like:

ceph-core
ceph-radosgw
ceph-rbd ...
ceph-mgr..

Might increase the testing workload, but automation should take care of
that...

ceph-mgr is also similar. Minor (or even major) updates to the GUI
dashboard shouldn't be blocked rolling out to users because we're waiting
on a new RBD feature or critical RGW fix.

radosgw and mgr are really 'clients', after all.

-Ben

On Mon, Sep 11, 2017 at 3:30 PM, John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Wed, Sep 6, 2017 at 4:23 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Hi everyone,
> >
> > Traditionally, we have done a major named "stable" release twice a year,
> > and every other such release has been an "LTS" release, with fixes
> > backported for 1-2 years.
> >
> > With kraken and luminous we missed our schedule by a lot: instead of
> > releasing in October and April we released in January and August.
> >
> > A few observations:
> >
> > - Not a lot of people seem to run the "odd" releases (e.g., infernalis,
> > kraken).  This limits the value of actually making them.  It also means
> > that those who *do* run them are running riskier code (fewer users ->
> more
> > bugs).
> >
> > - The more recent requirement that upgrading clusters must make a stop at
> > each LTS (e.g., hammer -> luminous not supported, must go hammer -> jewel
> > -> lumninous) has been hugely helpful on the development side by reducing
> > the amount of cross-version compatibility code to maintain and reducing
> > the number of upgrade combinations to test.
> >
> > - When we try to do a time-based "train" release cadence, there always
> > seems to be some "must-have" thing that delays the release a bit.  This
> > doesn't happen as much with the odd releases, but it definitely happens
> > with the LTS releases.  When the next LTS is a year away, it is hard to
> > suck it up and wait that long.
> >
> > A couple of options:
> >
> > * Keep even/odd pattern, and continue being flexible with release dates
> >
> >   + flexible
> >   - unpredictable
> >   - odd releases of dubious value
> >
> > * Keep even/odd pattern, but force a 'train' model with a more regular
> > cadence
> >
> >   + predictable schedule
> >   - some features will miss the target and be delayed a year
> >
> > * Drop the odd releases but change nothing else (i.e., 12-month release
> > cadence)
> >
> >   + eliminate the confusing odd releases with dubious value
> >
> > * Drop the odd releases, and aim for a ~9 month cadence. This splits the
> > difference between the current even/odd pattern we've been doing.
> >
> >   + eliminate the confusing odd releases with dubious value
> >   + waiting for the next release isn't quite as bad
> >   - required upgrades every 9 months instead of ever 12 months
>
> This is my preferred option (second choice would be the next one up,
> i.e. same thing but annually).
>
> Our focus should be on delivering solid stuff, but not necessarily
> bending over backwards to enable people to run old stuff.  Our
> commitment to releases should be that there are either fixes for that
> release, or a newer (better) release to upgrade to.  Either way there
> is a solution on offer (and any user/vendor who wants to independently
> maintain other stable branches is free to do so).
>
> John
>
> > * Drop the odd releases, but relax the "must upgrade through every LTS"
> to
> > allow upgrades across 2 versions (e.g., luminous -> mimic or luminous ->
> > nautilus).  Shorten release cycle (~6-9 months).
> >
> >   + more flexibility for users
> >   + downstreams have greater choice in adopting an upstrema release
> >   - more LTS branches to maintain
> >   - more upgrade paths to consider
> >
> > Other options we should consider?  Other thoughts?
> >
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a114b454455a7c20558f197f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We have generally been running the latest non LTS &#39;sta=
ble&#39; release since my cluster is slightly less mission critical than ot=
hers, and there were important features to us added in both Infernalis and =
Kraken. But i really only care about RGW. If the rgw component could be spl=
it out of ceph into a plugin and independently updated, it&#39;d be awesome=
 for us.=C2=A0=C2=A0<div><br></div><div>A minor bugfix to radosgw shouldn&#=
39;t be blocked by issues with RBD, for example. I don&#39;t care at all.</=
div><div>Could have packages like:</div><div><br></div><div>ceph-core<br></=
div><div>ceph-radosgw</div><div>ceph-rbd ...</div><div>ceph-mgr..<br><div><=
br></div><div>Might increase the testing workload, but automation should ta=
ke care of that...=C2=A0</div><div><br></div><div>ceph-mgr is also similar.=
 Minor (or even major) updates to the GUI dashboard shouldn&#39;t be blocke=
d rolling out to users because we&#39;re waiting on a new RBD feature or cr=
itical RGW fix.</div><div><br></div><div><div>radosgw and mgr are really &#=
39;clients&#39;, after all.=C2=A0</div></div><div><br></div><div>-Ben</div>=
</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mo=
n, Sep 11, 2017 at 3:30 PM, John Spray <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D=
"h5">On Wed, Sep 6, 2017 at 4:23 PM, Sage Weil &lt;<a href=3D"mailto:sweil@=
redhat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi everyone,<br>
&gt;<br>
&gt; Traditionally, we have done a major named &quot;stable&quot; release t=
wice a year,<br>
&gt; and every other such release has been an &quot;LTS&quot; release, with=
 fixes<br>
&gt; backported for 1-2 years.<br>
&gt;<br>
&gt; With kraken and luminous we missed our schedule by a lot: instead of<b=
r>
&gt; releasing in October and April we released in January and August.<br>
&gt;<br>
&gt; A few observations:<br>
&gt;<br>
&gt; - Not a lot of people seem to run the &quot;odd&quot; releases (e.g., =
infernalis,<br>
&gt; kraken).=C2=A0 This limits the value of actually making them.=C2=A0 It=
 also means<br>
&gt; that those who *do* run them are running riskier code (fewer users -&g=
t; more<br>
&gt; bugs).<br>
&gt;<br>
&gt; - The more recent requirement that upgrading clusters must make a stop=
 at<br>
&gt; each LTS (e.g., hammer -&gt; luminous not supported, must go hammer -&=
gt; jewel<br>
&gt; -&gt; lumninous) has been hugely helpful on the development side by re=
ducing<br>
&gt; the amount of cross-version compatibility code to maintain and reducin=
g<br>
&gt; the number of upgrade combinations to test.<br>
&gt;<br>
&gt; - When we try to do a time-based &quot;train&quot; release cadence, th=
ere always<br>
&gt; seems to be some &quot;must-have&quot; thing that delays the release a=
 bit.=C2=A0 This<br>
&gt; doesn&#39;t happen as much with the odd releases, but it definitely ha=
ppens<br>
&gt; with the LTS releases.=C2=A0 When the next LTS is a year away, it is h=
ard to<br>
&gt; suck it up and wait that long.<br>
&gt;<br>
&gt; A couple of options:<br>
&gt;<br>
&gt; * Keep even/odd pattern, and continue being flexible with release date=
s<br>
&gt;<br>
&gt;=C2=A0 =C2=A0+ flexible<br>
&gt;=C2=A0 =C2=A0- unpredictable<br>
&gt;=C2=A0 =C2=A0- odd releases of dubious value<br>
&gt;<br>
&gt; * Keep even/odd pattern, but force a &#39;train&#39; model with a more=
 regular<br>
&gt; cadence<br>
&gt;<br>
&gt;=C2=A0 =C2=A0+ predictable schedule<br>
&gt;=C2=A0 =C2=A0- some features will miss the target and be delayed a year=
<br>
&gt;<br>
&gt; * Drop the odd releases but change nothing else (i.e., 12-month releas=
e<br>
&gt; cadence)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0+ eliminate the confusing odd releases with dubious value<=
br>
&gt;<br>
&gt; * Drop the odd releases, and aim for a ~9 month cadence. This splits t=
he<br>
&gt; difference between the current even/odd pattern we&#39;ve been doing.<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0+ eliminate the confusing odd releases with dubious value<=
br>
&gt;=C2=A0 =C2=A0+ waiting for the next release isn&#39;t quite as bad<br>
&gt;=C2=A0 =C2=A0- required upgrades every 9 months instead of ever 12 mont=
hs<br>
<br>
</div></div>This is my preferred option (second choice would be the next on=
e up,<br>
i.e. same thing but annually).<br>
<br>
Our focus should be on delivering solid stuff, but not necessarily<br>
bending over backwards to enable people to run old stuff.=C2=A0 Our<br>
commitment to releases should be that there are either fixes for that<br>
release, or a newer (better) release to upgrade to.=C2=A0 Either way there<=
br>
is a solution on offer (and any user/vendor who wants to independently<br>
maintain other stable branches is free to do so).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
John<br>
</font></span><span class=3D"im HOEnZb"><br>
&gt; * Drop the odd releases, but relax the &quot;must upgrade through ever=
y LTS&quot; to<br>
&gt; allow upgrades across 2 versions (e.g., luminous -&gt; mimic or lumino=
us -&gt;<br>
&gt; nautilus).=C2=A0 Shorten release cycle (~6-9 months).<br>
&gt;<br>
&gt;=C2=A0 =C2=A0+ more flexibility for users<br>
&gt;=C2=A0 =C2=A0+ downstreams have greater choice in adopting an upstrema =
release<br>
&gt;=C2=A0 =C2=A0- more LTS branches to maintain<br>
&gt;=C2=A0 =C2=A0- more upgrade paths to consider<br>
&gt;<br>
&gt; Other options we should consider?=C2=A0 Other thoughts?<br>
&gt;<br>
&gt; Thanks!<br>
&gt; sage<br>
</span><span class=3D"im HOEnZb">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
</span><div class=3D"HOEnZb"><div class=3D"h5">____________________________=
__<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</div></div></blockquote></div><br></div>

--001a114b454455a7c20558f197f6--

--===============8392692237524731332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8392692237524731332==--
