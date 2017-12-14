From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Snap trim queue length issues
Date: Thu, 14 Dec 2017 16:31:20 +0000
Message-ID: <CAN-Gep+JEdr1V8B42YTy0rZzFM8B0TwHRqTs8WjrjcQm8tFgHA@mail.gmail.com>
References: <82009aab-6b20-ef21-9bbd-76fddf84e0a3@corp.ovh.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0273725534589214178=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <82009aab-6b20-ef21-9bbd-76fddf84e0a3-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0273725534589214178==
Content-Type: multipart/alternative; boundary="089e0822ba30a22b1405604f6ac0"

--089e0822ba30a22b1405604f6ac0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've tracked this in a much more manual way.  I would grab a random subset
of PGs in the pool and query the PGs counting how much were in there
queues.  After that, you average it out by how many PGs you queried and how
many objects there were and multiply it back out by how many PGs are in the
pool.  That gave us a relatively accurate size of the snaptrimq.  Well
enough to be monitored at least.  We could run this in a matter of minutes
with a subset of 200 PGs and it was generally accurate in a pool with 32k
pgs.

I also created a daemon that ran against the cluster watching for cluster
load and modifying the snap_trim_sleep accordingly.  The combination of
those 2 things and we were able to keep up with deleting hundreds of GB of
snapshots/day while not killing VM performance.  We hit a bug where we had
to disable snap trimming completely for about a week and on a dozen osds
for about a month.  We ended up with a snaptrimq over 100M objects, but
with these tools we were able to catch up within a couple weeks taking care
of the daily snapshots being added to the queue.

This was all on a Hammer cluster.  The changes to the snap trimming queues
going into the main osd thread made it so that our use case was not viable
on Jewel until changes to Jewel that happened after I left.  It's exciting
that this will actually be a reportable value from the cluster.

Sorry that this story doesn't really answer your question, except to say
that people aware of this problem likely have a work around for it.
However I'm certain that a lot more clusters are impacted by this than are
aware of it and being able to quickly see that would be beneficial to
troubleshooting problems.  Backporting would be nice.  I run a few Jewel
clusters that have some VM's and it would be nice to see how well the
cluster handle snap trimming.  But they are much less critical on how much
snapshots they do.

On Thu, Dec 14, 2017 at 9:36 AM Piotr Da=C5=82ek <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
wrote:

> Hi,
>
> We recently ran into low disk space issues on our clusters, and it wasn't
> because of actual data. On those affected clusters we're hosting VMs and
> volumes, so naturally there are snapshots involved. For some time, we
> observed increased disk space usage that we couldn't explain, as there wa=
s
> discrepancy between  what Ceph reported and actual space used on disks. W=
e
> finally found out that snap trim queues were both long and not getting an=
y
> shorter, and decreasing snap trim sleep and increasing max concurrent sna=
p
> trims helped reversing the trend - we're safe now.
> The problem is, we haven't been aware of this issue for some time, and
> there's no easy (and fast[1]) way to check this. I made a pull request[2]
> that makes snap trim queue lengths available to monitoring tools
> and also generates health warning when things go out of control, so an
> admin
> can act before hell breaks loose.
>
> My question is, how many Jewel users would be interested in a such featur=
e?
> There's a lot of changes between Luminous and Jewel, and it's not going t=
o
> be a straight backport, but it's not a big patch either, so I won't mind
> doing it myself. But having some support from users would be helpful in
> pushing this into next Jewel release.
>
> Thanks!
>
>
> [1] one of our guys hacked a bash oneliner that printed out snap trim que=
ue
> lengths for all pgs, but full run takes over an hour to complete on a
> cluster with over 20k pgs...
> [2] https://github.com/ceph/ceph/pull/19520
>
> --
> Piotr Da=C5=82ek
> piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org
> https://www.ovh.com/us/
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e0822ba30a22b1405604f6ac0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve tracked this in a much more manual way.=C2=A0 I w=
ould grab a random subset of PGs in the pool and query the PGs counting how=
 much were in there queues.=C2=A0 After that, you average it out by how man=
