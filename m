From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Help build a drive reliability service!
Date: Wed, 14 Jun 2017 16:09:06 +0000
Message-ID: <CAN-GepKfC5iJuVTioizXm=aDAXuuXFyHBGEaos2eG91bfZM-yg@mail.gmail.com>
References: <CAAZbbf3kS+KQ06KFe=p=Gn1Qmb8xen35U5CLgpcq3BaTT+e5Vg@mail.gmail.com>
	<CABZ+qqmiKrca=AsoAYS3CaW+TTOieoSn1T_Z=gWzaxzmeA1stQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1625271172=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqmiKrca=AsoAYS3CaW+TTOieoSn1T_Z=gWzaxzmeA1stQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1625271172==
Content-Type: multipart/alternative; boundary="94eb2c1cd54028890e0551edc62e"

--94eb2c1cd54028890e0551edc62e
Content-Type: text/plain; charset="UTF-8"

I understand concern over annoying drive manufacturers, but if you have
data to back it up you aren't slandering a drive manufacturer.  If they
don't like the numbers that are found, then they should up their game or at
least request that you put in how your tests negatively affected their
drive endurance.  For instance, WD Red drives are out of warranty just by
being placed in a chassis with more than 4 disks because they aren't rated
for the increased vibration from that many disks in a chassis.

OTOH, if you are testing the drives within the bounds of the drives
warranty, and not doing anything against the recommendation of the
manufacturer in the test use case (both physical and software), then there
is no slander when you say that drive A outperformed drive B.  I know that
the drives I run at home are not nearly as resilient as the drives that I
use at the office, but I don't put my home cluster through a fraction of
the strain that I do at the office.  The manufacturer knows that their
cheaper drive isn't as resilient as the more robust enterprise drives.
Anyway, I'm sure you guys have thought about all of that and are
_generally_ pretty smart. ;)

In an early warning system that detects a drive that is close to failing,
you could implement a command to migrate off of the disk and then run
non-stop IO on it to finish off the disk to satisfy warranties.
Potentially this could be implemented with the osd daemon via a burn-in
start-up option.  Where it can be an OSD in the cluster that does not check
in as up, but with a different status so you can still monitor the health
of the failing drive from a ceph status.  This could also be useful for
people that would like to burn-in their drives, but don't want to dedicate
infrastructure to burning-in new disks before deploying them.  Making this
as easy as possible on the end user/ceph admin, there could even be a
ceph.conf option for OSDs that are added to the cluster and have never been
been marked in to run through a burn-in of X seconds (changeable in the
config and defaults to 0 as to not change the default behavior).  I don't
know if this is over-thinking it or adding complexity where it shouldn't
be, but it could be used to get a drive to fail to use for an RMA.  OTOH,
for large deployments we would RMA drives in batches and were never asked
to prove that the drive failed.  We would RMA drives off of medium errors
for HDDs and smart info for SSDs and of course for full failures.

On Wed, Jun 14, 2017 at 11:38 AM Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
wrote:

