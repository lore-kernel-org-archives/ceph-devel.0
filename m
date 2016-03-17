From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: data corruption with hammer
Date: Thu, 17 Mar 2016 10:19:01 -0600
Message-ID: <CAANLjFoBOb=5_UpyGkp_8c509WkDE4YTo7oQbj5LW4c=v1wb7A@mail.gmail.com>
References: <CAK9wOaA8_qpK1hNxQmY+zapaEedypzKdrChPUNWL+g-8YwfabQ@mail.gmail.com>
	<CAK9wOaA-o7ypB_O=vfgu=77zRt9HafWymBtsGt7zXpF53JY5Jg@mail.gmail.com>
	<CAK9wOaCTW=KFQE_HN+hon=dG5kxTFFGW78KJ-7h4knqLjiA-ng@mail.gmail.com>
	<def5db51.9Ro.9Gf.cC.1qX1QcBYq7@mailjet.com>
	<alpine.DEB.2.11.1603170823330.14377@cpach.fuggernut.com>
	<CAANLjFrabxuOkkWZrHS6ODmvG1Qx12Q1SeY8BUfQS-fKtOz=iw@mail.gmail.com>
	<alpine.DEB.2.11.1603171018330.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0210341460=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1603171018330.14377-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, William Perkins <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0210341460==
Content-Type: multipart/alternative; boundary=001a11433da804f1a0052e40fdac

--001a11433da804f1a0052e40fdac
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm having trouble finding documentation about using ceph_test_rados.
Can I run this on the existing cluster and will that provide useful
info? It seems running it in the build will not have the caching set
up (vstart.sh).

I have accepted a job with another company and only have until
Wednesday to help with getting information about this bug. My new job
will not be using Ceph, so I won't be able to provide any additional
info after Tuesday. I want to leave the company on a good trajectory
for upgrading, so any input you can provide will be helpful.

I've found:

./ceph_test_rados --op read 100 --op write 100 --op delete 50
- --max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
- --min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
- --op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0

Is that enough if I change --pool to the cached pool and do the
toggling while ceph_test_rados is running? I think this will run for
10 minutes.

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJW6tjwCRDmVDuy+mK58QAANKgP/ia5TA/7kTUpmciVR2BW
t0MrilXAIvdikHlaWTVIxEmb4S8X+57hziEZUd6hLBMnKnuUQxsDb3yyuZX4
iqaE8KBXDjMFjHnhTOFf7eB2JIjM1WkZxmlA23yBRMNtvlBArbwxYYnAyTXt
/fW1QmgLZIvuql1y01TdRot/owqJ3B2Ah896lySrltWj626R+1rhTLVDWYr6
EKa1mf8BiRBeGpjEVhN6Vihb7T1IzHtCi1E6+mlSqhWGNf8AeZh8IKUT0tbm
C/JiUVGmG8/t7WFzCiQWd1w8UdkdCzms7k662CsSLIpbjNo4ouwEkpb5sZLP
ELgWxo8hvad7USqSXvXqJNzmoenUwQwdUvSjYbNk+4D+8eHqptlNXDmDfpiE
pN7dp8wbJ+yICxMPLuUe/Iqzp6rRnjPwam/CiDZu52N1ncH3X1X4u0cuAD0Z
dFjEfdAZJAJ+fqvts2zVvtOwq/q41eTuV3ZRSn5ubA6iAeKnxMtPoEcuozEp
Su1Iud2fYdma5w8MFStjp1BAV3osg1WgIM6KYzsSZI1BkCQAqU58ROZ0ZsMb
D05/AEK/A6fp0ROXUczhXDcXlXcGEWyJm1QEtg7cSu3C+9qu5qvQQxyrrwbZ
MK8C5lhVb44sqSVcSIZ+KCrPC+x8UKodDQZCz6O6NrJjZLn2g06583cMFWK8
qLo+
=3DqgB7
-----END PGP SIGNATURE-----


----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