y PGs you queried and how many objects there were and multiply it back out =
by how many PGs are in the pool.=C2=A0 That gave us a relatively accurate s=
ize of the snaptrimq.=C2=A0 Well enough to be monitored at least.=C2=A0 We =
could run this in a matter of minutes with a subset of 200 PGs and it was g=
enerally accurate in a pool with 32k pgs.<div><br></div><div>I also created=
 a daemon that ran against the cluster watching for cluster load and modify=
ing the snap_trim_sleep accordingly.=C2=A0 The combination of those 2 thing=
s and we were able to keep up with deleting hundreds of GB of snapshots/day=
 while not killing VM performance.=C2=A0 We hit a bug where we had to disab=
le snap trimming completely for about a week and on a dozen osds for about =
a month.=C2=A0 We ended up with a snaptrimq over 100M objects, but with the=
se tools we were able to catch up within a couple weeks taking care of the =
daily snapshots being added to the queue.</div><div><br></div><div>This was=
 all on a Hammer cluster.=C2=A0 The changes to the snap trimming queues goi=
ng into the main osd thread made it so that our use case was not viable on =
Jewel until changes to Jewel that happened after I left.=C2=A0 It&#39;s exc=
iting that this will actually be a reportable value from the cluster.</div>=
<div><br></div><div>Sorry that this story doesn&#39;t really answer your qu=
estion, except to say that people aware of this problem likely have a work =
around for it.=C2=A0 However I&#39;m certain that a lot more clusters are i=
mpacted by this than are aware of it and being able to quickly see that wou=
ld be beneficial to troubleshooting problems.=C2=A0 Backporting would be ni=
ce.=C2=A0 I run a few Jewel clusters that have some VM&#39;s and it would b=
e nice to see how well the cluster handle snap trimming.=C2=A0 But they are=
 much less critical on how much snapshots they do.</div><div><br></div><div=
>On Thu, Dec 14, 2017 at 9:36 AM Piotr Da=C5=82ek &lt;<a href=3D"mailto:pio=
tr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org" target=3D"_blank">piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org</a>&gt; w=
rote:</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br=
>
<br>
We recently ran into low disk space issues on our clusters, and it wasn&#39=
;t<br>
because of actual data. On those affected clusters we&#39;re hosting VMs an=
d<br>
volumes, so naturally there are snapshots involved. For some time, we<br>
observed increased disk space usage that we couldn&#39;t explain, as there =
was<br>
discrepancy between=C2=A0 what Ceph reported and actual space used on disks=
. We<br>
finally found out that snap trim queues were both long and not getting any<=
br>
shorter, and decreasing snap trim sleep and increasing max concurrent snap<=
br>
trims helped reversing the trend - we&#39;re safe now.<br>
The problem is, we haven&#39;t been aware of this issue for some time, and<=
br>
there&#39;s no easy (and fast[1]) way to check this. I made a pull request[=
2]<br>
that makes snap trim queue lengths available to monitoring tools<br>
and also generates health warning when things go out of control, so an admi=
n<br>
can act before hell breaks loose.<br>
<br>
My question is, how many Jewel users would be interested in a such feature?=
<br>
There&#39;s a lot of changes between Luminous and Jewel, and it&#39;s not g=
oing to<br>
be a straight backport, but it&#39;s not a big patch either, so I won&#39;t=
 mind<br>
doing it myself. But having some support from users would be helpful in<br>
pushing this into next Jewel release.<br>
<br>
Thanks!<br>
<br>
<br>
[1] one of our guys hacked a bash oneliner that printed out snap trim queue=
<br>
lengths for all pgs, but full run takes over an hour to complete on a<br>
cluster with over 20k pgs...<br>
[2] <a href=3D"https://github.com/ceph/ceph/pull/19520" rel=3D"noreferrer" =
target=3D"_blank">https://github.com/ceph/ceph/pull/19520</a><br>
<br>
--<br>
Piotr Da=C5=82ek<br>
<a href=3D"mailto:piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org" target=3D"_blank">piotr.dalek@c=
orp.ovh.com</a><br>
<a href=3D"https://www.ovh.com/us/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://www.ovh.com/us/</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div>

--089e0822ba30a22b1405604f6ac0--

--===============0273725534589214178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0273725534589214178==--
