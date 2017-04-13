From: Michael Kidd <linuxkidd-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PG calculator improvement
Date: Thu, 13 Apr 2017 09:57:36 -0700
Message-ID: <CAND7siwRtJidPxMM6p_z1i06iTFO8aiUGW0wrC6EekSkNWUzxw@mail.gmail.com>
References: <09f3b299-bf62-7d4c-c95b-9cdb86dde16e@univ-lorraine.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789467397=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <09f3b299-bf62-7d4c-c95b-9cdb86dde16e-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1789467397==
Content-Type: multipart/alternative; boundary=001a113fe80e2fb774054d0f3b5e

--001a113fe80e2fb774054d0f3b5e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Fr=C3=A9d=C3=A9ric,
  Thank you very much for the input.  I would like to ask for some feedback
from you, as well as the ceph-users list at large.

The PGCalc tool was created to help steer new Ceph users in the right
direction, but it's certainly difficult to account for every possible
scenario.  I'm struggling to find a way to implement something that would
work better for the scenario that you (Fr=C3=A9d=C3=A9ric) describe, while =
still
being a useful starting point for the novice / more mainstream use cases.
I've also gotten complaints at the other end of the spectrum, that the tool
expects the user to know too much already, so accounting for the number of
objects is bound to add to this sentiment.

As the Ceph user base expands and the use cases diverge, we are definitely
finding more edge cases that are causing pain.  I'd love to make something
to help prevent these types of issues, but again, I worry about the
complexity introduced.

With this, I see a few possible ways forward:
* Simply re-wroding the %data to be % object count -- but this seems more
abstract, again leading to more confusion of new users.
* Increase complexity of the PG Calc tool, at the risk of further
alienating novice/mainstream users
* Add a disclaimer about the tool being a base for decision making, but
that certain edge cases require adjustments to the recommended PG count
and/or ceph.conf & sysctl values.
* Add a disclaimer urging the end user to secure storage consulting if
their use case falls into certain categories or they are new to Ceph to
ensure the cluster will meet their needs.

Having been on the storage consulting team and knowing the expertise they
have, I strongly believe that newcomers to Ceph (or new use cases inside of
established customers) should secure consulting before final decisions are
made on hardware... let alone the cluster is deployed.  I know it seems a
bit self-serving to make this suggestion as I work at Red Hat, but there is
a lot on the line when any establishment is storing potentially business
critical data.

I suspect the answer lies in a combination of the above or in something
I've not thought of.  Please do weigh in as any and all suggestions are
more than welcome.

Thanks,
Michael J. Kidd
Principal Software Maintenance Engineer
Red Hat Ceph Storage
+1 919-442-8878


On Wed, Apr 12, 2017 at 6:35 AM, Fr=C3=A9d=C3=A9ric Nass <
frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org> wrote:

>
> Hi,
>
> I wanted to share a bad experience we had due to how the PG calculator
> works.
>
> When we set our production cluster months ago, we had to decide on the
> number of PGs to give to each pool in the cluster.
> As you know, the PG calc would recommended to give a lot of PGs to heavy
> pools in size, regardless the number of objects in the pools. How bad...
>
> We essentially had 3 pools to set on 144 OSDs :
>
> 1. a EC5+4 pool for the radosGW (.rgw.buckets) that would hold 80% of all
> datas in the cluster. PG calc recommended 2048 PGs.
> 2. a EC5+4 pool for zimbra's data (emails) that would hold 20% of all
> datas. PG calc recommended 512 PGs.
> 3. a replicated pool for zimbra's metadata (null size objects holding
> xattrs - used for deduplication) that would hold 0% of all datas. PG calc
> recommended 128 PGs, but we decided on 256.
>
> With 120M of objects in pool #3, as soon as we upgraded to Jewel, we hit
> the Jewel scrubbing bug (OSDs flapping).
> Before we could upgrade to patched Jewel, scrub all the cluster again
> prior to increasing the number of PGs on this pool, we had to take more
> than a hundred of snapshots (for backup/restoration purposes), with the
> number of objects still increasing in the pool. Then when a snapshot was
> removed, we hit the current Jewel snap trimming bug affecting pools with
> too many objects for the number of PGs. The only way we could stop the
> trimming was to stop OSDs resulting in PGs being degraded and not trimmin=
g
> anymore (snap trimming only happens on active+clean PGs).
>
> We're now just getting out of this hole, thanks to Nick's post regarding
> osd_snap_trim_sleep and RHCS support expertise.
>
> If the PG calc had considered not only the pools weight but also the
> number of expected objects in the pool (which we knew by that time), we
> wouldn't have it these 2 bugs.
> We hope this will help improving the ceph.com and RHCS PG calculators.
>
> Regards,
>
> Fr=C3=A9d=C3=A9ric.
>
> --
>
> Fr=C3=A9d=C3=A9ric Nass
>
> Sous-direction Infrastructures
> Direction du Num=C3=A9rique
> Universit=C3=A9 de Lorraine
>
> T=C3=A9l : +33 3 72 74 11 35
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113fe80e2fb774054d0f3b5e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello=C2=A0<span style=3D"font-size:12.8px">Fr=C3=A9d=C3=
=A9ric,</span><div><span style=3D"font-size:12.8px">=C2=A0 Thank you very m=
uch for the input.=C2=A0 I would like to ask for some feedback from you, as=
 well as the ceph-users list at large. =C2=A0</span></div><div><span style=
=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8px=
">The
 PGCalc tool was created to help steer new Ceph=C2=A0users in the right=20
direction, but it&#39;s certainly difficult to account for every possible=
=20
scenario.=C2=A0 I&#39;m struggling to find a way to implement something tha=
t=20
would work better for the scenario that you (</span><span style=3D"font-siz=
e:12.8px">Fr=C3=A9d=C3=A9ric)
 describe, while still being a useful starting point for the novice /=20
more mainstream use cases.=C2=A0 I&#39;ve also gotten complaints at the oth=
er end
 of the spectrum, that the tool expects the user to know too much=20
already, so accounting for=C2=A0the number of objects is bound to add to th=
is
 sentiment.</span></div><div><span style=3D"font-size:12.8px"><br></span></=
div><div><span style=3D"font-size:12.8px">As
 the Ceph user base expands and the use cases diverge, we are definitely
 finding more edge cases that are causing pain.=C2=A0 I&#39;d love to make=
=20
something to help prevent these types of issues, but again, I worry=20
about the complexity introduced.</span></div><div><span style=3D"font-size:=
12.8px"><br></span></div><div><span style=3D"font-size:12.8px">With this, I=
 see a few possible ways forward:</span></div><div><span style=3D"font-size=
:12.8px"><span style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">=
* Simply re-wroding the %data to be %=20
object count -- but this seems more abstract, again leading to more=20
confusion of new users.<br></span></span>* Increase complexity of the PG Ca=
lc tool, at the risk of further alienating novice/mainstream users</span></=
div><div><span style=3D"font-size:12.8px">*
 Add a disclaimer about the tool being a base for decision making, but=20
that certain edge cases require adjustments to the recommended PG count=20
and/or ceph.conf &amp; sysctl values.</span></div><div><span style=3D"font-=
size:12.8px">*
 Add a disclaimer urging the end user to secure storage consulting if=20
their use case falls into certain categories or they are new to Ceph to=20
ensure the cluster will meet their needs.</span></div><div><span style=3D"f=
ont-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8px"></s=
pan></div><div><span style=3D"font-size:12.8px">Having
 been on the storage consulting team and knowing the expertise they=20
have, I strongly believe that newcomers to Ceph (or new use cases inside
 of established customers) should secure consulting before final=20
decisions are made on hardware... let alone the cluster is deployed.=C2=A0 =
I=20
know it seems a bit self-serving to make this suggestion</span><span style=
=3D"font-size:12.8px">=C2=A0</span><span style=3D"font-size:12.8px">as I wo=
rk at Red Hat</span><span style=3D"font-size:12.8px">, but there is a lot o=
n the line when any establishment is storing potentially business critical =
data.</span></div><div><span style=3D"font-size:12.8px"><br></span></div><d=
iv><span style=3D"font-size:12.8px">I suspect the answer lies in a combinat=
ion of the above or in something I&#39;ve not thought of.</span><span style=
=3D"font-size:12.8px">=C2=A0=C2=A0</span><span style=3D"font-size:12.8px">P=
lease do weigh in as any and all suggestions are more than welcome.</span><=
/div><div><span style=3D"font-size:12.8px"><br></span></div><div><span styl=
e=3D"font-size:12.8px">Thanks,</span></div><div class=3D"gmail_extra"><div>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=
<div dir=3D"ltr"><div>Michael J. Kidd<br>Principal Software Maintenance Eng=
ineer<br>Red Hat Ceph Storage<br></div>+1 919-442-8878</div></div></div></d=
iv></div></div></div>
<br><br><div class=3D"gmail_quote">On Wed, Apr 12, 2017 at 6:35 AM, Fr=C3=
=A9d=C3=A9ric Nass <span dir=3D"ltr">&lt;<a href=3D"mailto:frederic.nass@un=
iv-lorraine.fr" target=3D"_blank">frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Hi,<br>
<br>
I wanted to share a bad experience we had due to how the PG calculator work=
s.<br>
<br>
When we set our production cluster months ago, we had to decide on the numb=
er of PGs to give to each pool in the cluster.<br>
As you know, the PG calc would recommended to give a lot of PGs to heavy po=
ols in size, regardless the number of objects in the pools. How bad...<br>
<br>
We essentially had 3 pools to set on 144 OSDs :<br>
<br>
1. a EC5+4 pool for the radosGW (.rgw.buckets) that would hold 80% of all d=
atas in the cluster. PG calc recommended 2048 PGs.<br>
2. a EC5+4 pool for zimbra&#39;s data (emails) that would hold 20% of all d=
atas. PG calc recommended 512 PGs.<br>
3. a replicated pool for zimbra&#39;s metadata (null size objects holding x=
attrs - used for deduplication) that would hold 0% of all datas. PG calc re=
commended 128 PGs, but we decided on 256.<br>
<br>
With 120M of objects in pool #3, as soon as we upgraded to Jewel, we hit th=
e Jewel scrubbing bug (OSDs flapping).<br>
Before we could upgrade to patched Jewel, scrub all the cluster again prior=
 to increasing the number of PGs on this pool, we had to take more than a h=
