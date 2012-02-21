From: Sage Weil <sage@newdream.net>
Subject: RE: Which SSD method is better for performance?
Date: Tue, 21 Feb 2012 13:35:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202211332210.24624@cobra.newdream.net>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
 <4F3A5786.7060006@widodh.nl> <81C477727102DA4E9B2605AC748C495407E36DF792@exch10>
 <Pine.LNX.4.64.1202191911060.31319@cobra.newdream.net>
 <81C477727102DA4E9B2605AC748C495407E36DF7B4@exch10>
 <CAF3hT9Cc2ga7h1xHCXNyhHhE_LV5jMDO=hW=QpiCs5zrf7fw8w@mail.gmail.com>
 <81C477727102DA4E9B2605AC748C495407E36DF7B7@exch10>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1532787544-1329860148=:24624"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60813 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab2BUVfv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 16:35:51 -0500
In-Reply-To: <81C477727102DA4E9B2605AC748C495407E36DF7B7@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1532787544-1329860148=:24624
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Feb 2012, Paul Pettigrew wrote:
> G'day Greg, thanks for the fast response.
>=20
> Yes, I forgot to explicitly state the Journal would go to SATA Journals i=
n CASE1, and it is easy to appreciate the performance impact of this case a=
s you documented nicely in your response.
>=20
> Re your second point:=20
> > The other big advantage an SSD provides is in write latency; if you're=
=20
> > journaling on an SSD you can send things to disk and get a commit back=
=20
> > without having to wait on rotating media. How big an impact that will=
=20
> > make will depend on your other config options and use case, though.
>=20
> Are you able to detail which config options tune this, and an example=20
> use case to illustrate?

Actually, I don't think there are many config options to worry about. =20

The easiest way to see this latency is to do something like

 rados mkpool foo
 rados -p foo bench 30 write -b 4096 -t 1

which will do a single small sync io at a time.  You'll notice a big=20
difference depending on whether your journal is a file, raw partition,=20
SSD, or NVRAM.

When you have many parallel IOs (-t 100), you might also see a difference=
=20
with a raw partition if you enable aio on the journal (journal aio =3D true=
=20
in ceph.conf).  Maybe.  We haven't tuned that yet.

sage



>=20
> Many thanks
>=20
> Paul
>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kern=
el.org] On Behalf Of Gregory Farnum
> Sent: Tuesday, 21 February 2012 10:50 AM
> To: Paul Pettigrew
> Cc: Sage Weil; Wido den Hollander; ceph-devel@vger.kernel.org
> Subject: Re: Which SSD method is better for performance?
>=20
> On Mon, Feb 20, 2012 at 4:44 PM, Paul Pettigrew <Paul.Pettigrew@mach.com.=
au> wrote:
> > Thanks Sage
> >
> > So following through by two examples, to confirm my understanding......=
=2E.
> >
> > HDD SPECS:
> > 8x 2TB SATA HDD's able to do sustained read/write speed of 138MB/s=20
> > each 1x SSD able to do sustained read/write speed of 475MB/s
> >
> > CASE1
> > (not using SSD)
> > 8x OSD's each for the SATA HDD's
> > Therefore able to parallelise IO operations Sustained write sent to=20
> > Ceph of very large file say 500GB (therefore caches all used up and=20
> > bottleneck becomes SATA IO speed) Gives 8x 138MB/s =3D 1,104 MB/s
> >
> > CASE 2
> > (using 1x SSD)
> > SSD partitioned into 8x separate partitions, 1x for each OSD Sustained=
=20
> > write (with OSD-Journal to SSD) sent to Ceph of very large file (say=20
> > 500GB) Write spilt across 8x OSD-Journal partitions on the single SSD=
=20
> > =3D limited to aggregate of 475MB/s
> >
> > ANALYSIS:
> > If my examples are how Ceph operates, then it is necessary to not excee=
d a ratio of 3SATA:1SSD, if 4 or more SATA's are used then the SSD becomes =
the bottleneck.
> >
> > Is this analysis accurate? Are there other benefits that SSD provide (i=
ncluding in non-sustained peak write performance use case) that would other=
wise justify their usage? What ratios are other users sticking to when deci=
ding for their design?
>=20
> Well, you seem to be leaving out the journals entirely in the first case.=
 You could put them on a separate partition on the SATA disks if you wanted=
, which (on a modern drive) would net you half the single-stream throughput=
, or ~552MB/s aggregate.
>=20
> The other big advantage an SSD provides is in write latency; if you're jo=
urnaling on an SSD you can send things to disk and get a commit back withou=
t having to wait on rotating media. How big an impact that will make will d=
epend on your other config options and use case, though.
> -Greg
>=20
> >
> > Many thanks all - this is all being rolled up into a new "Ceph SSD" wik=
i page I will be offering to Sage to include in the main Ceph wiki site.
> >
> > Paul
> >
> >
> >
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org=20
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Monday, 20 February 2012 1:16 PM
> > To: Paul Pettigrew
> > Cc: Wido den Hollander; ceph-devel@vger.kernel.org
> > Subject: RE: Which SSD method is better for performance?
> >
> > On Mon, 20 Feb 2012, Paul Pettigrew wrote:
> >> And secondly, should the SSD Journal sizes be large or small? =A0Ie, i=
s=20
> >> say 1G partition per paired 2-3TB SATA disk OK? Or as large an SSD as=
=20
> >> possible? There are many forum posts that say 100-200MB will suffice.
> >> A quick piece of advice will save us hopefully sever days of=20
> >> reconfiguring and benchmarking the Cluster :-)
> >
> > ceph-osd will periodically do a 'commit' to ensure that stuff in the jo=
urnal is written safely to the file system. =A0On btrfs that's a snapshot, =
on anything else it's a sync(2). =A0When the journals hits 50% we trigger a=
 commit, or when a timer expires (I think 30 seconds by default). =A0There =
