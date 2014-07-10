From: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Subject: Re: I have PGs that I can't deep-scrub
Date: Thu, 10 Jul 2014 15:09:51 -0700
Message-ID: <CADHZLBaZD2+6S5u2OYLAhnibSCBswY+gZdj7rAWAcmsO0_zgoA@mail.gmail.com>
References: <CADHZLBa3z-7k28iL2SArQ+KYyBF0aUZEiAbASika8OEevpLk+A@mail.gmail.com>
	<alpine.DEB.2.00.1406110539520.2197@cobra.newdream.net>
	<CADHZLBa-gY++kzBko9pyDJdzHvXb5A85qEH9shpknKWjTdVrLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626679426=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADHZLBa-gY++kzBko9pyDJdzHvXb5A85qEH9shpknKWjTdVrLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1626679426==
Content-Type: multipart/alternative; boundary=f46d0418270ca23ccf04fdde1647

--f46d0418270ca23ccf04fdde1647
Content-Type: text/plain; charset=UTF-8

I fixed this issue by reformatting all of the OSDs.  I changed the mkfs
options from

[osd]
  osd mkfs type = xfs
  osd mkfs options xfs = -l size=1024m -n size=64k -i size=2048 -s size=4096

to
[osd]
  osd mkfs type = xfs
  osd mkfs options xfs = -s size=4096

(I have a mix of 512 and 4k sector drives, and I want to treat them all
like 4k sector).


Now deep scrub runs to completion, and CPU usage of the daemon never goes
over 30%.  I did have to restart a few OSDs when I scrubbed known problem
PGs, but they scrubbed the 2nd time successfully.  The cluster is still
scrubbing, but it's completed half with no more issues.



It took me a long time to correlate the "XFS: possible memory allocation
deadlock in kmem_alloc" message in dmesg to OSD problems.  It was only when
I started having these deep-scrub issues that the XFS deadlock messages
were well correlated with OSD issues.

Looking back at previous issues I had with OSDs flapping, the XFS deadlocks
were present, but usually preceded the issues by several hours.


I strongly recommend to anybody that sees "XFS: possible memory allocation
deadlock in kmem_alloc" in dmesg to reformat your XFS filesystems.  It's
painful, but my cluster has been rock solid since I finished.





On Wed, Jun 11, 2014 at 2:23 PM, Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
wrote:

> New logs, with debug ms = 1, debug osd = 20.
>
>
> In this timeline, I started the deep-scrub at 11:04:00  Ceph start
> deep-scrubing at 11:04:03.
>
> osd.11 started consuming 100% CPU around 11:07.  Same for osd.0.  CPU
> usage is all user; iowait is < 0.10%.  There is more variance in the
> CPU usage now, ranging between 98.5% and 101.2%
>
> This time, I didn't see any major IO, read or write.
>
> osd.11 was marked down at 11:22:00:
> 2014-06-11 11:22:00.820118 mon.0 [INF] osd.11 marked down after no pg
> stats for 902.656777seconds
>
> osd.0 was marked down at 11:36:00:
>  2014-06-11 11:36:00.890869 mon.0 [INF] osd.0 marked down after no pg
> stats for 902.498894seconds
>
>
>
>
> ceph.conf: https://cd.centraldesktop.com/p/eAAAAAAADwbcAAAAABIDZuE
> ceph-osd.0.log.gz
> <https://cd.centraldesktop.com/p/eAAAAAAADwbcAAAAABIDZuEceph-osd.0.log.gz>
> (140MiB, 18MiB compressed):
> https://cd.centraldesktop.com/p/eAAAAAAADwbdAAAAAHnmhFQ
> ceph-osd.11.log.gz (131MiB, 17MiB compressed):
> https://cd.centraldesktop.com/p/eAAAAAAADwbeAAAAAEUR9AI
> ceph pg 40.11e query:
> https://cd.centraldesktop.com/p/eAAAAAAADwbfAAAAAEJcwvc
>
>
>
>
>
> On Wed, Jun 11, 2014 at 5:42 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> > Hi Craig,
> >
> > It's hard to say what is going wrong with that level of logs.  Can you
> > reproduce with debug ms = 1 and debug osd = 20?
> >
> > There were a few things fixed in scrub between emperor and firefly.  Are
> > you planning on upgrading soon?
> >
> > sage
> >
> >
> > On Tue, 10 Jun 2014, Craig Lewis wrote:
> >
> >> Every time I deep-scrub one PG, all of the OSDs responsible get kicked
> >> out of the cluster.  I've deep-scrubbed this PG 4 times now, and it
> >> fails the same way every time.  OSD logs are linked at the bottom.
> >>
> >> What can I do to get this deep-scrub to complete cleanly?
> >>
> >> This is the first time I've deep-scrubbed these PGs since Sage helped
> >> me recover from some OSD problems
> >> (
> http://t53277.file-systems-ceph-development.file-systemstalk.info/70-osd-are-down-and-not-coming-up-t53277.html
> )
> >>
> >> I can trigger the issue easily in this cluster, but have not been able
> >> to re-create in other clusters.
> >>
> >>
> >>
> >>
> >>
> >>
> >> The PG stats for this PG say that last_deep_scrub and deep_scrub_stamp
> >> are 48009'1904117 2014-05-21 07:28:01.315996 respectively.  This PG is
> >> owned by OSDs [11,0]
> >>
> >> This is a secondary cluster, so I stopped all external I/O on it.  I
> >> set nodeep-scrub, and restarted both OSDs with:
> >>   debug osd = 5/5
> >>   debug filestore = 5/5
> >>   debug journal = 1
> >>   debug monc = 20/20
> >>
> >> then I ran a deep-scrub on this PG.
> >>
> >> 2014-06-10 10:47:50.881783 mon.0 [INF] pgmap v8832020: 2560 pgs: 2555
> >> active+clean, 5 active+clean+scrubbing; 27701 GB data, 56218 GB used,
> >> 77870 GB / 130 TB avail
> >> 2014-06-10 10:47:54.039829 mon.0 [INF] pgmap v8832021: 2560 pgs: 2554
> >> active+clean, 5 active+clean+scrubbing, 1 active+clean+scrubbing+deep;
> >> 27701 GB data, 56218 GB used, 77870 GB / 130 TB avail
> >>
> >>
> >> At 10:49:09, I see ceph-osd for both 11 and 0 spike to 100% CPU
> >> (100.3% +/- 1.0%).  Prior to this, they were both using ~30% CPU.  It
> >> might've started a few seconds sooner, I'm watching top.
> >>
> >> I forgot to watch IO stat until 10:56.  At this point, both OSDs are
> >> reading.  iostat reports that they're both doing ~100
> >> transactions/sec, reading ~1 MiBps, 0 writes.
> >>
> >>
> >> At 11:01:26, iostat reports that both osds are no longer consuming any
> >> disk I/O.  They both go for > 30 seconds with 0 transactions, and 0
> >> kiB read/write.  There are small bumps of 2 transactions/sec for one
> >> second, then it's back to 0.
> >>
> >>
> >> At 11:02:41, the primary OSD gets kicked out by the monitors:
> >> 2014-06-10 11:02:41.168443 mon.0 [INF] pgmap v8832125: 2560 pgs: 2555
> >> active+clean, 4 active+clean+scrubbing, 1 active+clean+scrubbing+deep;
> >> 27701 GB data, 56218 GB used, 77870 GB / 130 TB avail; 1996 B/s rd, 2
> >> op/s
> >> 2014-06-10 11:02:57.801047 mon.0 [INF] osd.11 marked down after no pg
> >> stats for 903.825187seconds
> >> 2014-06-10 11:02:57.823115 mon.0 [INF] osdmap e58834: 36 osds: 35 up,
> 36 in
> >>
> >> Both ceph-osd processes (11 and 0) continue to use 100% CPU (same
> range).
> >>
> >>
> >> At ~11:10, I see that osd.11 has resumed reading from disk at the
> >> original levels (~100 tps, ~1MiBps read, 0 MiBps write).  Since it's
> >> down, but doing something, I let it run.
> >>
> >> Both the osd.11 and osd.0 repeat this pattern.  Reading for a while at
> >> ~1 MiBps, then nothing.  The duty cycle seems about 50%, with a 20
> >> minute period, but I haven't timed anything.  CPU usage remains at
> >> 100%, regardless of whether IO is happening or not.
> >>
> >>
> >> At 12:24:15, osd.11 rejoins the cluster:
> >> 2014-06-10 12:24:15.294646 mon.0 [INF] osd.11 10.193.0.7:6804/7100 boot
> >> 2014-06-10 12:24:15.294725 mon.0 [INF] osdmap e58838: 36 osds: 35 up,
> 36 in
> >> 2014-06-10 12:24:15.343869 mon.0 [INF] pgmap v8832827: 2560 pgs: 1
> >> stale+active+clean+scrubbing+deep, 2266 active+clean, 5
> >> stale+active+clean, 287 active+degraded, 1 active+clean+scrubbing;
> >> 27701 GB data, 56218 GB used, 77870 GB / 130 TB avail; 15650 B/s rd,
> >> 18 op/s; 3617854/61758142 objects degraded (5.858%)
> >>
> >>
> >> osd.0's CPU usage drops back to normal when osd.11 rejoins the
> >> cluster.  The PG stats have not changed.   The last_deep_scrub and
> >> deep_scrub_stamp are still 48009'1904117 2014-05-21 07:28:01.315996
> >> respectively.
> >>
> >>
> >> This time, osd.0 did not get kicked out by the monitors.  In previous
> >> attempts, osd.0 was kicked out 5-10 minutes after osd.11.  When that
> >> happens, osd.0 rejoins the cluster after osd.11.
> >>
> >>
> >> I have several more PGs exhibiting the same behavior.  At least 3 that
> >> I know of, and many more that I haven't attempted to deep-scrub.
> >>
> >>
> >>
> >>
> >>
> >>
> >> ceph -v: ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
> >> ceph.conf: https://cd.centraldesktop.com/p/eAAAAAAADvxuAAAAAHJRUk4
> >> ceph-osd.11.log (5.7 MiB):
> >> https://cd.centraldesktop.com/p/eAAAAAAADvxyAAAAABPwaeM
> >> ceph-osd.0.log (6.3 MiB):
> >> https://cd.centraldesktop.com/p/eAAAAAAADvx0AAAAADWEGng
> >> ceph pg 40.11e query:
> https://cd.centraldesktop.com/p/eAAAAAAADvxvAAAAAAylTW0
> >>
> >> (the pg query was collected at 13:24, after the above events)
> >>
> >>
> >>
> >>
> >> Things that probably don't matter:
> >> The OSD partitions were created using ceph-disk-prepare --dmcrypt.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
>

