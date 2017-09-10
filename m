From: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Sun, 10 Sep 2017 00:58:10 -0500
Message-ID: <CALi_L49T5g=58SNbXVgGALfRN7_O5UFWdAz2Duv8dYBkoRZGiA@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <1E38E3EC-3112-4694-8F23-5FEAA19BDAB1@flyingcircus.io>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7622199071634493460=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1E38E3EC-3112-4694-8F23-5FEAA19BDAB1-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Christian Theune <ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============7622199071634493460==
Content-Type: multipart/alternative; boundary="001a114278d4b9a41e0558cf7ea6"

--001a114278d4b9a41e0558cf7ea6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As a user,  I woul like to add,  I would like to see a real 2 year support
for LTS releases.  Hammer releases were sketchy at best in 2017.  When
luminous was released The outstanding bugs were auto closed, good buy and
good readance.

 Also the decision to drop certain OS support created a barrier to upgrade
and looking at jewel and luminous upgrade path where you cannot easily go
back after upgrade is completed doesn't add the confidence.

So making upgrades less radical may help production support to be more
consistent and update process less dangerous.

I would say 9 month is a good reference point but for me  it is ready when
it is really ready and tested.

Keeping development release may be better for devs and early adopters.  I
don't believe production admins would go for intermediate one's as they
being released now.

This is only MHO and may be wrong.

On Sep 9, 2017 15:32, "Christian Theune" <ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org> wrote:

> Hi,
>
> have been using Ceph for multiple years now. It=E2=80=99s unclear to me w=
hich of
> your options fits best, but here are my preferences:
>
> * Updates are risky in a way that we tend to rather not do them every
> year. Also, having seen jewel, we=E2=80=99ve been well off to avoid two
>   major issues what would have bitten us and will upgrade from hammer in
> the next month or so.
>
> * Non-production releases are of not much value to me, as I have to keep
> our dev/staging/prod clusters in sync to work on our stuff.
>   As you can never downgrade, there=E2=80=99s no value in it for me to tr=
y
> non-production releases (without frying dev for everyone).
>
> * I=E2=80=99d prefer stability over new features. *Specifically* that new=
 features
> can be properly recombined with existing features (and each
>   other) without leading to surprises. (E.g. cache tiering breaking with
> snapshots and then no way going back and a general notion of
>   =E2=80=9Cthat combination wasn=E2=80=99t really well tested).
>
> * I=E2=80=99d prefer versions that I have to be maintained for production=
-critical
> issues maybe 2 years, so I can have some time after a new
>   production release that overlaps with the new production release
> receiving important bug fixes until I switch.
>
> Maybe this is close to what your "Drop the odd releases, and aim for a ~9
> month cadence.=E2=80=9D would say. Waiting for a feature for a year is a =
pain, but
> my personal goal for Ceph is that it first has to work properly, meaning:
> not loose your data, not "stopping the show=E2=80=9D, and not drawing you=
 into a
> corner you can=E2=80=99t get out.
>
> That=E2=80=99s my perspective as a user. As a fellow developer I feel you=
r pain
> about wanting to release faster and reducing maintenance load, so thanks
> for asking!
>
> Hope this helps,
> Christian
>
> > On Sep 6, 2017, at 5:23 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > Hi everyone,
> >
> > Traditionally, we have done a major named "stable" release twice a year=
,
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
> > - The more recent requirement that upgrading clusters must make a stop =
at
> > each LTS (e.g., hammer -> luminous not supported, must go hammer -> jew=
el
> > -> lumninous) has been hugely helpful on the development side by reduci=
ng
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
> >  + flexible
> >  - unpredictable
> >  - odd releases of dubious value
> >
> > * Keep even/odd pattern, but force a 'train' model with a more regular
> > cadence
> >
> >  + predictable schedule
> >  - some features will miss the target and be delayed a year
> >
> > * Drop the odd releases but change nothing else (i.e., 12-month release
> > cadence)
> >
> >  + eliminate the confusing odd releases with dubious value
> >
> > * Drop the odd releases, and aim for a ~9 month cadence. This splits th=
e
> > difference between the current even/odd pattern we've been doing.
> >
> >  + eliminate the confusing odd releases with dubious value
> >  + waiting for the next release isn't quite as bad
> >  - required upgrades every 9 months instead of ever 12 months
> >
> > * Drop the odd releases, but relax the "must upgrade through every LTS"
> to
> > allow upgrades across 2 versions (e.g., luminous -> mimic or luminous -=
>
> > nautilus).  Shorten release cycle (~6-9 months).
> >
> >  + more flexibility for users
> >  + downstreams have greater choice in adopting an upstrema release
> >  - more LTS branches to maintain
> >  - more upgrade paths to consider
> >
> > Other options we should consider?  Other thoughts?
> >
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Liebe Gr=C3=BC=C3=9Fe,
> Christian Theune
>
> --
> Christian Theune =C2=B7 ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org =C2=B7 +49 345 219401 0
> Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
> Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
> HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian
> Zagrodnick
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--001a114278d4b9a41e0558cf7ea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">As a user, =C2=A0I woul like to add, =C2=A0I would like t=
o see a real 2 year support for LTS releases.=C2=A0 Hammer releases were sk=
etchy at best in 2017.=C2=A0 When luminous was released The outstanding bug=
s were auto closed, good buy and good readance.<div dir=3D"auto"><br></div>=
<div dir=3D"auto">=C2=A0Also the decision to drop certain OS support create=
d a barrier to upgrade and looking at jewel and luminous upgrade path where=
 you cannot easily go back after upgrade is completed doesn&#39;t add the c=