On Thu, Mar 17, 2016 at 8:19 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu, 17 Mar 2016, Robert LeBlanc wrote:
> > We are trying to figure out how to use rados bench to reproduce. Ceph
> > itself doesn't seem to think there is any corruption, but when you do a
> > verify inside the RBD, there is. Can rados bench verify the objects aft=
er
> > they are written? It also seems to be primarily the filesystem metadata
> > that is corrupted. If we fsck the volume, there is missing data (put in=
to
> > lost+found), but if it is there it is primarily OK. There only seems to
> be
> > a few cases where a file's contents are corrupted. I would suspect on a=
n
> > object boundary. We would have to look at blockinfo to map that out and
> see
> > if that is what is happening.
>
> 'rados bench' doesn't do validation.  ceph_test_rados does, though--if yo=
u
> can reproduce with that workload then it should be pretty easy to track
> down.
>
> Thanks!
> sage
>
>
> > We stopped all the IO and did put the tier in writeback mode with recen=
cy
> > 1,  set the recency to 2 and started the test and there was corruption,
> so
> > it doesn't seem to be limited to changing the mode. I don't know how th=
at
> > patch could cause the issue either. Unless there is a bug that reads fr=
om
> > the back tier, but writes to cache tier, then the object gets promoted
> > wiping that last write, but then it seems like it should not be as much
> > corruption since the metadata should be in the cache pretty quick. We
> > usually evited the cache before each try so we should not be evicting o=
n
> > writeback.
> >
> > Sent from a mobile device, please excuse any typos.
> > On Mar 17, 2016 6:26 AM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > > On Thu, 17 Mar 2016, Nick Fisk wrote:
> > > > There is got to be something else going on here. All that PR does i=
s
> to
> > > > potentially delay the promotion to hit_set_period*recency instead o=
f
> > > > just doing it on the 2nd read regardless, it's got to be uncovering
> > > > another bug.
> > > >
> > > > Do you see the same problem if the cache is in writeback mode befor=
e
> you
> > > > start the unpacking. Ie is it the switching mid operation which
> causes
> > > > the problem? If it only happens mid operation, does it still occur =
if
> > > > you pause IO when you make the switch?
> > > >
> > > > Do you also see this if you perform on a RBD mount, to rule out any
> > > > librbd/qemu weirdness?
> > > >
> > > > Do you know if it=E2=80=99s the actual data that is getting corrupt=
ed or if
> it's
> > > > the FS metadata? I'm only wondering as unpacking should really only
> be
> > > > writing to each object a couple of times, whereas FS metadata could
> > > > potentially be being updated+read back lots of times for the same
> group
> > > > of objects and ordering is very important.
> > > >
> > > > Thinking through it logically the only difference is that with
> recency=3D1
> > > > the object will be copied up to the cache tier, where recency=3D6 i=
t
> will
> > > > be proxy read for a long time. If I had to guess I would say the
> issue
> > > > would lie somewhere in the proxy read + writeback<->forward logic.
> > >
> > > That seems reasonable.  Was switching from writeback -> forward alway=
s
> > > part of the sequence that resulted in corruption?  Not that there is =
a
> > > known ordering issue when switching to forward mode.  I wouldn't real=
ly
> > > expect it to bite real users but it's possible..
> > >
> > >         http://tracker.ceph.com/issues/12814
> > >
> > > I've opened a ticket to track this:
> > >
> > >         http://tracker.ceph.com/issues/15171
> > >
> > > What would be *really* great is if you could reproduce this with a
> > > ceph_test_rados workload (from ceph-tests).  I.e., get ceph_test_rado=
s
> > > running, and then find the sequence of operations that are sufficient
> to
> > > trigger a failure.
> > >
> > > sage
> > >
> > >
> > >
> > >  >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On
> Behalf
> > > Of
> > > > > Mike Lovell
> > > > > Sent: 16 March 2016 23:23
> > > > > To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>; sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > > > > Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>; William Perkin=
s
> > > > > <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
> > > > > Subject: Re: [ceph-users] data corruption with hammer
> > > > >
> > > > > just got done with a test against a build of 0.94.6 minus the two
> > > commits that
> > > > > were backported in PR 7207. everything worked as it should with t=
he
> > > cache-
> > > > > mode set to writeback and the min_read_recency_for_promote set to
> 2.
> > > > > assuming it works properly on master, there must be a commit that
> we're
> > > > > missing on the backport to support this properly.
> > > > >
> > > > > sage,
> > > > > i'm adding you to the recipients on this so hopefully you see it.
> the
> > > tl;dr
> > > > > version is that the backport of the cache recency fix to hammer
> > > doesn't work
> > > > > right and potentially corrupts data when
> > > > > the min_read_recency_for_promote is set to greater than 1.
> > > > >
> > > > > mike
> > > > >
> > > > > On Wed, Mar 16, 2016 at 4:41 PM, Mike Lovell
> > > > > <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org> wrote:
> > > > > robert and i have done some further investigation the past couple
> days
> > > on
> > > > > this. we have a test environment with a hard drive tier and an ss=
d
> > > tier as a
> > > > > cache. several vms were created with volumes from the ceph
> cluster. i
> > > did a
> > > > > test in each guest where i un-tarred the linux kernel source
> multiple
> > > times
> > > > > and then did a md5sum check against all of the files in the
> resulting
> > > source
> > > > > tree. i started off with the monitors and osds running 0.94.5 and
> > > never saw
> > > > > any problems.
> > > > >
> > > > > a single node was then upgraded to 0.94.6 which has osds in both
> the
> > > ssd and
> > > > > hard drive tier. i then proceeded to run the same test and, while
> the
> > > untar
> > > > > and md5sum operations were running, i changed the ssd tier
> cache-mode
> > > > > from forward to writeback. almost immediately the vms started
> > > reporting io
> > > > > errors and odd data corruption. the remainder of the cluster was
> > > updated to
> > > > > 0.94.6, including the monitors, and the same thing happened.
> > > > >
> > > > > things were cleaned up and reset and then a test was run
> > > > > where min_read_recency_for_promote for the ssd cache pool was set
> to 1.
> > > > > we previously had it set to 6. there was never an error with the
> > > recency
> > > > > setting set to 1. i then tested with it set to 2 and it immediate=
ly
> > > caused
> > > > > failures. we are currently thinking that it is related to the
> backport
> > > of the fix
> > > > > for the recency promotion and are in progress of making a .6 buil=
d
> > > without
> > > > > that backport to see if we can cause corruption. is anyone using =
a
> > > version
> > > > > from after the original recency fix (PR 6702) with a cache tier i=
n
> > > writeback
> > > > > mode? anyone have a similar problem?
> > > > >
> > > > > mike
> > > > >
> > > > > On Mon, Mar 14, 2016 at 8:51 PM, Mike Lovell
> > > > > <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org> wrote:
> > > > > something weird happened on one of the ceph clusters that i
> administer
> > > > > tonight which resulted in virtual machines using rbd volumes seei=
ng
> > > > > corruption in multiple forms.
> > > > >
> > > > > when everything was fine earlier in the day, the cluster was a
> number
> > > of
> > > > > storage nodes spread across 3 different roots in the crush map. t=
he
> > > first
> > > > > bunch of storage nodes have both hard drives and ssds in them wit=
h
> the
> > > hard
> > > > > drives in one root and the ssds in another. there is a pool for
> each
> > > and the
> > > > > pool for the ssds is a cache tier for the hard drives. the last
> set of
> > > storage
> > > > > nodes were in a separate root with their own pool that is being
> used
> > > for burn
> > > > > in testing.
> > > > >
> > > > > these nodes had run for a while with test traffic and we decided =
to
> > > move
> > > > > them to the main root and pools. the main cluster is running 0.94=
.5
> > > and the
> > > > > new nodes got 0.94.6 due to them getting configured after that wa=
s
> > > > > released. i removed the test pool and did a ceph osd crush move t=
o
> move
> > > > > the first node into the main cluster, the hard drives into the ro=
ot
> > > for that tier
> > > > > of storage and the ssds into the root and pool for the cache tier=
.
> > > each set was
> > > > > done about 45 minutes apart and they ran for a couple hours while
> > > > > performing backfill without any issue other than high load on the
> > > cluster.
> > > > >
> > > > > we normally run the ssd tier in the forward cache-mode due to the
> ssds
> > > we
> > > > > have not being able to keep up with the io of writeback. this
> results
> > > in io on
> > > > > the hard drives slowing going up and performance of the cluster
> > > starting to
> > > > > suffer. about once a week, i change the cache-mode between
> writeback
> > > and
> > > > > forward for short periods of time to promote actively used data t=
o
> the
> > > cache
> > > > > tier. this moves io load from the hard drive tier to the ssd tier
> and
> > > has been
> > > > > done multiple times without issue. i normally don't do this while
> > > there are
> > > > > backfills or recoveries happening on the cluster but decided to g=
o
> > > ahead
> > > > > while backfill was happening due to the high load.
> > > > >
> > > > > i tried this procedure to change the ssd cache-tier between
> writeback
> > > and
> > > > > forward cache-mode and things seemed okay from the ceph cluster.
> about
> > > > > 10 minutes after the first attempt a changing the mode, vms using
> the
> > > ceph
> > > > > cluster for their storage started seeing corruption in multiple
> forms.
> > > the
> > > > > mode was flipped back and forth multiple times in that time frame
> and
> > > its
> > > > > unknown if the corruption was noticed with the first change or
> > > subsequent
> > > > > changes. the vms were having issues of filesystems having errors
> and
> > > getting
> > > > > remounted RO and mysql databases seeing corruption (both myisam a=
nd
> > > > > innodb). some of this was recoverable but on some filesystems
> there was
> > > > > corruption that lead to things like lots of data ending up in the
> > > lost+found and
> > > > > some of the databases were un-recoverable (backups are helping
> there).
> > > > >
> > > > > i'm not sure what would have happened to cause this corruption. t=
he
> > > libvirt
> > > > > logs for the qemu processes for the vms did not provide any outpu=
t
> of
> > > > > problems from the ceph client code. it doesn't look like any of t=
he
> > > qemu
> > > > > processes had crashed. also, it has now been several hours since
> this
> > > > > happened with no additional corruption noticed by the vms. it
> doesn't
> > > > > appear that we had any corruption happen before i attempted the
> > > flipping of
> > > > > the ssd tier cache-mode.
> > > > >
> > > > > the only think i can think of that is different between this time
> > > doing this
> > > > > procedure vs previous attempts was that there was the one storage
> node
> > > > > running 0.94.6 where the remainder were running 0.94.5. is is
> possible
> > > that
> > > > > something changed between these two releases that would have caus=
ed
> > > > > problems with data consistency related to the cache tier? or
> > > otherwise? any
> > > > > other thoughts or suggestions?
> > > > >
> > > > > thanks in advance for any help you can provide.
> > > > >
> > > > > mike
> > > > >
> > > >
> > > >
> > > >
> > > >
> > > _______________________________________________
> > > ceph-users mailing list
> > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >
> > >
> >
>