--f46d0418270ca23ccf04fdde1647
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I fixed this issue by reformatting all of the OSDs. =C2=A0=
I changed the mkfs options from<div><br><div><div><font face=3D"courier new=
, monospace">[osd]</font></div><div><font face=3D"courier new, monospace">=
=C2=A0 osd mkfs type =3D xfs<br>


</font></div><div><font face=3D"courier new, monospace">=C2=A0 osd mkfs opt=
ions xfs =3D -l size=3D1024m -n size=3D64k -i size=3D2048 -s size=3D4096<br=
></font></div></div><div><br></div><div>to</div><div><div><font face=3D"cou=
rier new, monospace">[osd]</font></div>


<div><font face=3D"courier new, monospace">=C2=A0 osd mkfs type =3D xfs<br>=
</font></div><div><font face=3D"courier new, monospace">=C2=A0 osd mkfs opt=
ions xfs =3D -s size=3D4096<br></font></div></div><div><br></div><div>(I ha=
ve a mix of 512 and 4k sector drives, and I want to treat them all like 4k =
sector).</div>


<div><br></div><div><br></div><div>Now deep scrub runs to completion, and C=
PU usage of the daemon never goes over 30%. =C2=A0I did have to restart a f=
ew OSDs when I scrubbed known problem PGs, but they scrubbed the 2nd time s=
uccessfully. =C2=A0The cluster is still scrubbing, but it&#39;s completed h=
alf with no more issues.</div>

</div><div><br></div><div><br></div><div><br></div><div>It took me a long t=
ime to correlate the &quot;XFS: possible memory allocation deadlock in kmem=
_alloc&quot; message in dmesg to OSD problems. =C2=A0It was only when I sta=
rted having these deep-scrub issues that the XFS deadlock messages were wel=
l correlated with OSD issues.</div>

<div><br></div><div>Looking back at previous issues I had with OSDs flappin=
g, the XFS deadlocks were present, but usually preceded the issues by sever=
al hours.</div><div><br></div><div><br></div><div><div>I strongly recommend=
 to anybody that sees &quot;XFS: possible memory allocation deadlock in kme=