> Hi Patrick,
>
> We've just discussed this internally and I wanted to share some notes.
>
> First, there are at least three separate efforts in our IT dept to
> collect and analyse SMART data -- its clearly a popular idea and
> simple to implement, but this leads to repetition and begs for a
> common, good solution.
>
> One (perhaps trivial) issue is that it is hard to define exactly when
> a drive has failed -- it varies depending on the storage system. For
> Ceph I would define failure as EIO, which normally correlates with a
> drive medium error, but there were other ideas here. So if this should
> be a general purpose service, the sensor should have a pluggable
> failure indicator.
>
> There was also debate about what exactly we could do with a failure
> prediction model. Suppose the predictor told us a drive should fail in
> one week. We could proactively drain that disk, but then would it
> still fail? Will the vendor replace that drive under warranty only if
> it was *about to fail*?
>
> Lastly, and more importantly, there is a general hesitation to publish
> this kind of data openly, given how negatively it could impact a
> manufacturer. Our lab certainly couldn't publish a report saying "here
> are the most and least reliable drives". I don't know if anonymising
> the data sources would help here, but anyway I'm curious what are your
> thoughts on that point. Maybe what can come out of this are the
> _components_ of a drive reliability service, which could then be
> deployed privately or publicly as appropriate.
>
> Thanks!
>
> Dan
>
>
>
>
> On Wed, May 24, 2017 at 8:57 PM, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> > Hey cephers,
> >
> > Just wanted to share the genesis of a new community project that could
> > use a few helping hands (and any amount of feedback/discussion that
> > you might like to offer).
> >
> > As a bit of backstory, around 2013 the Backblaze folks started
> > publishing statistics about hard drive reliability from within their
> > data center for the world to consume. This included things like model,
> > make, failure state, and SMART data. If you would like to view the
> > Backblaze data set, you can find it at:
> >
> > https://www.backblaze.com/b2/hard-drive-test-data.html
> >
> > While most major cloud providers are doing this for themselves
> > internally, we would like to replicate/enhance this effort across a
> > much wider segment of the population as a free service.  I think we
> > have a pretty good handle on the server/platform side of things, and a
> > couple of people who have expressed interest in building the
> > reliability model (although we could always use more!), what we really
> > need is a passionate volunteer who would like to come forward to write
> > the agent that sits on the drives, aggregates data, and submits daily
> > stats reports via an API (and potentially receives information back as
> > results are calculated about MTTF or potential to fail in the next
> > 24-48 hrs).
> >
> > Currently my thinking is to build our collection method based on the
> > Backblaze data set so that we can use it to train our model and build
> > from going forward. If this sounds like a project you would like to be
> > involved in (especially if you're from Backblaze!) please let me know.
> > I think a first pass of the agent should be something we can build in
> > a couple of afternoons to start testing with a small pilot group that
> > we already have available.
> >
> > Happy to entertain any thoughts or feedback that people might have.
> Thanks!
> >
> > --
> >
> > Best Regards,
> >
> > Patrick McGarry
> > Director Ceph Community || Red Hat
> > http://ceph.com  ||  http://community.redhat.com
> > @scuttlemonkey || @ceph
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c1cd54028890e0551edc62e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I understand concern over annoying drive manufacturers, bu=
t if you have data to back it up you aren&#39;t slandering a drive manufact=
urer.=C2=A0 If they don&#39;t like the numbers that are found, then they sh=
ould up their game or at least request that you put in how your tests negat=
ively affected their drive endurance.=C2=A0 For instance, WD Red drives are=
 out of warranty just by being placed in a chassis with more than 4 disks b=
ecause they aren&#39;t rated for the increased vibration from that many dis=
ks in a chassis.<div><br></div><div>OTOH, if you are testing the drives wit=
hin the bounds of the drives warranty, and not doing anything against the r=
ecommendation of the manufacturer in the test use case (both physical and s=
oftware), then there is no slander when you say that drive A outperformed d=
rive B.=C2=A0 I know that the drives I run at home are not nearly as resili=
ent as the drives that I use at the office, but I don&#39;t put my home clu=
ster through a fraction of the strain that I do at the office.=C2=A0 The ma=
nufacturer knows that their cheaper drive isn&#39;t as resilient as the mor=
e robust enterprise drives.=C2=A0 Anyway, I&#39;m sure you guys have though=
t about all of that and are _generally_ pretty smart. ;)</div><div><br></di=
v><div>In an early warning system that detects a drive that is close to fai=
ling, you could implement a command to migrate off of the disk and then run=
 non-stop IO on it to finish off the disk to satisfy warranties.=C2=A0 Pote=
ntially this could be implemented with the osd daemon via a burn-in start-u=
p option.=C2=A0 Where it can be an OSD in the cluster that does not check i=
n as up, but with a different status so you can still monitor the health of=
 the failing drive from a ceph status.=C2=A0 This could also be useful for =