onfidence.</div><div dir=3D"auto"><br></div><div dir=3D"auto">So making upg=
rades less radical may help production support to be more consistent and up=
date process less dangerous.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I would say 9 month is a good reference point but for me =C2=A0it is r=
eady when it is really ready and tested.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Keeping development release may be better for devs and ear=
ly adopters.=C2=A0 I don&#39;t believe production admins would go for inter=
mediate one&#39;s as they being released now.=C2=A0</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">This is only MHO and may be wrong.</div></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sep 9, 2017 15:=
32, &quot;Christian Theune&quot; &lt;<a href=3D"mailto:ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org">=
ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
have been using Ceph for multiple years now. It=E2=80=99s unclear to me whi=
ch of your options fits best, but here are my preferences:<br>
<br>
* Updates are risky in a way that we tend to rather not do them every year.=
 Also, having seen jewel, we=E2=80=99ve been well off to avoid two<br>
=C2=A0 major issues what would have bitten us and will upgrade from hammer =
in the next month or so.<br>
<br>
* Non-production releases are of not much value to me, as I have to keep ou=
r dev/staging/prod clusters in sync to work on our stuff.<br>
=C2=A0 As you can never downgrade, there=E2=80=99s no value in it for me to=
 try non-production releases (without frying dev for everyone).<br>
<br>
* I=E2=80=99d prefer stability over new features. *Specifically* that new f=
eatures can be properly recombined with existing features (and each<br>
=C2=A0 other) without leading to surprises. (E.g. cache tiering breaking wi=
th snapshots and then no way going back and a general notion of<br>
=C2=A0 =E2=80=9Cthat combination wasn=E2=80=99t really well tested).<br>
<br>
* I=E2=80=99d prefer versions that I have to be maintained for production-c=
ritical issues maybe 2 years, so I can have some time after a new<br>
=C2=A0 production release that overlaps with the new production release rec=
eiving important bug fixes until I switch.<br>
<br>
Maybe this is close to what your &quot;Drop the odd releases, and aim for a=
 ~9 month cadence.=E2=80=9D would say. Waiting for a feature for a year is =
a pain, but my personal goal for Ceph is that it first has to work properly=
, meaning: not loose your data, not &quot;stopping the show=E2=80=9D, and n=
ot drawing you into a corner you can=E2=80=99t get out.<br>
<br>
That=E2=80=99s my perspective as a user. As a fellow developer I feel your =
pain about wanting to release faster and reducing maintenance load, so than=
ks for asking!<br>
<br>
Hope this helps,<br>
Christian<br>
<br>
&gt; On Sep 6, 2017, at 5:23 PM, Sage Weil &lt;<a href=3D"mailto:sweil@redh=
at.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
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
&gt;=C2=A0 + flexible<br>
&gt;=C2=A0 - unpredictable<br>
&gt;=C2=A0 - odd releases of dubious value<br>
&gt;<br>
&gt; * Keep even/odd pattern, but force a &#39;train&#39; model with a more=
 regular<br>
&gt; cadence<br>
&gt;<br>
&gt;=C2=A0 + predictable schedule<br>
&gt;=C2=A0 - some features will miss the target and be delayed a year<br>
&gt;<br>
&gt; * Drop the odd releases but change nothing else (i.e., 12-month releas=
e<br>
&gt; cadence)<br>
&gt;<br>
&gt;=C2=A0 + eliminate the confusing odd releases with dubious value<br>
&gt;<br>
&gt; * Drop the odd releases, and aim for a ~9 month cadence. This splits t=
he<br>
&gt; difference between the current even/odd pattern we&#39;ve been doing.<=
br>
&gt;<br>
&gt;=C2=A0 + eliminate the confusing odd releases with dubious value<br>
&gt;=C2=A0 + waiting for the next release isn&#39;t quite as bad<br>
&gt;=C2=A0 - required upgrades every 9 months instead of ever 12 months<br>
&gt;<br>
&gt; * Drop the odd releases, but relax the &quot;must upgrade through ever=
y LTS&quot; to<br>
&gt; allow upgrades across 2 versions (e.g., luminous -&gt; mimic or lumino=
us -&gt;<br>
&gt; nautilus).=C2=A0 Shorten release cycle (~6-9 months).<br>
&gt;<br>
&gt;=C2=A0 + more flexibility for users<br>
&gt;=C2=A0 + downstreams have greater choice in adopting an upstrema releas=
e<br>
&gt;=C2=A0 - more LTS branches to maintain<br>
&gt;=C2=A0 - more upgrade paths to consider<br>
&gt;<br>
&gt; Other options we should consider?=C2=A0 Other thoughts?<br>
&gt;<br>
&gt; Thanks!<br>
&gt; sage<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
<br>
Liebe Gr=C3=BC=C3=9Fe,<br>
Christian Theune<br>
<br>
--<br>
Christian Theune =C2=B7 <a href=3D"mailto:ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org">ct@flyingcirc=
us.io</a> =C2=B7 <a href=3D"tel:%2B49%20345%20219401%200" value=3D"+4934521=
94010">+49 345 219401 0</a><br>
Flying Circus Internet Operations GmbH =C2=B7 <a href=3D"http://flyingcircu=
s.io" rel=3D"noreferrer" target=3D"_blank">http://flyingcircus.io</a><br>
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland<br>
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, Ch=
ristian Zagrodnick<br>
<br>
<br>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
<br></blockquote></div></div>

--001a114278d4b9a41e0558cf7ea6--

--===============7622199071634493460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7622199071634493460==--