m_alloc&quot; in dmesg to reformat your XFS filesystems. =C2=A0It&#39;s pai=
nful, but my cluster has been rock solid since I finished.</div>

</div><div><br></div><div><br></div><div><br></div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">
On Wed, Jun 11, 2014 at 2:23 PM, Craig Lewis <span dir=3D"ltr">&lt;<a href=
=3D"mailto:clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org" target=3D"_blank">clewis@centraldeskt=
op.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex">


New logs, with debug ms =3D 1, debug osd =3D 20.<br>
<br>
<br>
In this timeline, I started the deep-scrub at 11:04:00 =C2=A0Ceph start<br>
deep-scrubing at 11:04:03.<br>
<br>
osd.11 started consuming 100% CPU around 11:07. =C2=A0Same for osd.0. =C2=
=A0CPU<br>
usage is all user; iowait is &lt; 0.10%. =C2=A0There is more variance in th=
e<br>
CPU usage now, ranging between 98.5% and 101.2%<br>
<br>
This time, I didn&#39;t see any major IO, read or write.<br>
<br>
osd.11 was marked down at 11:22:00:<br>
2014-06-11 11:22:00.820118 mon.0 [INF] osd.11 marked down after no pg<br>
stats for 902.656777seconds<br>
<br>
osd.0 was marked down at 11:36:00:<br>
=C2=A02014-06-11 11:36:00.890869 mon.0 [INF] osd.0 marked down after no pg<=
br>
stats for 902.498894seconds<br>
<br>
<br>
<br>
<br>
ceph.conf: <a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADwbcAAAAABIDZ=
uEceph-osd.0.log.gz" target=3D"_blank">https://cd.centraldesktop.com/p/eAAA=
AAAADwbcAAAAABIDZuE<br>
ceph-osd.0.log.gz</a> (140MiB, 18MiB compressed):<br>
<a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADwbdAAAAAHnmhFQ" target=
=3D"_blank">https://cd.centraldesktop.com/p/eAAAAAAADwbdAAAAAHnmhFQ</a><br>
ceph-osd.11.log.gz (131MiB, 17MiB compressed):<br>
<a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADwbeAAAAAEUR9AI" target=
=3D"_blank">https://cd.centraldesktop.com/p/eAAAAAAADwbeAAAAAEUR9AI</a><br>
ceph pg 40.11e query: <a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADw=
bfAAAAAEJcwvc" target=3D"_blank">https://cd.centraldesktop.com/p/eAAAAAAADw=
bfAAAAAEJcwvc</a><br>
<div><br>
<br>
<br>
<br>
<br>
On Wed, Jun 11, 2014 at 5:42 AM, Sage Weil &lt;<a href=3D"mailto:sage@inkta=
nk.com" target=3D"_blank">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
</div><div><div>&gt; Hi Craig,<br>
&gt;<br>
&gt; It&#39;s hard to say what is going wrong with that level of logs. =C2=
=A0Can you<br>
&gt; reproduce with debug ms =3D 1 and debug osd =3D 20?<br>
&gt;<br>
&gt; There were a few things fixed in scrub between emperor and firefly. =
=C2=A0Are<br>
&gt; you planning on upgrading soon?<br>
&gt;<br>
&gt; sage<br>
&gt;<br>
&gt;<br>
&gt; On Tue, 10 Jun 2014, Craig Lewis wrote:<br>
&gt;<br>
&gt;&gt; Every time I deep-scrub one PG, all of the OSDs responsible get ki=
cked<br>
&gt;&gt; out of the cluster. =C2=A0I&#39;ve deep-scrubbed this PG 4 times n=
ow, and it<br>
&gt;&gt; fails the same way every time. =C2=A0OSD logs are linked at the bo=
ttom.<br>
&gt;&gt;<br>
&gt;&gt; What can I do to get this deep-scrub to complete cleanly?<br>
&gt;&gt;<br>
&gt;&gt; This is the first time I&#39;ve deep-scrubbed these PGs since Sage=
 helped<br>
&gt;&gt; me recover from some OSD problems<br>
&gt;&gt; (<a href=3D"http://t53277.file-systems-ceph-development.file-syste=
mstalk.info/70-osd-are-down-and-not-coming-up-t53277.html" target=3D"_blank=
">http://t53277.file-systems-ceph-development.file-systemstalk.info/70-osd-=
are-down-and-not-coming-up-t53277.html</a>)<br>



