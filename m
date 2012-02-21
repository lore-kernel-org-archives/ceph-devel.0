From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: RE: Which SSD method is better for performance?
Date: Tue, 21 Feb 2012 11:24:55 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF7B7@exch10>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
	<4F3A5786.7060006@widodh.nl>
	<81C477727102DA4E9B2605AC748C495407E36DF792@exch10>
	<Pine.LNX.4.64.1202191911060.31319@cobra.newdream.net>
	<81C477727102DA4E9B2605AC748C495407E36DF7B4@exch10>
 <CAF3hT9Cc2ga7h1xHCXNyhHhE_LV5jMDO=hW=QpiCs5zrf7fw8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf2.mach.net.au ([115.165.172.4]:46646 "EHLO mf2.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab2BUBZK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 20:25:10 -0500
In-Reply-To: <CAF3hT9Cc2ga7h1xHCXNyhHhE_LV5jMDO=hW=QpiCs5zrf7fw8w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

G'day Greg, thanks for the fast response.

Yes, I forgot to explicitly state the Journal would go to SATA Journals=
 in CASE1, and it is easy to appreciate the performance impact of this =
case as you documented nicely in your response.

Re your second point:=20
> The other big advantage an SSD provides is in write latency; if you'r=
e journaling on an SSD you can send things to disk and get a commit bac=
k without having to wait on rotating media. How big an impact that will=
 make will depend on your other config options and use case, though.

Are you able to detail which config options tune this, and an example u=
se case to illustrate?

Many thanks

Paul


-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Gregory Farnum
Sent: Tuesday, 21 February 2012 10:50 AM
To: Paul Pettigrew
Cc: Sage Weil; Wido den Hollander; ceph-devel@vger.kernel.org
Subject: Re: Which SSD method is better for performance?

On Mon, Feb 20, 2012 at 4:44 PM, Paul Pettigrew <Paul.Pettigrew@mach.co=
m.au> wrote:
> Thanks Sage
>
> So following through by two examples, to confirm my understanding....=
=2E...
>
> HDD SPECS:
> 8x 2TB SATA HDD's able to do sustained read/write speed of 138MB/s=20
> each 1x SSD able to do sustained read/write speed of 475MB/s
>
> CASE1
> (not using SSD)
> 8x OSD's each for the SATA HDD's
> Therefore able to parallelise IO operations Sustained write sent to=20
> Ceph of very large file say 500GB (therefore caches all used up and=20
> bottleneck becomes SATA IO speed) Gives 8x 138MB/s =3D 1,104 MB/s
>
> CASE 2
> (using 1x SSD)
> SSD partitioned into 8x separate partitions, 1x for each OSD Sustaine=
d=20
> write (with OSD-Journal to SSD) sent to Ceph of very large file (say=20
> 500GB) Write spilt across 8x OSD-Journal partitions on the single SSD=
=20
> =3D limited to aggregate of 475MB/s
>
> ANALYSIS:
> If my examples are how Ceph operates, then it is necessary to not exc=
eed a ratio of 3SATA:1SSD, if 4 or more SATA's are used then the SSD be=
comes the bottleneck.
>
> Is this analysis accurate? Are there other benefits that SSD provide =
(including in non-sustained peak write performance use case) that would=
 otherwise justify their usage? What ratios are other users sticking to=
 when deciding for their design?

Well, you seem to be leaving out the journals entirely in the first cas=
e. You could put them on a separate partition on the SATA disks if you =
wanted, which (on a modern drive) would net you half the single-stream =
throughput, or ~552MB/s aggregate.

The other big advantage an SSD provides is in write latency; if you're =
journaling on an SSD you can send things to disk and get a commit back =
without having to wait on rotating media. How big an impact that will m=
ake will depend on your other config options and use case, though.
-Greg

>
> Many thanks all - this is all being rolled up into a new "Ceph SSD" w=
iki page I will be offering to Sage to include in the main Ceph wiki si=
te.
>
> Paul
>
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Monday, 20 February 2012 1:16 PM
> To: Paul Pettigrew
> Cc: Wido den Hollander; ceph-devel@vger.kernel.org
> Subject: RE: Which SSD method is better for performance?
>
> On Mon, 20 Feb 2012, Paul Pettigrew wrote:
>> And secondly, should the SSD Journal sizes be large or small? =A0Ie,=
 is=20
>> say 1G partition per paired 2-3TB SATA disk OK? Or as large an SSD a=
s=20
>> possible? There are many forum posts that say 100-200MB will suffice=
=2E
>> A quick piece of advice will save us hopefully sever days of=20
>> reconfiguring and benchmarking the Cluster :-)
>
> ceph-osd will periodically do a 'commit' to ensure that stuff in the =
journal is written safely to the file system. =A0On btrfs that's a snap=
shot, on anything else it's a sync(2). =A0When the journals hits 50% we=
 trigger a commit, or when a timer expires (I think 30 seconds by defau=
lt). =A0There is some overhead associated with the sync/snapshot, so le=
ss is generally better.
>
> A decent rule of thumb is probably to make the journal big enough to =
consume sustained writes for 10-30 seconds. =A0On modern disks, that's =
probably 1-3GB? =A0If the journal is on the same spindle as the fs, it'=
ll be probably half that...
> </hand waving>
>
> sage
>
>
>
>>
>> Thanks
>>
>> Paul
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den=20
>> Hollander
>> Sent: Tuesday, 14 February 2012 10:46 PM
>> To: Paul Pettigrew
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Which SSD method is better for performance?
>>
>> Hi,
>>
>> On 02/14/2012 01:39 AM, Paul Pettigrew wrote:
>> > G'day all
>> >
>> > About to commence an R&D eval of the Ceph platform having been imp=
ressed with the momentum achieved over the past 12mths.
>> >
>> > I have one question re design before rolling out to metal........
>> >
>> > I will be using 1x SSD drive per storage server node (assume it is=
 /dev/sdb for this discussion), and cannot readily determine the pro/co=