--001a11433da804f1a0052e40fdac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre>-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I&#39;m having trouble finding documentation about using ceph_test_rados. C=
an I run this on the existing cluster and will that provide useful info? It=
 seems running it in the build will not have the caching set up (vstart.sh)=
.

I have accepted a job with another company and only have until Wednesday to=
 help with getting information about this bug. My new job will not be using=
 Ceph, so I won&#39;t be able to provide any additional info after Tuesday.=
 I want to leave the company on a good trajectory for upgrading, so any inp=
ut you can provide will be helpful.

I&#39;ve found:

./ceph_test_rados --op read 100 --op write 100 --op delete 50
- --max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
- --min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
- --op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0

Is that enough if I change --pool to the cached pool and do the toggling wh=
ile ceph_test_rados is running? I think this will run for 10 minutes.

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: <a href=3D"https://www.mailvelope.com">https://www.mailvelope.com<=
/a>

wsFcBAEBCAAQBQJW6tjwCRDmVDuy+mK58QAANKgP/ia5TA/7kTUpmciVR2BW
t0MrilXAIvdikHlaWTVIxEmb4S8X+57hziEZUd6hLBMnKnuUQxsDb3yyuZX4
iqaE8KBXDjMFjHnhTOFf7eB2JIjM1WkZxmlA23yBRMNtvlBArbwxYYnAyTXt
/fW1QmgLZIvuql1y01TdRot/owqJ3B2Ah896lySrltWj626R+1rhTLVDWYr6
EKa1mf8BiRBeGpjEVhN6Vihb7T1IzHtCi1E6+mlSqhWGNf8AeZh8IKUT0tbm
C/JiUVGmG8/t7WFzCiQWd1w8UdkdCzms7k662CsSLIpbjNo4ouwEkpb5sZLP
ELgWxo8hvad7USqSXvXqJNzmoenUwQwdUvSjYbNk+4D+8eHqptlNXDmDfpiE
pN7dp8wbJ+yICxMPLuUe/Iqzp6rRnjPwam/CiDZu52N1ncH3X1X4u0cuAD0Z
dFjEfdAZJAJ+fqvts2zVvtOwq/q41eTuV3ZRSn5ubA6iAeKnxMtPoEcuozEp
Su1Iud2fYdma5w8MFStjp1BAV3osg1WgIM6KYzsSZI1BkCQAqU58ROZ0ZsMb
D05/AEK/A6fp0ROXUczhXDcXlXcGEWyJm1QEtg7cSu3C+9qu5qvQQxyrrwbZ
MK8C5lhVb44sqSVcSIZ+KCrPC+x8UKodDQZCz6O6NrJjZLn2g06583cMFWK8
qLo+
=3DqgB7
-----END PGP SIGNATURE-----
<pre></pre></pre></div><div class=3D"gmail_extra"><br clear=3D"all"><div><d=
iv class=3D"gmail_signature">----------------<br>Robert LeBlanc<br>PGP Fing=
erprint 79A2 9CA4 6CC4 45DD A904 =C2=A0C70E E654 3BB2 FA62 B9F1</div></div>
<br><div class=3D"gmail_quote">On Thu, Mar 17, 2016 at 8:19 AM, Sage Weil <=
span dir=3D"ltr">&lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">=
sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><s=
pan class=3D"">On Thu, 17 Mar 2016, Robert LeBlanc wrote:<br>
&gt; We are trying to figure out how to use rados bench to reproduce. Ceph<=
br>
&gt; itself doesn&#39;t seem to think there is any corruption, but when you=
 do a<br>