people that would like to burn-in their drives, but don&#39;t want to dedic=
ate infrastructure to burning-in new disks before deploying them.=C2=A0 Mak=
ing this as easy as possible on the end user/ceph admin, there could even b=
e a ceph.conf option for OSDs that are added to the cluster and have never =
been been marked in to run through a burn-in of X seconds (changeable in th=
e config and defaults to 0 as to not change the default behavior).=C2=A0 I =
don&#39;t know if this is over-thinking it or adding complexity where it sh=
ouldn&#39;t be, but it could be used to get a drive to fail to use for an R=
MA.=C2=A0 OTOH, for large deployments we would RMA drives in batches and we=
re never asked to prove that the drive failed.=C2=A0 We would RMA drives of=
f of medium errors for HDDs and smart info for SSDs and of course for full =
failures.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Jun 14, 2017 at 11:38 AM Dan van der Ster &lt;<a href=3D"mailto:dan@vande=
rster.com">dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Hi Patrick,<br>
<br>
We&#39;ve just discussed this internally and I wanted to share some notes.<=
br>
<br>
First, there are at least three separate efforts in our IT dept to<br>
collect and analyse SMART data -- its clearly a popular idea and<br>
simple to implement, but this leads to repetition and begs for a<br>
common, good solution.<br>
<br>
One (perhaps trivial) issue is that it is hard to define exactly when<br>
a drive has failed -- it varies depending on the storage system. For<br>
Ceph I would define failure as EIO, which normally correlates with a<br>
drive medium error, but there were other ideas here. So if this should<br>
be a general purpose service, the sensor should have a pluggable<br>
failure indicator.<br>
<br>
There was also debate about what exactly we could do with a failure<br>
prediction model. Suppose the predictor told us a drive should fail in<br>
one week. We could proactively drain that disk, but then would it<br>
still fail? Will the vendor replace that drive under warranty only if<br>
it was *about to fail*?<br>
<br>
Lastly, and more importantly, there is a general hesitation to publish<br>
this kind of data openly, given how negatively it could impact a<br>
manufacturer. Our lab certainly couldn&#39;t publish a report saying &quot;=
here<br>
are the most and least reliable drives&quot;. I don&#39;t know if anonymisi=
ng<br>
the data sources would help here, but anyway I&#39;m curious what are your<=
br>
thoughts on that point. Maybe what can come out of this are the<br>
_components_ of a drive reliability service, which could then be<br>
deployed privately or publicly as appropriate.<br>
<br>
Thanks!<br>
<br>
Dan<br>
<br>
<br>
<br>
<br>
On Wed, May 24, 2017 at 8:57 PM, Patrick McGarry &lt;<a href=3D"mailto:pmcg=
arry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt; Hey cephers,<br>
&gt;<br>
&gt; Just wanted to share the genesis of a new community project that could=
<br>
&gt; use a few helping hands (and any amount of feedback/discussion that<br=
>
&gt; you might like to offer).<br>
&gt;<br>
&gt; As a bit of backstory, around 2013 the Backblaze folks started<br>
&gt; publishing statistics about hard drive reliability from within their<b=
r>
&gt; data center for the world to consume. This included things like model,=
<br>
&gt; make, failure state, and SMART data. If you would like to view the<br>
&gt; Backblaze data set, you can find it at:<br>
&gt;<br>
&gt; <a href=3D"https://www.backblaze.com/b2/hard-drive-test-data.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.backblaze.com/b2/hard-drive-t=
est-data.html</a><br>
&gt;<br>
&gt; While most major cloud providers are doing this for themselves<br>
&gt; internally, we would like to replicate/enhance this effort across a<br=
>
&gt; much wider segment of the population as a free service.=C2=A0 I think =
we<br>
&gt; have a pretty good handle on the server/platform side of things, and a=
<br>
&gt; couple of people who have expressed interest in building the<br>
&gt; reliability model (although we could always use more!), what we really=
<br>
&gt; need is a passionate volunteer who would like to come forward to write=
<br>
&gt; the agent that sits on the drives, aggregates data, and submits daily<=
br>
&gt; stats reports via an API (and potentially receives information back as=
<br>
&gt; results are calculated about MTTF or potential to fail in the next<br>
&gt; 24-48 hrs).<br>
&gt;<br>
&gt; Currently my thinking is to build our collection method based on the<b=
r>
&gt; Backblaze data set so that we can use it to train our model and build<=
br>
&gt; from going forward. If this sounds like a project you would like to be=
<br>
&gt; involved in (especially if you&#39;re from Backblaze!) please let me k=
now.<br>
&gt; I think a first pass of the agent should be something we can build in<=
br>
&gt; a couple of afternoons to start testing with a small pilot group that<=
br>
&gt; we already have available.<br>
&gt;<br>
&gt; Happy to entertain any thoughts or feedback that people might have. Th=
anks!<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Best Regards,<br>
&gt;<br>
&gt; Patrick McGarry<br>
&gt; Director Ceph Community || Red Hat<br>
&gt; <a href=3D"http://ceph.com" rel=3D"noreferrer" target=3D"_blank">http:=
//ceph.com</a>=C2=A0 ||=C2=A0 <a href=3D"http://community.redhat.com" rel=
=3D"noreferrer" target=3D"_blank">http://community.redhat.com</a><br>
&gt; @scuttlemonkey || @ceph<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--94eb2c1cd54028890e0551edc62e--

--===============1625271172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1625271172==--