n's for the two methods of using it for OSD-Journal, being:
>> > #1. place it in the main [osd] stanza and reference the whole driv=
e=20
>> > as a single partition; or
>>
>> That won't work. If you do that all OSD's will try to open the journ=
al.
>> The journal for each OSD has to be unique.
>>
>> > #2. partition up the disk, so 1x partition per SATA HDD, and place=
=20
>> > each partition in the [osd.N] portion
>>
>> That would be your best option.
>>
>> I'm doing the same: http://zooi.widodh.nl/ceph/ceph.conf
>>
>> the VG "data" is placed on a SSD (Intel X25-M).
>>
>> >
>> > So if I were to code #1 in the ceph.conf file, it would be:
>> > [osd]
>> > osd journal =3D /dev/sdb
>> >
>> > Or, #2 would be like:
>> > [osd.0]
>> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
>> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdc
>> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb5
>> > [osd.1]
>> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
>> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdd
>> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb6
>> > [osd.2]
>> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
>> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sde
>> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb7
>> > [osd.3]
>> > =A0 =A0 =A0 =A0 =A0host =3D ceph1
>> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdf
>> > =A0 =A0 =A0 =A0 =A0osd journal =3D /dev/sdb8
>> >
>> > I am asking therefore, is the added work (and constraints) of spec=
ifying down to individual partitions per #2 worth it in performance gai=
ns? Does it not also have a constraint, in that if I wanted to add more=
 HDD's into the server (we buy 45 bay units, and typically provision HD=
D's "on demand" i.e. 15x at a time as usage grows), I would have to add=
itionally partition the SSD (taking it offline) - but if it were #1 opt=
ion, I would only have to add more [osd.N] sections (and not have to wo=
rry about getting the SSD with 45x partitions)?
>> >
>>
>> You'd still have to go for #2. However, running 45 OSD's on a single=
 machine is a bit tricky imho.
>>
>> If that machine fails you would loose 45 OSD's at once, that will pu=
t a lot of stress on the recovery of your cluster.
>>
>> You'd also need a lot of RAM to accommodate those 45 OSD's, at least=
 48GB of RAM I guess.
>>
>> A last note, if you use a SSD for your journaling, make sure that yo=
u align your partitions which the page size of the SSD, otherwise you'd=
 run into the write amplification of the SSD, resulting in a performanc=
e loss.
>>
>> Wido
>>
>> > One final related question, if I were to use #1 method (which I wo=
uld prefer if there is no material performance or other reason to use #=
2), then that specification (i.e. the "osd journal =3D /dev/sdb") SSD d=
isk reference would have to be identical on all other hardware nodes, y=
es (I want to use the same ceph.conf file on all servers per the doco r=
ecommendations)? What would happen if for example, the SSD was on /dev/=
sde on a new node added into the cluster? References to /dev/disk/by-id=
 etc are clearly no help, so should a symlink be used from the get-go? =
Eg something like "ln -s /dev/sdb /srv/ssd" on one box, and =A0"ln -s /=
dev/sde /srv/ssd" on the other box, so that in the [osd] section we cou=
ld use this line which would find the SSD disk on all nodes "osd journa=
l =3D /srv/ssd"?
>> >
>> > Many thanks for any advice provided.
>> >
>> > Cheers
>> >
>> > Paul
>> >
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>> > in the body of a message to majordomo@vger.kernel.org More=20
>> > majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