&gt; verify inside the RBD, there is. Can rados bench verify the objects af=
ter<br>
&gt; they are written? It also seems to be primarily the filesystem metadat=
a<br>
&gt; that is corrupted. If we fsck the volume, there is missing data (put i=
nto<br>
&gt; lost+found), but if it is there it is primarily OK. There only seems t=
o be<br>
&gt; a few cases where a file&#39;s contents are corrupted. I would suspect=
 on an<br>
&gt; object boundary. We would have to look at blockinfo to map that out an=
d see<br>
&gt; if that is what is happening.<br>
<br>
</span>&#39;rados bench&#39; doesn&#39;t do validation.=C2=A0 ceph_test_rad=
os does, though--if you<br>
can reproduce with that workload then it should be pretty easy to track<br>
down.<br>
<br>
Thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">sage<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; We stopped all the IO and did put the tier in writeback mode with rece=
ncy<br>
&gt; 1,=C2=A0 set the recency to 2 and started the test and there was corru=
ption, so<br>
&gt; it doesn&#39;t seem to be limited to changing the mode. I don&#39;t kn=
ow how that<br>
&gt; patch could cause the issue either. Unless there is a bug that reads f=
rom<br>
&gt; the back tier, but writes to cache tier, then the object gets promoted=
<br>
&gt; wiping that last write, but then it seems like it should not be as muc=
h<br>
&gt; corruption since the metadata should be in the cache pretty quick. We<=
br>
&gt; usually evited the cache before each try so we should not be evicting =
on<br>
&gt; writeback.<br>
&gt;<br>
&gt; Sent from a mobile device, please excuse any typos.<br>
&gt; On Mar 17, 2016 6:26 AM, &quot;Sage Weil&quot; &lt;<a href=3D"mailto:s=
weil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Thu, 17 Mar 2016, Nick Fisk wrote:<br>
&gt; &gt; &gt; There is got to be something else going on here. All that PR=
 does is to<br>