&gt;&gt;<br>
&gt;&gt; I can trigger the issue easily in this cluster, but have not been =
able<br>
&gt;&gt; to re-create in other clusters.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; The PG stats for this PG say that last_deep_scrub and deep_scrub_s=
tamp<br>
&gt;&gt; are 48009&#39;1904117 2014-05-21 07:28:01.315996 respectively. =C2=
=A0This PG is<br>
&gt;&gt; owned by OSDs [11,0]<br>
&gt;&gt;<br>
&gt;&gt; This is a secondary cluster, so I stopped all external I/O on it. =
=C2=A0I<br>
&gt;&gt; set nodeep-scrub, and restarted both OSDs with:<br>
&gt;&gt; =C2=A0 debug osd =3D 5/5<br>
&gt;&gt; =C2=A0 debug filestore =3D 5/5<br>
&gt;&gt; =C2=A0 debug journal =3D 1<br>
&gt;&gt; =C2=A0 debug monc =3D 20/20<br>
&gt;&gt;<br>
&gt;&gt; then I ran a deep-scrub on this PG.<br>
&gt;&gt;<br>
&gt;&gt; 2014-06-10 10:47:50.881783 mon.0 [INF] pgmap v8832020: 2560 pgs: 2=
555<br>
&gt;&gt; active+clean, 5 active+clean+scrubbing; 27701 GB data, 56218 GB us=
ed,<br>
&gt;&gt; 77870 GB / 130 TB avail<br>
&gt;&gt; 2014-06-10 10:47:54.039829 mon.0 [INF] pgmap v8832021: 2560 pgs: 2=
554<br>
&gt;&gt; active+clean, 5 active+clean+scrubbing, 1 active+clean+scrubbing+d=
eep;<br>
&gt;&gt; 27701 GB data, 56218 GB used, 77870 GB / 130 TB avail<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; At 10:49:09, I see ceph-osd for both 11 and 0 spike to 100% CPU<br=
>
&gt;&gt; (100.3% +/- 1.0%). =C2=A0Prior to this, they were both using ~30% =
CPU. =C2=A0It<br>
&gt;&gt; might&#39;ve started a few seconds sooner, I&#39;m watching top.<b=
r>
&gt;&gt;<br>
&gt;&gt; I forgot to watch IO stat until 10:56. =C2=A0At this point, both O=
SDs are<br>
&gt;&gt; reading. =C2=A0iostat reports that they&#39;re both doing ~100<br>
&gt;&gt; transactions/sec, reading ~1 MiBps, 0 writes.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; At 11:01:26, iostat reports that both osds are no longer consuming=
 any<br>
&gt;&gt; disk I/O. =C2=A0They both go for &gt; 30 seconds with 0 transactio=
ns, and 0<br>
&gt;&gt; kiB read/write. =C2=A0There are small bumps of 2 transactions/sec =
for one<br>
&gt;&gt; second, then it&#39;s back to 0.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; At 11:02:41, the primary OSD gets kicked out by the monitors:<br>
&gt;&gt; 2014-06-10 11:02:41.168443 mon.0 [INF] pgmap v8832125: 2560 pgs: 2=
555<br>
&gt;&gt; active+clean, 4 active+clean+scrubbing, 1 active+clean+scrubbing+d=
eep;<br>
&gt;&gt; 27701 GB data, 56218 GB used, 77870 GB / 130 TB avail; 1996 B/s rd=
, 2<br>
&gt;&gt; op/s<br>
&gt;&gt; 2014-06-10 11:02:57.801047 mon.0 [INF] osd.11 marked down after no=
 pg<br>
&gt;&gt; stats for 903.825187seconds<br>
&gt;&gt; 2014-06-10 11:02:57.823115 mon.0 [INF] osdmap e58834: 36 osds: 35 =
up, 36 in<br>
&gt;&gt;<br>
&gt;&gt; Both ceph-osd processes (11 and 0) continue to use 100% CPU (same =
range).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; At ~11:10, I see that osd.11 has resumed reading from disk at the<=
br>
&gt;&gt; original levels (~100 tps, ~1MiBps read, 0 MiBps write). =C2=A0Sin=
ce it&#39;s<br>
&gt;&gt; down, but doing something, I let it run.<br>
&gt;&gt;<br>
&gt;&gt; Both the osd.11 and osd.0 repeat this pattern. =C2=A0Reading for a=
 while at<br>
