From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: data corruption with hammer
Date: Thu, 17 Mar 2016 10:19:45 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603171018330.14377@cpach.fuggernut.com>
References: <CAK9wOaA8_qpK1hNxQmY+zapaEedypzKdrChPUNWL+g-8YwfabQ@mail.gmail.com>
	<CAK9wOaA-o7ypB_O=vfgu=77zRt9HafWymBtsGt7zXpF53JY5Jg@mail.gmail.com>
	<CAK9wOaCTW=KFQE_HN+hon=dG5kxTFFGW78KJ-7h4knqLjiA-ng@mail.gmail.com>
	<def5db51.9Ro.9Gf.cC.1qX1QcBYq7@mailjet.com>
	<alpine.DEB.2.11.1603170823330.14377@cpach.fuggernut.com>
	<CAANLjFrabxuOkkWZrHS6ODmvG1Qx12Q1SeY8BUfQS-fKtOz=iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2105719689-1458224388=:14377"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFrabxuOkkWZrHS6ODmvG1Qx12Q1SeY8BUfQS-fKtOz=iw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, William Perkins <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2105719689-1458224388=:14377
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Mar 2016, Robert LeBlanc wrote:
> We are trying to figure out how to use rados bench to reproduce. Ceph
> itself doesn't seem to think there is any corruption, but when you do a
> verify inside the RBD, there is. Can rados bench verify the objects aft=
er
> they are written? It also seems to be primarily the filesystem metadata
> that is corrupted. If we fsck the volume, there is missing data (put in=
to
> lost+found), but if it is there it is primarily OK. There only seems to=
 be
> a few cases where a file's contents are corrupted. I would suspect on a=
n
> object boundary. We would have to look at blockinfo to map that out and=
 see
> if that is what is happening.

'rados bench' doesn't do validation.  ceph_test_rados does, though--if yo=
u=20
can reproduce with that workload then it should be pretty easy to track=20
down.

Thanks!
sage

=20
> We stopped all the IO and did put the tier in writeback mode with recen=
cy
> 1,  set the recency to 2 and started the test and there was corruption,=
 so
> it doesn't seem to be limited to changing the mode. I don't know how th=
at
> patch could cause the issue either. Unless there is a bug that reads fr=
om
> the back tier, but writes to cache tier, then the object gets promoted
> wiping that last write, but then it seems like it should not be as much
> corruption since the metadata should be in the cache pretty quick. We
> usually evited the cache before each try so we should not be evicting o=
n
> writeback.
>=20
> Sent from a mobile device, please excuse any typos.
> On Mar 17, 2016 6:26 AM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> > On Thu, 17 Mar 2016, Nick Fisk wrote:
> > > There is got to be something else going on here. All that PR does i=
s to
> > > potentially delay the promotion to hit_set_period*recency instead o=
f
> > > just doing it on the 2nd read regardless, it's got to be uncovering
> > > another bug.
> > >
> > > Do you see the same problem if the cache is in writeback mode befor=
e you
> > > start the unpacking. Ie is it the switching mid operation which cau=
ses
> > > the problem? If it only happens mid operation, does it still occur =
if
> > > you pause IO when you make the switch?
> > >
> > > Do you also see this if you perform on a RBD mount, to rule out any
> > > librbd/qemu weirdness?
> > >
> > > Do you know if it=E2=80=99s the actual data that is getting corrupt=
ed or if it's
> > > the FS metadata? I'm only wondering as unpacking should really only=
 be