&gt; &gt; &gt; potentially delay the promotion to hit_set_period*recency in=
stead of<br>
&gt; &gt; &gt; just doing it on the 2nd read regardless, it&#39;s got to be=
 uncovering<br>
&gt; &gt; &gt; another bug.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Do you see the same problem if the cache is in writeback mod=
e before you<br>
&gt; &gt; &gt; start the unpacking. Ie is it the switching mid operation wh=
ich causes<br>
&gt; &gt; &gt; the problem? If it only happens mid operation, does it still=
 occur if<br>
&gt; &gt; &gt; you pause IO when you make the switch?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Do you also see this if you perform on a RBD mount, to rule =
out any<br>
&gt; &gt; &gt; librbd/qemu weirdness?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Do you know if it=E2=80=99s the actual data that is getting =
corrupted or if it&#39;s<br>
&gt; &gt; &gt; the FS metadata? I&#39;m only wondering as unpacking should =
really only be<br>
&gt; &gt; &gt; writing to each object a couple of times, whereas FS metadat=
a could<br>
&gt; &gt; &gt; potentially be being updated+read back lots of times for the=
 same group<br>
&gt; &gt; &gt; of objects and ordering is very important.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thinking through it logically the only difference is that wi=
th recency=3D1<br>
&gt; &gt; &gt; the object will be copied up to the cache tier, where recenc=
y=3D6 it will<br>
&gt; &gt; &gt; be proxy read for a long time. If I had to guess I would say=
 the issue<br>
