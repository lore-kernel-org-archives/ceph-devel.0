From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: data corruption with hammer
Date: Thu, 17 Mar 2016 12:39:51 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603171238540.14377@cpach.fuggernut.com>
References: <CAK9wOaA8_qpK1hNxQmY+zapaEedypzKdrChPUNWL+g-8YwfabQ@mail.gmail.com>
	<CAK9wOaA-o7ypB_O=vfgu=77zRt9HafWymBtsGt7zXpF53JY5Jg@mail.gmail.com>
	<CAK9wOaCTW=KFQE_HN+hon=dG5kxTFFGW78KJ-7h4knqLjiA-ng@mail.gmail.com>
	<def5db51.9Ro.9Gf.cC.1qX1QcBYq7@mailjet.com>
	<alpine.DEB.2.11.1603170823330.14377@cpach.fuggernut.com>
	<CAANLjFrabxuOkkWZrHS6ODmvG1Qx12Q1SeY8BUfQS-fKtOz=iw@mail.gmail.com>
	<alpine.DEB.2.11.1603171018330.14377@cpach.fuggernut.com>
	<CAANLjFoBOb=5_UpyGkp_8c509WkDE4YTo7oQbj5LW4c=v1wb7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1555998502-1458232794=:14377"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFoBOb=5_UpyGkp_8c509WkDE4YTo7oQbj5LW4c=v1wb7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, William Perkins <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1555998502-1458232794=:14377
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Mar 2016, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> I'm having trouble finding documentation about using ceph_test_rados. C=
an I=20
> run this on the existing cluster and will that provide useful info? It =
seems
>  running it in the build will not have the caching set up (vstart.sh).
>=20
> I have accepted a job with another company and only have until Wednesda=
y to=20
> help with getting information about this bug. My new job will not be us=
ing C
> eph, so I won't be able to provide any additional info after Tuesday. I=
 want
>  to leave the company on a good trajectory for upgrading, so any input =
you c
> an provide will be helpful.

I'm sorry to hear it!  You'll be missed.  :)

> I've found:
>=20
> ./ceph_test_rados --op read 100 --op write 100 --op delete 50
> - --max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
> - --min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
> - --op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
> rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0
>=20
> Is that enough if I change --pool to the cached pool and do the togglin=
g whi
> le ceph_test_rados is running? I think this will run for 10 minutes.

Precisely.  You can probably drop copy_from and snap ops from the list=20
since your workload wasn't exercising those.

Thanks!
sage