undred of snapshots (for backup/restoration purposes), with the number of o=
bjects still increasing in the pool. Then when a snapshot was removed, we h=
it the current Jewel snap trimming bug affecting pools with too many object=
s for the number of PGs. The only way we could stop the trimming was to sto=
p OSDs resulting in PGs being degraded and not trimming anymore (snap trimm=
ing only happens on active+clean PGs).<br>
<br>
We&#39;re now just getting out of this hole, thanks to Nick&#39;s post rega=
rding osd_snap_trim_sleep and RHCS support expertise.<br>
<br>
If the PG calc had considered not only the pools weight but also the number=
 of expected objects in the pool (which we knew by that time), we wouldn&#3=
9;t have it these 2 bugs.<br>
We hope this will help improving the <a href=3D"http://ceph.com" rel=3D"nor=
eferrer" target=3D"_blank">ceph.com</a> and RHCS PG calculators.<br>
<br>
Regards,<br>
<br>
Fr=C3=A9d=C3=A9ric.<br>
<br>
-- <br>
<br>
Fr=C3=A9d=C3=A9ric Nass<br>
<br>
Sous-direction Infrastructures<br>
Direction du Num=C3=A9rique<br>
Universit=C3=A9 de Lorraine<br>
<br>
T=C3=A9l : <a href=3D"tel:%2B33%203%2072%2074%2011%2035" value=3D"+33372741=
135" target=3D"_blank">+33 3 72 74 11 35</a><br>
<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div><br></div></div>

--001a113fe80e2fb774054d0f3b5e--

--===============1789467397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1789467397==--
