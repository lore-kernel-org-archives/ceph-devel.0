From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: newstore direction
Date: Thu, 22 Oct 2015 10:51:35 +0200
Message-ID: <1445503895.9019.11.camel@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
	 <56268886.7010806@redhat.com>
	 <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
	 <562775DD.8050304@redhat.com> <56279DD3.4020901@redhat.com>
	 <5627B471.1040602@redhat.com> <5627E96E.6090706@redhat.com>
	 <1445462425.24939.21.camel@millnert.se>
	 <7334B4281E425749B85E08CF7EC6F8534383E574@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbbJVIvk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Oct 2015 04:51:40 -0400
In-Reply-To: <7334B4281E425749B85E08CF7EC6F8534383E574@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Martin Millnert <martin@millnert.se>, Mark Nelson <mnelson@redhat.com>, Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 2015-10-22 at 02:12 +0000, Allen Samuels wrote:
> One of the biggest changes that flash is making in the storage world =
is that the way basic trade-offs in storage management software archite=
cture are being affected. In the HDD world CPU time per IOP was relativ=
ely inconsequential, i.e., it had little effect on overall performance =
which was limited by the physics of the hard drive. Flash is now invert=
ing that situation. When you look at the performance levels being deliv=
ered in the latest generation of NVMe SSDs you rapidly see that that st=
orage itself is generally no longer the bottleneck (speaking about BW, =
not latency of course) but rather it's the system sitting in front of t=
he storage that is the bottleneck. Generally it's the CPU cost of an IO=
P.
>=20
> When Sandisk first starting working with Ceph (Dumpling) the design o=
f librados and the OSD lead to the situation that the CPU cost of an IO=
P was dominated by context switches and network socket handling. Over t=
ime, much of that has been addressed. The socket handling code has been=
 re-written (more than once!) some of the internal queueing in the OSD =
(and the associated context switches) have been eliminated. As the CPU =
costs have dropped, performance on flash has improved accordingly.
>=20
> Because we didn't want to completely re-write the OSD (time-to-market=
 and stability drove that decision), we didn't move it from the current=
 "thread per IOP" model into a truly asynchronous "thread per CPU core"=
 model that essentially eliminates context switches in the IO path. But=
 a fully optimized OSD would go down that path (at least part-way). I b=
elieve it's been proposed in the past. Perhaps a hybrid "fast-path" sty=
le could get most of the benefits while preserving much of the legacy c=
ode.
>=20

+1
It not just reducing context switches but also about removing contentio=
n
and data copies and getting better cache utilization.

Scylladb just did this to cassandra (using seastar library):
http://www.zdnet.com/article/kvm-creators-open-source-fast-cassandra-dr=
op-in-replacement-scylla/

Orit

> I believe this trend toward thread-per-core software development will=
 also tend to support the "do it in user-space" trend. That's because m=
ost of the kernel and file-system interface is architected around the b=
locking "thread-per-IOP" model and is unlikely to change in the future.
>=20
>=20
> Allen Samuels
> Software Architect, Fellow, Systems and Software Solutions
>=20
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>=20
> -----Original Message-----
> From: Martin Millnert [mailto:martin@millnert.se]
> Sent: Thursday, October 22, 2015 6:20 AM
> To: Mark Nelson <mnelson@redhat.com>
> Cc: Ric Wheeler <rwheeler@redhat.com>; Allen Samuels <Allen.Samuels@s=
andisk.com>; Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> Subject: Re: newstore direction
>=20
> Adding 2c
>=20
> On Wed, 2015-10-21 at 14:37 -0500, Mark Nelson wrote:
> > My thought is that there is some inflection point where the userlan=
d
> > kvstore/block approach is going to be less work, for everyone I thi=
nk,
> > than trying to quickly discover, understand, fix, and push upstream
> > patches that sometimes only really benefit us.  I don't know if we'=
ve
> > truly hit that that point, but it's tough for me to find flaws with
> > Sage's argument.
>=20
> Regarding the userland / kernel land aspect of the topic, there are f=
urther aspects AFAIK not yet addressed in the thread:
> In the networking world, there's been development on memory mapped (m=
ultiple approaches exist) userland networking, which for packet managem=
ent has the benefit of - for very, very specific applications of networ=
king code - avoiding e.g. per-packet context switches etc, and streamli=
ning processor cache management performance. People have gone as far as=
 removing CPU cores from CPU scheduler to completely dedicate them to t=
he networking task at hand (cache optimizations). There are various lat=
ency/throughput (bulking) optimizations applicable, but at the end of t=
he day, it's about keeping the CPU bus busy with "revenue" bus traffic.
>=20
> Granted, storage IO operations may be much heavier in cycle counts fo=
r context switches to ever appear as a problem in themselves, certainly=
 for slower SSDs and HDDs. However, when going for truly high performan=
ce IO, *every* hurdle in the data path counts toward the total latency.
> (And really, high performance random IO characteristics approaches th=
e networking, per-packet handling characteristics).  Now, I'm not reall=
y suggesting memory-mapping a storage device to user space, not at all,=
 but having better control over the data path for a very specific use c=
ase, reduces dependency on the code that works as best as possible for =
the general case, and allows for very purpose-built code, to address a =
narrow set of requirements. ("Ceph storage cluster backend" isn't a typ=
ical FS use case.) It also decouples dependencies on users i.e.
> waiting for the next distro release before being able to take up the =
benefits of improvements to the storage code.
>=20
> A random google came up with related data on where "doing something w=
ay different" /can/ have significant benefits:
> http://phunq.net/pipermail/tux3/2015-April/002147.html
>=20
> I (FWIW) certainly agree there is merit to the idea.
> The scientific approach here could perhaps be to simply enumerate all=
 corner cases of "generic FS" that actually are cause for the experienc=
ed issues, and assess probability of them being solved (and if so when)=
=2E
> That *could* improve chances of approaching consensus which wouldn't =
hurt I suppose?
>=20
> BR,
> Martin
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>=20
> NrybX=C7=A7v^)=DE=BA{.n+z]z{ay=1D=CA=87=DA=99,j=07fhz=1Ew=0Cj:+vwjm=07=
zZ+=DD=A2j"!


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