&gt; &gt; &gt; would lie somewhere in the proxy read + writeback&lt;-&gt;fo=
rward logic.<br>
&gt; &gt;<br>
&gt; &gt; That seems reasonable.=C2=A0 Was switching from writeback -&gt; f=
orward always<br>
&gt; &gt; part of the sequence that resulted in corruption?=C2=A0 Not that =
there is a<br>
&gt; &gt; known ordering issue when switching to forward mode.=C2=A0 I woul=
dn&#39;t really<br>
&gt; &gt; expect it to bite real users but it&#39;s possible..<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://tracker.ceph.c=
om/issues/12814" rel=3D"noreferrer" target=3D"_blank">http://tracker.ceph.c=
om/issues/12814</a><br>
&gt; &gt;<br>
&gt; &gt; I&#39;ve opened a ticket to track this:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://tracker.ceph.c=
om/issues/15171" rel=3D"noreferrer" target=3D"_blank">http://tracker.ceph.c=
om/issues/15171</a><br>
&gt; &gt;<br>
&gt; &gt; What would be *really* great is if you could reproduce this with =
a<br>
&gt; &gt; ceph_test_rados workload (from ceph-tests).=C2=A0 I.e., get ceph_=
test_rados<br>
&gt; &gt; running, and then find the sequence of operations that are suffic=
ient to<br>
&gt; &gt; trigger a failure.<br>
&gt; &gt;<br>
&gt; &gt; sage<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; &gt; From: ceph-users [mailto:<a href=3D"mailto:ceph-users-b=
ounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>] On Behalf<br>
&gt; &gt; Of<br>
&gt; &gt; &gt; &gt; Mike Lovell<br>
&gt; &gt; &gt; &gt; Sent: 16 March 2016 23:23<br>
&gt; &gt; &gt; &gt; To: ceph-users &lt;<a href=3D"mailto:ceph-users@lists.c=
eph.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;; <a href=3D"mailto:sweil@redhat.=
com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a><br>
&gt; &gt; &gt; &gt; Cc: Robert LeBlanc &lt;<a href=3D"mailto:robert.leblanc=
@endurance.com">robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org</a>&gt;; William Perkins<br>
&gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org">wi=
lliam.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org</a>&gt;<br>
&gt; &gt; &gt; &gt; Subject: Re: [ceph-users] data corruption with hammer<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; just got done with a test against a build of 0.94.6 min=
us the two<br>
&gt; &gt; commits that<br>
&gt; &gt; &gt; &gt; were backported in PR 7207. everything worked as it sho=
uld with the<br>
&gt; &gt; cache-<br>
&gt; &gt; &gt; &gt; mode set to writeback and the min_read_recency_for_prom=
ote set to 2.<br>
&gt; &gt; &gt; &gt; assuming it works properly on master, there must be a c=
ommit that we&#39;re<br>
&gt; &gt; &gt; &gt; missing on the backport to support this properly.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; sage,<br>
&gt; &gt; &gt; &gt; i&#39;m adding you to the recipients on this so hopeful=
ly you see it. the<br>
&gt; &gt; tl;dr<br>
&gt; &gt; &gt; &gt; version is that the backport of the cache recency fix t=
o hammer<br>
&gt; &gt; doesn&#39;t work<br>
&gt; &gt; &gt; &gt; right and potentially corrupts data when<br>
&gt; &gt; &gt; &gt; the min_read_recency_for_promote is set to greater than=
 1.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; mike<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, Mar 16, 2016 at 4:41 PM, Mike Lovell<br>
&gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org">mike.l=
ovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; robert and i have done some further investigation the p=
ast couple days<br>
&gt; &gt; on<br>
&gt; &gt; &gt; &gt; this. we have a test environment with a hard drive tier=
 and an ssd<br>
&gt; &gt; tier as a<br>
&gt; &gt; &gt; &gt; cache. several vms were created with volumes from the c=
eph cluster. i<br>
&gt; &gt; did a<br>
&gt; &gt; &gt; &gt; test in each guest where i un-tarred the linux kernel s=
ource multiple<br>
&gt; &gt; times<br>
&gt; &gt; &gt; &gt; and then did a md5sum check against all of the files in=
 the resulting<br>