is some overhead associated with the sync/snapshot, so less is generally be=
tter.
> >
> > A decent rule of thumb is probably to make the journal big enough to co=
nsume sustained writes for 10-30 seconds. =A0On modern disks, that's probab=
ly 1-3GB? =A0If the journal is on the same spindle as the fs, it'll be prob=
ably half that...
> > </hand waving>
> >
> > sage
> >
> >
> >
> >>
> >> Thanks
> >>
> >> Paul
> >>
> >>
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org=20
> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den=20
> >> Hollander
> >> Sent: Tuesday, 14 February 2012 10:46 PM
> >> To: Paul Pettigrew
> >> Cc: ceph-devel@vger.kernel.org
> >> Subject: Re: Which SSD method is better for performance?
> >>
> >> Hi,
> >>
> >> On 02/14/2012 01:39 AM, Paul Pettigrew wrote:
> >> > G'day all
> >> >
> >> > About to commence an R&D eval of the Ceph platform having been impre=
ssed with the momentum achieved over the past 12mths.
> >> >
> >> > I have one question re design before rolling out to metal........
> >> >
> >> > I will be using 1x SSD drive per storage server node (assume it is /=
dev/sdb for this discussion), and cannot readily determine the pro/con's fo=
r the two methods of using it for OSD-Journal, being:
> >> > #1. place it in the main [osd] stanza and reference the whole drive=
=20
> >> > as a single partition; or
> >>
> >> That won't work. If you do that all OSD's will try to open the journal=
=2E
> >> The journal for each OSD has to be unique.
> >>
> >> > #2. partition up the disk, so 1x partition per SATA HDD, and place=
=20
> >> > each partition in the [osd.N] portion
> >>
> >> That would be your best option.
> >>
> >> I'm doing the same: http://zooi.widodh.nl/ceph/ceph.conf
> >>
> >> the VG "data" is placed on a SSD (Intel X25-M).
> >>
> >> >
> >> > So if I were to code #1 in the ceph.conf file, it would be:
> >> > [osd]
> >> > osd journal =3D /dev/sdb
> >> >
> >> > Or, #2 would be like:
> >> > [osd.0]
> >> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
> >> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc
> >> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb5
> >> > [osd.1]
> >> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
> >> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd
> >> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb6
> >> > [osd.2]
> >> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
> >> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde
> >> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb7
> >> > [osd.3]
> >> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
> >> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf
> >> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb8
> >> >
> >> > I am asking therefore, is the added work (and constraints) of specif=
ying down to individual partitions per #2 worth it in performance gains? Do=
es it not also have a constraint, in that if I wanted to add more HDD's int=
o the server (we buy 45 bay units, and typically provision HDD's "on demand=
" i.e. 15x at a time as usage grows), I would have to additionally partitio=
n the SSD (taking it offline) - but if it were #1 option, I would only have=
 to add more [osd.N] sections (and not have to worry about getting the SSD =
with 45x partitions)?
> >> >
> >>
> >> You'd still have to go for #2. However, running 45 OSD's on a single m=
achine is a bit tricky imho.
> >>
> >> If that machine fails you would loose 45 OSD's at once, that will put =
a lot of stress on the recovery of your cluster.
> >>
> >> You'd also need a lot of RAM to accommodate those 45 OSD's, at least 4=
8GB of RAM I guess.
> >>
> >> A last note, if you use a SSD for your journaling, make sure that you =
align your partitions which the page size of the SSD, otherwise you'd run i=
nto the write amplification of the SSD, resulting in a performance loss.
> >>
> >> Wido
> >>
> >> > One final related question, if I were to use #1 method (which I woul=
d prefer if there is no material performance or other reason to use #2), th=
en that specification (i.e. the "osd journal =3D /dev/sdb") SSD disk refere=
nce would have to be identical on all other hardware nodes, yes (I want to =
use the same ceph.conf file on all servers per the doco recommendations)? W=
hat would happen if for example, the SSD was on /dev/sde on a new node adde=
d into the cluster? References to /dev/disk/by-id etc are clearly no help, =
so should a symlink be used from the get-go? Eg something like "ln -s /dev/=
sdb /srv/ssd" on one box, and =A0"ln -s /dev/sde /srv/ssd" on the other box=
, so that in the [osd] section we could use this line which would find the =
SSD disk on all nodes "osd journal =3D /srv/ssd"?
> >> >
> >> > Many thanks for any advice provided.
> >> >
> >> > Cheers
> >> >
> >> > Paul
> >> >
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
> >> > in the body of a message to majordomo@vger.kernel.org More=20
> >> > majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
> >> info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
> >> info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at =A0http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the body of a message to majordomo@vger.kernel.org More majordomo info at  =
http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1532787544-1329860148=:24624--