>=20
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.6
> Comment: https://www.mailvelope.com
>=20
> wsFcBAEBCAAQBQJW6tjwCRDmVDuy+mK58QAANKgP/ia5TA/7kTUpmciVR2BW
> t0MrilXAIvdikHlaWTVIxEmb4S8X+57hziEZUd6hLBMnKnuUQxsDb3yyuZX4
> iqaE8KBXDjMFjHnhTOFf7eB2JIjM1WkZxmlA23yBRMNtvlBArbwxYYnAyTXt
> /fW1QmgLZIvuql1y01TdRot/owqJ3B2Ah896lySrltWj626R+1rhTLVDWYr6
> EKa1mf8BiRBeGpjEVhN6Vihb7T1IzHtCi1E6+mlSqhWGNf8AeZh8IKUT0tbm
> C/JiUVGmG8/t7WFzCiQWd1w8UdkdCzms7k662CsSLIpbjNo4ouwEkpb5sZLP
> ELgWxo8hvad7USqSXvXqJNzmoenUwQwdUvSjYbNk+4D+8eHqptlNXDmDfpiE
> pN7dp8wbJ+yICxMPLuUe/Iqzp6rRnjPwam/CiDZu52N1ncH3X1X4u0cuAD0Z
> dFjEfdAZJAJ+fqvts2zVvtOwq/q41eTuV3ZRSn5ubA6iAeKnxMtPoEcuozEp
> Su1Iud2fYdma5w8MFStjp1BAV3osg1WgIM6KYzsSZI1BkCQAqU58ROZ0ZsMb
> D05/AEK/A6fp0ROXUczhXDcXlXcGEWyJm1QEtg7cSu3C+9qu5qvQQxyrrwbZ
> MK8C5lhVb44sqSVcSIZ+KCrPC+x8UKodDQZCz6O6NrJjZLn2g06583cMFWK8
> qLo+
> =3DqgB7
> -----END PGP SIGNATURE-----
>=20
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904 =C2=A0C70E E654 3BB2 FA62 B9F1
>=20
> On Thu, Mar 17, 2016 at 8:19 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>       On Thu, 17 Mar 2016, Robert LeBlanc wrote:
>       > We are trying to figure out how to use rados bench to
>       reproduce. Ceph
>       > itself doesn't seem to think there is any corruption, but when
>       you do a
>       > verify inside the RBD, there is. Can rados bench verify the
>       objects after
>       > they are written? It also seems to be primarily the filesystem
>       metadata
>       > that is corrupted. If we fsck the volume, there is missing
>       data (put into
>       > lost+found), but if it is there it is primarily OK. There only
>       seems to be
>       > a few cases where a file's contents are corrupted. I would
>       suspect on an
>       > object boundary. We would have to look at blockinfo to map
>       that out and see
>       > if that is what is happening.
>=20
>       'rados bench' doesn't do validation.=C2=A0 ceph_test_rados does,
>       though--if you
>       can reproduce with that workload then it should be pretty easy
>       to track
>       down.
>=20
>       Thanks!
>       sage
>=20
>=20
>       > We stopped all the IO and did put the tier in writeback mode
>       with recency
>       > 1,=C2=A0 set the recency to 2 and started the test and there wa=
s
>       corruption, so
>       > it doesn't seem to be limited to changing the mode. I don't
>       know how that
>       > patch could cause the issue either. Unless there is a bug that
>       reads from
>       > the back tier, but writes to cache tier, then the object gets
>       promoted
>       > wiping that last write, but then it seems like it should not
>       be as much
>       > corruption since the metadata should be in the cache pretty
>       quick. We
>       > usually evited the cache before each try so we should not be
>       evicting on
>       > writeback.
>       >
>       > Sent from a mobile device, please excuse any typos.
>       > On Mar 17, 2016 6:26 AM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>       >
>       > > On Thu, 17 Mar 2016, Nick Fisk wrote:
>       > > > There is got to be something else going on here. All that
>       PR does is to
>       > > > potentially delay the promotion to hit_set_period*recency
>       instead of
>       > > > just doing it on the 2nd read regardless, it's got to be
>       uncovering
>       > > > another bug.
>       > > >
>       > > > Do you see the same problem if the cache is in writeback
>       mode before you
>       > > > start the unpacking. Ie is it the switching mid operation
>       which causes
>       > > > the problem? If it only happens mid operation, does it
>       still occur if
>       > > > you pause IO when you make the switch?
>       > > >
>       > > > Do you also see this if you perform on a RBD mount, to
>       rule out any
>       > > > librbd/qemu weirdness?
>       > > >
>       > > > Do you know if it=E2=80=99s the actual data that is getting
>       corrupted or if it's
>       > > > the FS metadata? I'm only wondering as unpacking should
>       really only be
>       > > > writing to each object a couple of times, whereas FS
>       metadata could
>       > > > potentially be being updated+read back lots of times for
>       the same group
>       > > > of objects and ordering is very important.
>       > > >
>       > > > Thinking through it logically the only difference is that
>       with recency=3D1
>       > > > the object will be copied up to the cache tier, where
>       recency=3D6 it will
>       > > > be proxy read for a long time. If I had to guess I would
>       say the issue
>       > > > would lie somewhere in the proxy read +
>       writeback<->forward logic.
>       > >
>       > > That seems reasonable.=C2=A0 Was switching from writeback ->
>       forward always
>       > > part of the sequence that resulted in corruption?=C2=A0 Not t=
hat
>       there is a
>       > > known ordering issue when switching to forward mode.=C2=A0 I
>       wouldn't really
>       > > expect it to bite real users but it's possible..
>       > >
>       > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://tracker.ceph.com/issu=
es/12814
>       > >
>       > > I've opened a ticket to track this:
>       > >
>       > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://tracker.ceph.com/issu=
es/15171
>       > >
>       > > What would be *really* great is if you could reproduce this
>       with a
>       > > ceph_test_rados workload (from ceph-tests).=C2=A0 I.e., get
>       ceph_test_rados
>       > > running, and then find the sequence of operations that are
>       sufficient to
>       > > trigger a failure.
>       > >
>       > > sage
>       > >
>       > >
>       > >
>       > >=C2=A0 >
>       > > >
>       > > >
>       > > > > -----Original Message-----
>       > > > > From: ceph-users
>       [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf
>       > > Of
>       > > > > Mike Lovell
>       > > > > Sent: 16 March 2016 23:23
>       > > > > To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>;
>       sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>       > > > > Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>;
>       William Perkins
>       > > > > <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
>       > > > > Subject: Re: [ceph-users] data corruption with hammer
>       > > > >
>       > > > > just got done with a test against a build of 0.94.6
>       minus the two
>       > > commits that
>       > > > > were backported in PR 7207. everything worked as it
>       should with the
>       > > cache-
>       > > > > mode set to writeback and the
>       min_read_recency_for_promote set to 2.
>       > > > > assuming it works properly on master, there must be a
>       commit that we're
>       > > > > missing on the backport to support this properly.
>       > > > >
>       > > > > sage,
>       > > > > i'm adding you to the recipients on this so hopefully
>       you see it. the
>       > > tl;dr
>       > > > > version is that the backport of the cache recency fix to
>       hammer
>       > > doesn't work
>       > > > > right and potentially corrupts data when
>       > > > > the min_read_recency_for_promote is set to greater than
>       1.
>       > > > >
>       > > > > mike
>       > > > >
>       > > > > On Wed, Mar 16, 2016 at 4:41 PM, Mike Lovell
>       > > > > <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org> wrote:
>       > > > > robert and i have done some further investigation the
>       past couple days
>       > > on
>       > > > > this. we have a test environment with a hard drive tier
>       and an ssd
>       > > tier as a
>       > > > > cache. several vms were created with volumes from the
>       ceph cluster. i
>       > > did a
>       > > > > test in each guest where i un-tarred the linux kernel
>       source multiple
>       > > times
>       > > > > and then did a md5sum check against all of the files in
>       the resulting
>       > > source
>       > > > > tree. i started off with the monitors and osds running
>       0.94.5 and
>       > > never saw
>       > > > > any problems.
>       > > > >
>       > > > > a single node was then upgraded to 0.94.6 which has osds
>       in both the
>       > > ssd and
>       > > > > hard drive tier. i then proceeded to run the same test
>       and, while the
>       > > untar
>       > > > > and md5sum operations were running, i changed the ssd
>       tier cache-mode
>       > > > > from forward to writeback. almost immediately the vms
>       started
>       > > reporting io
>       > > > > errors and odd data corruption. the remainder of the
>       cluster was
>       > > updated to
>       > > > > 0.94.6, including the monitors, and the same thing
>       happened.
>       > > > >
>       > > > > things were cleaned up and reset and then a test was run
>       > > > > where min_read_recency_for_promote for the ssd cache
>       pool was set to 1.
>       > > > > we previously had it set to 6. there was never an error
>       with the
>       > > recency
>       > > > > setting set to 1. i then tested with it set to 2 and it
>       immediately
>       > > caused
>       > > > > failures. we are currently thinking that it is related
>       to the backport
>       > > of the fix
>       > > > > for the recency promotion and are in progress of making
>       a .6 build
>       > > without
>       > > > > that backport to see if we can cause corruption. is
>       anyone using a
>       > > version
>       > > > > from after the original recency fix (PR 6702) with a
>       cache tier in
>       > > writeback
>       > > > > mode? anyone have a similar problem?
>       > > > >
>       > > > > mike
>       > > > >
>       > > > > On Mon, Mar 14, 2016 at 8:51 PM, Mike Lovell
>       > > > > <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org> wrote:
>       > > > > something weird happened on one of the ceph clusters
>       that i administer
>       > > > > tonight which resulted in virtual machines using rbd
>       volumes seeing
>       > > > > corruption in multiple forms.
>       > > > >
>       > > > > when everything was fine earlier in the day, the cluster
>       was a number
>       > > of
>       > > > > storage nodes spread across 3 different roots in the
>       crush map. the
>       > > first
>       > > > > bunch of storage nodes have both hard drives and ssds in
>       them with the
>       > > hard
>       > > > > drives in one root and the ssds in another. there is a
>       pool for each
>       > > and the
>       > > > > pool for the ssds is a cache tier for the hard drives.
>       the last set of
>       > > storage
>       > > > > nodes were in a separate root with their own pool that
>       is being used
>       > > for burn
>       > > > > in testing.
>       > > > >
>       > > > > these nodes had run for a while with test traffic and we
>       decided to
>       > > move
>       > > > > them to the main root and pools. the main cluster is
>       running 0.94.5
>       > > and the
>       > > > > new nodes got 0.94.6 due to them getting configured
>       after that was
>       > > > > released. i removed the test pool and did a ceph osd
>       crush move to move
>       > > > > the first node into the main cluster, the hard drives
>       into the root
>       > > for that tier
>       > > > > of storage and the ssds into the root and pool for the
>       cache tier.
>       > > each set was
>       > > > > done about 45 minutes apart and they ran for a couple
>       hours while
>       > > > > performing backfill without any issue other than high
>       load on the
>       > > cluster.
>       > > > >
>       > > > > we normally run the ssd tier in the forward cache-mode
>       due to the ssds
>       > > we
>       > > > > have not being able to keep up with the io of writeback.
>       this results
>       > > in io on
>       > > > > the hard drives slowing going up and performance of the
>       cluster
>       > > starting to
>       > > > > suffer. about once a week, i change the cache-mode
>       between writeback
>       > > and
>       > > > > forward for short periods of time to promote actively
>       used data to the
>       > > cache
>       > > > > tier. this moves io load from the hard drive tier to the
>       ssd tier and
>       > > has been
>       > > > > done multiple times without issue. i normally don't do
>       this while
>       > > there are
>       > > > > backfills or recoveries happening on the cluster but
>       decided to go
>       > > ahead
>       > > > > while backfill was happening due to the high load.
>       > > > >
>       > > > > i tried this procedure to change the ssd cache-tier
>       between writeback
>       > > and
>       > > > > forward cache-mode and things seemed okay from the ceph
>       cluster. about
>       > > > > 10 minutes after the first attempt a changing the mode,
>       vms using the
>       > > ceph
>       > > > > cluster for their storage started seeing corruption in
>       multiple forms.
>       > > the
>       > > > > mode was flipped back and forth multiple times in that
>       time frame and
>       > > its
>       > > > > unknown if the corruption was noticed with the first
>       change or
>       > > subsequent
>       > > > > changes. the vms were having issues of filesystems
>       having errors and
>       > > getting
>       > > > > remounted RO and mysql databases seeing corruption (both
>       myisam and
>       > > > > innodb). some of this was recoverable but on some
>       filesystems there was
>       > > > > corruption that lead to things like lots of data ending
>       up in the
>       > > lost+found and
>       > > > > some of the databases were un-recoverable (backups are
>       helping there).
>       > > > >
>       > > > > i'm not sure what would have happened to cause this
>       corruption. the
>       > > libvirt
>       > > > > logs for the qemu processes for the vms did not provide
>       any output of
>       > > > > problems from the ceph client code. it doesn't look like
>       any of the
>       > > qemu
>       > > > > processes had crashed. also, it has now been several
>       hours since this
>       > > > > happened with no additional corruption noticed by the
>       vms. it doesn't
>       > > > > appear that we had any corruption happen before i
>       attempted the
>       > > flipping of
>       > > > > the ssd tier cache-mode.
>       > > > >
>       > > > > the only think i can think of that is different between
>       this time
>       > > doing this
>       > > > > procedure vs previous attempts was that there was the
>       one storage node
>       > > > > running 0.94.6 where the remainder were running 0.94.5.
>       is is possible
>       > > that
>       > > > > something changed between these two releases that would
>       have caused
>       > > > > problems with data consistency related to the cache
>       tier? or
>       > > otherwise? any
>       > > > > other thoughts or suggestions?
>       > > > >
>       > > > > thanks in advance for any help you can provide.
>       > > > >
>       > > > > mike
>       > > > >
>       > > >
>       > > >
>       > > >
>       > > >
>       > > _______________________________________________
>       > > ceph-users mailing list
>       > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>       > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>       > >
>       > >
>       >
>=20
>=20
>=20
>=20
--8323329-1555998502-1458232794=:14377
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1555998502-1458232794=:14377--