&gt; &gt; source<br>
&gt; &gt; &gt; &gt; tree. i started off with the monitors and osds running =
0.94.5 and<br>
&gt; &gt; never saw<br>
&gt; &gt; &gt; &gt; any problems.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; a single node was then upgraded to 0.94.6 which has osd=
s in both the<br>
&gt; &gt; ssd and<br>
&gt; &gt; &gt; &gt; hard drive tier. i then proceeded to run the same test =
and, while the<br>
&gt; &gt; untar<br>
&gt; &gt; &gt; &gt; and md5sum operations were running, i changed the ssd t=
ier cache-mode<br>
&gt; &gt; &gt; &gt; from forward to writeback. almost immediately the vms s=
tarted<br>
&gt; &gt; reporting io<br>
&gt; &gt; &gt; &gt; errors and odd data corruption. the remainder of the cl=
uster was<br>
&gt; &gt; updated to<br>
&gt; &gt; &gt; &gt; 0.94.6, including the monitors, and the same thing happ=
ened.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; things were cleaned up and reset and then a test was ru=
n<br>
&gt; &gt; &gt; &gt; where min_read_recency_for_promote for the ssd cache po=
ol was set to 1.<br>
&gt; &gt; &gt; &gt; we previously had it set to 6. there was never an error=
 with the<br>
&gt; &gt; recency<br>
&gt; &gt; &gt; &gt; setting set to 1. i then tested with it set to 2 and it=
 immediately<br>
&gt; &gt; caused<br>
&gt; &gt; &gt; &gt; failures. we are currently thinking that it is related =
to the backport<br>
&gt; &gt; of the fix<br>
&gt; &gt; &gt; &gt; for the recency promotion and are in progress of making=
 a .6 build<br>
&gt; &gt; without<br>
&gt; &gt; &gt; &gt; that backport to see if we can cause corruption. is any=
one using a<br>
&gt; &gt; version<br>
&gt; &gt; &gt; &gt; from after the original recency fix (PR 6702) with a ca=
che tier in<br>
&gt; &gt; writeback<br>
&gt; &gt; &gt; &gt; mode? anyone have a similar problem?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; mike<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Mon, Mar 14, 2016 at 8:51 PM, Mike Lovell<br>
&gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org">mike.l=
ovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; something weird happened on one of the ceph clusters th=
at i administer<br>
&gt; &gt; &gt; &gt; tonight which resulted in virtual machines using rbd vo=
lumes seeing<br>
&gt; &gt; &gt; &gt; corruption in multiple forms.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; when everything was fine earlier in the day, the cluste=
r was a number<br>
&gt; &gt; of<br>
&gt; &gt; &gt; &gt; storage nodes spread across 3 different roots in the cr=
ush map. the<br>
&gt; &gt; first<br>
&gt; &gt; &gt; &gt; bunch of storage nodes have both hard drives and ssds i=
n them with the<br>
&gt; &gt; hard<br>
&gt; &gt; &gt; &gt; drives in one root and the ssds in another. there is a =
pool for each<br>
&gt; &gt; and the<br>
&gt; &gt; &gt; &gt; pool for the ssds is a cache tier for the hard drives. =
the last set of<br>
&gt; &gt; storage<br>
&gt; &gt; &gt; &gt; nodes were in a separate root with their own pool that =
is being used<br>
&gt; &gt; for burn<br>
&gt; &gt; &gt; &gt; in testing.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; these nodes had run for a while with test traffic and w=
e decided to<br>
&gt; &gt; move<br>
&gt; &gt; &gt; &gt; them to the main root and pools. the main cluster is ru=
nning 0.94.5<br>
&gt; &gt; and the<br>
&gt; &gt; &gt; &gt; new nodes got 0.94.6 due to them getting configured aft=
er that was<br>
&gt; &gt; &gt; &gt; released. i removed the test pool and did a ceph osd cr=
ush move to move<br>
&gt; &gt; &gt; &gt; the first node into the main cluster, the hard drives i=
nto the root<br>
&gt; &gt; for that tier<br>
&gt; &gt; &gt; &gt; of storage and the ssds into the root and pool for the =
cache tier.<br>
&gt; &gt; each set was<br>
&gt; &gt; &gt; &gt; done about 45 minutes apart and they ran for a couple h=
ours while<br>
&gt; &gt; &gt; &gt; performing backfill without any issue other than high l=
oad on the<br>
&gt; &gt; cluster.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; we normally run the ssd tier in the forward cache-mode =
due to the ssds<br>
&gt; &gt; we<br>
&gt; &gt; &gt; &gt; have not being able to keep up with the io of writeback=
. this results<br>
&gt; &gt; in io on<br>
&gt; &gt; &gt; &gt; the hard drives slowing going up and performance of the=
 cluster<br>
