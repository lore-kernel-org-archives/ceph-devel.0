From: Alex Gorbachev <ag-VxEtxStO0vCD5NdjQRoWIEEOCMrvLtNR@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Wed, 06 Sep 2017 16:35:29 +0000
Message-ID: <CADb9453GaQmZAN_b8_MTHCO5C2DRQ983fgNW=-4xmCGesjW3TQ@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5740042331539352819=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============5740042331539352819==
Content-Type: multipart/alternative; boundary="94eb2c1be1a432b23a055887efdd"

--94eb2c1be1a432b23a055887efdd
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 6, 2017 at 11:23 AM Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi everyone,
>
> Traditionally, we have done a major named "stable" release twice a year,
> and every other such release has been an "LTS" release, with fixes
> backported for 1-2 years.
>
> With kraken and luminous we missed our schedule by a lot: instead of
> releasing in October and April we released in January and August.
>
> A few observations:
>
> - Not a lot of people seem to run the "odd" releases (e.g., infernalis,
> kraken).  This limits the value of actually making them.  It also means
> that those who *do* run them are running riskier code (fewer users -> more
> bugs).
>
> - The more recent requirement that upgrading clusters must make a stop at
> each LTS (e.g., hammer -> luminous not supported, must go hammer -> jewel
> -> lumninous) has been hugely helpful on the development side by reducing
> the amount of cross-version compatibility code to maintain and reducing
> the number of upgrade combinations to test.
>
> - When we try to do a time-based "train" release cadence, there always
> seems to be some "must-have" thing that delays the release a bit.  This
> doesn't happen as much with the odd releases, but it definitely happens
> with the LTS releases.  When the next LTS is a year away, it is hard to
> suck it up and wait that long.
>
> A couple of options:
>
> * Keep even/odd pattern, and continue being flexible with release dates
>
>   + flexible
>   - unpredictable
>   - odd releases of dubious value
>
> * Keep even/odd pattern, but force a 'train' model with a more regular
> cadence
>
>   + predictable schedule
>   - some features will miss the target and be delayed a year
>
> * Drop the odd releases but change nothing else (i.e., 12-month release
> cadence)
>
>   + eliminate the confusing odd releases with dubious value
>
> * Drop the odd releases, and aim for a ~9 month cadence. This splits the
> difference between the current even/odd pattern we've been doing.
>
>   + eliminate the confusing odd releases with dubious value
>   + waiting for the next release isn't quite as bad
>   - required upgrades every 9 months instead of ever 12 months
>
> * Drop the odd releases, but relax the "must upgrade through every LTS" to
> allow upgrades across 2 versions (e.g., luminous -> mimic or luminous ->
> nautilus).  Shorten release cycle (~6-9 months).
>
>   + more flexibility for users
>   + downstreams have greater choice in adopting an upstrema release
>   - more LTS branches to maintain
>   - more upgrade paths to consider
>
> Other options we should consider?  Other thoughts?


As a mission critical system user, I am in favor of dropping odd releases
and going to a 9 month cycle.  We never run the odd releases as too risky.
A good deal if functionality comes in updates, and usually the Ceph team
brings them in gently, with the more experimental features off by default.

I suspect the 9 month even cycle will also make it easier to perform more
incremental upgrades, i.e. small jumps rather than big leaps.



>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
-- 
--
Alex Gorbachev
Storcium

--94eb2c1be1a432b23a055887efdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div dir=3D"auto">On Wed, Sep 6, 2017 a=
t 11:23 AM Sage Weil &lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi everyone,<br>
<br>
Traditionally, we have done a major named &quot;stable&quot; release twice =
a year,<br>
and every other such release has been an &quot;LTS&quot; release, with fixe=
s<br>
backported for 1-2 years.<br>
<br>
With kraken and luminous we missed our schedule by a lot: instead of<br>
releasing in October and April we released in January and August.<br>
<br>
A few observations:<br>
<br>
- Not a lot of people seem to run the &quot;odd&quot; releases (e.g., infer=
nalis,<br>
kraken).=C2=A0 This limits the value of actually making them.=C2=A0 It also=
 means<br>
that those who *do* run them are running riskier code (fewer users -&gt; mo=
re<br>
bugs).<br>
<br>
- The more recent requirement that upgrading clusters must make a stop at<b=
r>
each LTS (e.g., hammer -&gt; luminous not supported, must go hammer -&gt; j=
ewel<br>
-&gt; lumninous) has been hugely helpful on the development side by reducin=
g<br>
the amount of cross-version compatibility code to maintain and reducing<br>
the number of upgrade combinations to test.<br>
<br>
- When we try to do a time-based &quot;train&quot; release cadence, there a=
lways<br>
seems to be some &quot;must-have&quot; thing that delays the release a bit.=
=C2=A0 This<br>
doesn&#39;t happen as much with the odd releases, but it definitely happens=
<br>
with the LTS releases.=C2=A0 When the next LTS is a year away, it is hard t=
o<br>
suck it up and wait that long.<br>
<br>
A couple of options:<br>
<br>
* Keep even/odd pattern, and continue being flexible with release dates<br>
<br>
=C2=A0 + flexible<br>
=C2=A0 - unpredictable<br>
=C2=A0 - odd releases of dubious value<br>
<br>
* Keep even/odd pattern, but force a &#39;train&#39; model with a more regu=
lar<br>
cadence<br>
<br>
=C2=A0 + predictable schedule<br>
=C2=A0 - some features will miss the target and be delayed a year<br>
<br>
* Drop the odd releases but change nothing else (i.e., 12-month release<br>
cadence)<br>
<br>
=C2=A0 + eliminate the confusing odd releases with dubious value<br>
<br>
* Drop the odd releases, and aim for a ~9 month cadence. This splits the<br=
>
difference between the current even/odd pattern we&#39;ve been doing.<br>
<br>
=C2=A0 + eliminate the confusing odd releases with dubious value<br>
=C2=A0 + waiting for the next release isn&#39;t quite as bad<br>
=C2=A0 - required upgrades every 9 months instead of ever 12 months<br>
<br>
* Drop the odd releases, but relax the &quot;must upgrade through every LTS=
&quot; to<br>
allow upgrades across 2 versions (e.g., luminous -&gt; mimic or luminous -&=
gt;<br>
nautilus).=C2=A0 Shorten release cycle (~6-9 months).<br>
<br>
=C2=A0 + more flexibility for users<br>
=C2=A0 + downstreams have greater choice in adopting an upstrema release<br=
>
=C2=A0 - more LTS branches to maintain<br>
=C2=A0 - more upgrade paths to consider<br>
<br>
Other options we should consider?=C2=A0 Other thoughts?</blockquote><div di=
r=3D"auto"><br></div><div dir=3D"auto">As a mission critical system user, I=
 am in favor of dropping odd releases and going to a 9 month cycle.=C2=A0 W=
e never run the odd releases as too risky.=C2=A0 A good deal if functionali=
ty comes in updates, and usually the Ceph team brings them in gently, with =
the more experimental features off by default.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">I suspect the 9 month even cycle will also make it e=
asier to perform more incremental upgrades, i.e. small jumps rather than bi=
g leaps.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
<br>
Thanks!<br>
sage<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div><div dir=3D"ltr">-- <br></div><div class=3D"gmail_=
signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">--<div>Alex =
Gorbachev</div><div>Storcium</div></div></div>

--94eb2c1be1a432b23a055887efdd--

--===============5740042331539352819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5740042331539352819==--