&gt;&gt; ~1 MiBps, then nothing. =C2=A0The duty cycle seems about 50%, with=
 a 20<br>
&gt;&gt; minute period, but I haven&#39;t timed anything. =C2=A0CPU usage r=
emains at<br>
&gt;&gt; 100%, regardless of whether IO is happening or not.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; At 12:24:15, osd.11 rejoins the cluster:<br>
&gt;&gt; 2014-06-10 12:24:15.294646 mon.0 [INF] osd.11 <a href=3D"http://10=
.193.0.7:6804/7100" target=3D"_blank">10.193.0.7:6804/7100</a> boot<br>
&gt;&gt; 2014-06-10 12:24:15.294725 mon.0 [INF] osdmap e58838: 36 osds: 35 =
up, 36 in<br>
&gt;&gt; 2014-06-10 12:24:15.343869 mon.0 [INF] pgmap v8832827: 2560 pgs: 1=
<br>
&gt;&gt; stale+active+clean+scrubbing+deep, 2266 active+clean, 5<br>
&gt;&gt; stale+active+clean, 287 active+degraded, 1 active+clean+scrubbing;=
<br>
&gt;&gt; 27701 GB data, 56218 GB used, 77870 GB / 130 TB avail; 15650 B/s r=
d,<br>
&gt;&gt; 18 op/s; 3617854/61758142 objects degraded (5.858%)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; osd.0&#39;s CPU usage drops back to normal when osd.11 rejoins the=
<br>
&gt;&gt; cluster. =C2=A0The PG stats have not changed. =C2=A0 The last_deep=
_scrub and<br>
&gt;&gt; deep_scrub_stamp are still 48009&#39;1904117 2014-05-21 07:28:01.3=
15996<br>
&gt;&gt; respectively.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; This time, osd.0 did not get kicked out by the monitors. =C2=A0In =
previous<br>
&gt;&gt; attempts, osd.0 was kicked out 5-10 minutes after osd.11. =C2=A0Wh=
en that<br>
&gt;&gt; happens, osd.0 rejoins the cluster after osd.11.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I have several more PGs exhibiting the same behavior. =C2=A0At lea=
st 3 that<br>
&gt;&gt; I know of, and many more that I haven&#39;t attempted to deep-scru=
b.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ceph -v: ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099c=
fd60)<br>
&gt;&gt; ceph.conf: <a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADvxu=
AAAAAHJRUk4" target=3D"_blank">https://cd.centraldesktop.com/p/eAAAAAAADvxu=
AAAAAHJRUk4</a><br>
&gt;&gt; ceph-osd.11.log (5.7 MiB):<br>
&gt;&gt; <a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADvxyAAAAABPwaeM=
" target=3D"_blank">https://cd.centraldesktop.com/p/eAAAAAAADvxyAAAAABPwaeM=
</a><br>
&gt;&gt; ceph-osd.0.log (6.3 MiB):<br>
&gt;&gt; <a href=3D"https://cd.centraldesktop.com/p/eAAAAAAADvx0AAAAADWEGng=
" target=3D"_blank">https://cd.centraldesktop.com/p/eAAAAAAADvx0AAAAADWEGng=
</a><br>
&gt;&gt; ceph pg 40.11e query: <a href=3D"https://cd.centraldesktop.com/p/e=
AAAAAAADvxvAAAAAAylTW0" target=3D"_blank">https://cd.centraldesktop.com/p/e=
AAAAAAADvxvAAAAAAylTW0</a><br>
&gt;&gt;<br>
&gt;&gt; (the pg query was collected at 13:24, after the above events)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Things that probably don&#39;t matter:<br>
&gt;&gt; The OSD partitions were created using ceph-disk-prepare --dmcrypt.=
<br>
&gt;&gt; --<br>
&gt;&gt; To unsubscribe from this list: send the line &quot;unsubscribe cep=
h-devel&quot; in<br>
&gt;&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TbrhsbdSgBK9A@public.gmane.org=
rg" target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt;&gt; More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/maj=
ordomo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.h=
tml</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
</div></div></blockquote></div><br></div></div>

--f46d0418270ca23ccf04fdde1647--

--===============1626679426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1626679426==--