&gt; &gt; starting to<br>
&gt; &gt; &gt; &gt; suffer. about once a week, i change the cache-mode betw=
een writeback<br>
&gt; &gt; and<br>
&gt; &gt; &gt; &gt; forward for short periods of time to promote actively u=
sed data to the<br>
&gt; &gt; cache<br>
&gt; &gt; &gt; &gt; tier. this moves io load from the hard drive tier to th=
e ssd tier and<br>
&gt; &gt; has been<br>
&gt; &gt; &gt; &gt; done multiple times without issue. i normally don&#39;t=
 do this while<br>
&gt; &gt; there are<br>
&gt; &gt; &gt; &gt; backfills or recoveries happening on the cluster but de=
cided to go<br>
&gt; &gt; ahead<br>
&gt; &gt; &gt; &gt; while backfill was happening due to the high load.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; i tried this procedure to change the ssd cache-tier bet=
ween writeback<br>
&gt; &gt; and<br>
&gt; &gt; &gt; &gt; forward cache-mode and things seemed okay from the ceph=
 cluster. about<br>
&gt; &gt; &gt; &gt; 10 minutes after the first attempt a changing the mode,=
 vms using the<br>
&gt; &gt; ceph<br>
&gt; &gt; &gt; &gt; cluster for their storage started seeing corruption in =
multiple forms.<br>
&gt; &gt; the<br>
&gt; &gt; &gt; &gt; mode was flipped back and forth multiple times in that =
time frame and<br>
&gt; &gt; its<br>
&gt; &gt; &gt; &gt; unknown if the corruption was noticed with the first ch=
ange or<br>
&gt; &gt; subsequent<br>
&gt; &gt; &gt; &gt; changes. the vms were having issues of filesystems havi=
ng errors and<br>
&gt; &gt; getting<br>
&gt; &gt; &gt; &gt; remounted RO and mysql databases seeing corruption (bot=
h myisam and<br>
&gt; &gt; &gt; &gt; innodb). some of this was recoverable but on some files=
ystems there was<br>
&gt; &gt; &gt; &gt; corruption that lead to things like lots of data ending=
 up in the<br>
&gt; &gt; lost+found and<br>
&gt; &gt; &gt; &gt; some of the databases were un-recoverable (backups are =
helping there).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; i&#39;m not sure what would have happened to cause this=
 corruption. the<br>
&gt; &gt; libvirt<br>
&gt; &gt; &gt; &gt; logs for the qemu processes for the vms did not provide=
 any output of<br>
&gt; &gt; &gt; &gt; problems from the ceph client code. it doesn&#39;t look=
 like any of the<br>
&gt; &gt; qemu<br>
&gt; &gt; &gt; &gt; processes had crashed. also, it has now been several ho=
urs since this<br>
&gt; &gt; &gt; &gt; happened with no additional corruption noticed by the v=
ms. it doesn&#39;t<br>
&gt; &gt; &gt; &gt; appear that we had any corruption happen before i attem=
pted the<br>
&gt; &gt; flipping of<br>
&gt; &gt; &gt; &gt; the ssd tier cache-mode.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; the only think i can think of that is different between=
 this time<br>
&gt; &gt; doing this<br>
&gt; &gt; &gt; &gt; procedure vs previous attempts was that there was the o=
ne storage node<br>
&gt; &gt; &gt; &gt; running 0.94.6 where the remainder were running 0.94.5.=
 is is possible<br>
&gt; &gt; that<br>
&gt; &gt; &gt; &gt; something changed between these two releases that would=
 have caused<br>
&gt; &gt; &gt; &gt; problems with data consistency related to the cache tie=
r? or<br>
&gt; &gt; otherwise? any<br>
&gt; &gt; &gt; &gt; other thoughts or suggestions?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; thanks in advance for any help you can provide.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; mike<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; ceph-users mailing list<br>
&gt; &gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJ4Eiagz67IpQ@public.gmane.org=
h.com</a><br>
&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=
" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/c=
eph-users-ceph.com</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; </div></div></blockquote></div><br></div>

--001a11433da804f1a0052e40fdac--

--===============0210341460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0210341460==--