> > > writing to each object a couple of times, whereas FS metadata could
> > > potentially be being updated+read back lots of times for the same g=
roup
> > > of objects and ordering is very important.
> > >
> > > Thinking through it logically the only difference is that with rece=
ncy=3D1
> > > the object will be copied up to the cache tier, where recency=3D6 i=
t will
> > > be proxy read for a long time. If I had to guess I would say the is=
sue
> > > would lie somewhere in the proxy read + writeback<->forward logic.
> >
> > That seems reasonable.  Was switching from writeback -> forward alway=
s
> > part of the sequence that resulted in corruption?  Not that there is =
a
> > known ordering issue when switching to forward mode.  I wouldn't real=
ly
> > expect it to bite real users but it's possible..
> >
> >         http://tracker.ceph.com/issues/12814
> >
> > I've opened a ticket to track this:
> >
> >         http://tracker.ceph.com/issues/15171
> >
> > What would be *really* great is if you could reproduce this with a
> > ceph_test_rados workload (from ceph-tests).  I.e., get ceph_test_rado=
s
> > running, and then find the sequence of operations that are sufficient=
 to
> > trigger a failure.
> >
> > sage
> >
> >
> >
> >  >
> > >
> > >
> > > > -----Original Message-----
> > > > From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Be=
half
> > Of
> > > > Mike Lovell
> > > > Sent: 16 March 2016 23:23
> > > > To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>; sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > > > Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>; William Perkin=
s
> > > > <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
> > > > Subject: Re: [ceph-users] data corruption with hammer
> > > >
> > > > just got done with a test against a build of 0.94.6 minus the two
> > commits that
> > > > were backported in PR 7207. everything worked as it should with t=
he
> > cache-
> > > > mode set to writeback and the min_read_recency_for_promote set to=
 2.
> > > > assuming it works properly on master, there must be a commit that=
 we're
> > > > missing on the backport to support this properly.
> > > >
> > > > sage,
> > > > i'm adding you to the recipients on this so hopefully you see it.=
 the
> > tl;dr
> > > > version is that the backport of the cache recency fix to hammer
> > doesn't work
> > > > right and potentially corrupts data when
> > > > the min_read_recency_for_promote is set to greater than 1.
> > > >
> > > > mike
> > > >
> > > > On Wed, Mar 16, 2016 at 4:41 PM, Mike Lovell
> > > > <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org> wrote:
> > > > robert and i have done some further investigation the past couple=
 days
> > on
> > > > this. we have a test environment with a hard drive tier and an ss=
d
> > tier as a
> > > > cache. several vms were created with volumes from the ceph cluste=
r. i
> > did a
> > > > test in each guest where i un-tarred the linux kernel source mult=
iple
> > times
> > > > and then did a md5sum check against all of the files in the resul=
ting
> > source
> > > > tree. i started off with the monitors and osds running 0.94.5 and
> > never saw
> > > > any problems.
> > > >
> > > > a single node was then upgraded to 0.94.6 which has osds in both =
the
> > ssd and
> > > > hard drive tier. i then proceeded to run the same test and, while=
 the
> > untar
> > > > and md5sum operations were running, i changed the ssd tier cache-=
mode
> > > > from forward to writeback. almost immediately the vms started
> > reporting io
> > > > errors and odd data corruption. the remainder of the cluster was
> > updated to
> > > > 0.94.6, including the monitors, and the same thing happened.
> > > >
> > > > things were cleaned up and reset and then a test was run
> > > > where min_read_recency_for_promote for the ssd cache pool was set=
 to 1.
> > > > we previously had it set to 6. there was never an error with the
> > recency
> > > > setting set to 1. i then tested with it set to 2 and it immediate=
ly
> > caused
> > > > failures. we are currently thinking that it is related to the bac=
kport
> > of the fix
> > > > for the recency promotion and are in progress of making a .6 buil=
d
> > without
> > > > that backport to see if we can cause corruption. is anyone using =
a
> > version
> > > > from after the original recency fix (PR 6702) with a cache tier i=
n
> > writeback
> > > > mode? anyone have a similar problem?
> > > >
> > > > mike
> > > >
> > > > On Mon, Mar 14, 2016 at 8:51 PM, Mike Lovell
> > > > <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org> wrote:
> > > > something weird happened on one of the ceph clusters that i admin=
ister
> > > > tonight which resulted in virtual machines using rbd volumes seei=
ng
> > > > corruption in multiple forms.
> > > >
> > > > when everything was fine earlier in the day, the cluster was a nu=
mber
> > of
> > > > storage nodes spread across 3 different roots in the crush map. t=
he
> > first
> > > > bunch of storage nodes have both hard drives and ssds in them wit=
h the
> > hard
> > > > drives in one root and the ssds in another. there is a pool for e=
ach
> > and the
> > > > pool for the ssds is a cache tier for the hard drives. the last s=
et of
> > storage
> > > > nodes were in a separate root with their own pool that is being u=
sed
> > for burn
> > > > in testing.
> > > >
> > > > these nodes had run for a while with test traffic and we decided =
to
> > move
> > > > them to the main root and pools. the main cluster is running 0.94=
.5
> > and the
> > > > new nodes got 0.94.6 due to them getting configured after that wa=
s
> > > > released. i removed the test pool and did a ceph osd crush move t=
o move
> > > > the first node into the main cluster, the hard drives into the ro=
ot
> > for that tier
> > > > of storage and the ssds into the root and pool for the cache tier=
.
> > each set was
> > > > done about 45 minutes apart and they ran for a couple hours while
> > > > performing backfill without any issue other than high load on the
> > cluster.
> > > >
> > > > we normally run the ssd tier in the forward cache-mode due to the=
 ssds
> > we
> > > > have not being able to keep up with the io of writeback. this res=
ults
> > in io on
> > > > the hard drives slowing going up and performance of the cluster
> > starting to
> > > > suffer. about once a week, i change the cache-mode between writeb=
ack
> > and
> > > > forward for short periods of time to promote actively used data t=
o the
> > cache
> > > > tier. this moves io load from the hard drive tier to the ssd tier=
 and
> > has been
> > > > done multiple times without issue. i normally don't do this while
> > there are
> > > > backfills or recoveries happening on the cluster but decided to g=
o
> > ahead
> > > > while backfill was happening due to the high load.
> > > >
> > > > i tried this procedure to change the ssd cache-tier between write=
back
> > and
> > > > forward cache-mode and things seemed okay from the ceph cluster. =
about
> > > > 10 minutes after the first attempt a changing the mode, vms using=
 the
> > ceph
> > > > cluster for their storage started seeing corruption in multiple f=
orms.
> > the
> > > > mode was flipped back and forth multiple times in that time frame=
 and
> > its
> > > > unknown if the corruption was noticed with the first change or
> > subsequent
> > > > changes. the vms were having issues of filesystems having errors =
and
> > getting
> > > > remounted RO and mysql databases seeing corruption (both myisam a=
nd
> > > > innodb). some of this was recoverable but on some filesystems the=
re was
> > > > corruption that lead to things like lots of data ending up in the
> > lost+found and
> > > > some of the databases were un-recoverable (backups are helping th=
ere).
> > > >
> > > > i'm not sure what would have happened to cause this corruption. t=
he
> > libvirt
> > > > logs for the qemu processes for the vms did not provide any outpu=
t of
> > > > problems from the ceph client code. it doesn't look like any of t=
he
> > qemu
> > > > processes had crashed. also, it has now been several hours since =
this
> > > > happened with no additional corruption noticed by the vms. it doe=
sn't
> > > > appear that we had any corruption happen before i attempted the
> > flipping of
> > > > the ssd tier cache-mode.
> > > >
> > > > the only think i can think of that is different between this time
> > doing this
> > > > procedure vs previous attempts was that there was the one storage=
 node
> > > > running 0.94.6 where the remainder were running 0.94.5. is is pos=
sible
> > that
> > > > something changed between these two releases that would have caus=
ed
> > > > problems with data consistency related to the cache tier? or
> > otherwise? any
> > > > other thoughts or suggestions?
> > > >
> > > > thanks in advance for any help you can provide.
> > > >
> > > > mike
> > > >
> > >
> > >
> > >
> > >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
>=20
--8323329-2105719689-1458224388=:14377
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-2105719689-1458224388=:14377--
