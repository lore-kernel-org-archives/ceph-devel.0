From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: RE: Which SSD method is better for performance?
Date: Mon, 20 Feb 2012 12:31:33 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF791@exch10>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
	<4F3A5786.7060006@widodh.nl>
 <CAA9wQNfSSJK=e2Ysb34shjW=zBatOuLj+dvq4Y16qGUeVqCA=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf4.mach.net.au ([74.55.157.90]:48608 "EHLO mf4.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2BTCcK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Feb 2012 21:32:10 -0500
In-Reply-To: <CAA9wQNfSSJK=e2Ysb34shjW=zBatOuLj+dvq4Y16qGUeVqCA=Q@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Leander

No, because we "know" that by going directly to the partition method, w=
e will be reducing the amount of kernel and filesystem code required to=
 perform the Journal function. Therefore, it will always be faster.

We are focusing our benchmarking work on brands/types of SSD's and dire=
ct partition v's LVM partitions. Initial results show:
* OCZ are 3x faster than Kingston SSD's.
* Negligible difference between fixed (fdisk) partitions, and using LVM=
 to create partitions, so we are going with LVM partitions as no constr=
aints on numbers of partitions and very flexible to create/resize, etc

Cheers

Paul


-----Original Message-----
=46rom: Leander Yu [mailto:leander.yu@gmail.com]=20
Sent: Wednesday, 15 February 2012 2:26 AM
To: Wido den Hollander
Cc: Paul Pettigrew; ceph-devel@vger.kernel.org
Subject: Re: Which SSD method is better for performance?

Hi ,
Have you ever done the performance comparison between using journal fil=
e and journal partition?

Regards,
Leander Yu.

On Tue, Feb 14, 2012 at 8:45 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
>
> On 02/14/2012 01:39 AM, Paul Pettigrew wrote:
>>
>> G'day all
>>
>> About to commence an R&D eval of the Ceph platform having been=20
>> impressed with the momentum achieved over the past 12mths.
>>
>> I have one question re design before rolling out to metal........
>>
>> I will be using 1x SSD drive per storage server node (assume it is=20
>> /dev/sdb for this discussion), and cannot readily determine the=20
>> pro/con's for the two methods of using it for OSD-Journal, being:
>> #1. place it in the main [osd] stanza and reference the whole drive=20
>> as a single partition; or
>
>
> That won't work. If you do that all OSD's will try to open the=20
> journal. The journal for each OSD has to be unique.
>
>
>> #2. partition up the disk, so 1x partition per SATA HDD, and place=20
>> each partition in the [osd.N] portion
>
>
> That would be your best option.
>
> I'm doing the same: http://zooi.widodh.nl/ceph/ceph.conf
>
> the VG "data" is placed on a SSD (Intel X25-M).
>
>
>>
>> So if I were to code #1 in the ceph.conf file, it would be:
>> [osd]
>> osd journal =3D /dev/sdb
>>
>> Or, #2 would be like:
>> [osd.0]
>> =A0 =A0 =A0 =A0 host =3D ceph1
>> =A0 =A0 =A0 =A0 btrfs devs =3D /dev/sdc
>> =A0 =A0 =A0 =A0 osd journal =3D /dev/sdb5
>> [osd.1]
>> =A0 =A0 =A0 =A0 host =3D ceph1
>> =A0 =A0 =A0 =A0 btrfs devs =3D /dev/sdd
>> =A0 =A0 =A0 =A0 osd journal =3D /dev/sdb6
>> [osd.2]
>> =A0 =A0 =A0 =A0 host =3D ceph1
>> =A0 =A0 =A0 =A0 btrfs devs =3D /dev/sde
>> =A0 =A0 =A0 =A0 osd journal =3D /dev/sdb7
>> [osd.3]
>> =A0 =A0 =A0 =A0 host =3D ceph1
>> =A0 =A0 =A0 =A0 btrfs devs =3D /dev/sdf
>> =A0 =A0 =A0 =A0 osd journal =3D /dev/sdb8
>>
>> I am asking therefore, is the added work (and constraints) of=20
>> specifying down to individual partitions per #2 worth it in=20
>> performance gains? Does it not also have a constraint, in that if I=20
>> wanted to add more HDD's into the server (we buy 45 bay units, and t=
ypically provision HDD's "on demand" i.e.
>> 15x at a time as usage grows), I would have to additionally partitio=
n=20
>> the SSD (taking it offline) - but if it were #1 option, I would only=
=20
>> have to add more [osd.N] sections (and not have to worry about=20
>> getting the SSD with 45x partitions)?
>>
>
> You'd still have to go for #2. However, running 45 OSD's on a single=20
> machine is a bit tricky imho.
>
> If that machine fails you would loose 45 OSD's at once, that will put=
=20
> a lot of stress on the recovery of your cluster.
>
> You'd also need a lot of RAM to accommodate those 45 OSD's, at least=20
> 48GB of RAM I guess.
>
> A last note, if you use a SSD for your journaling, make sure that you=
=20
> align your partitions which the page size of the SSD, otherwise you'd=
=20
> run into the write amplification of the SSD, resulting in a performan=
ce loss.
>
> Wido
>
>
>> One final related question, if I were to use #1 method (which I woul=
d=20
>> prefer if there is no material performance or other reason to use=20
>> #2), then that specification (i.e. the "osd journal =3D /dev/sdb") S=
SD=20
>> disk reference would have to be identical on all other hardware=20
>> nodes, yes (I want to use the same ceph.conf file on all servers per=
=20
>> the doco recommendations)? What would happen if for example, the SSD=
=20
>> was on /dev/sde on a new node added into the cluster? References to=20
>> /dev/disk/by-id etc are clearly no help, so should a symlink be used=
=20
>> from the get-go? Eg something like "ln -s /dev/sdb /srv/ssd" on one=20
>> box, and =A0"ln -s /dev/sde /srv/ssd" on the other box, so that in t=
he=20
>> [osd] section we could use this line which would find the SSD disk o=
n all nodes "osd journal =3D /srv/ssd"?
>>
>> Many thanks for any advice provided.
>>
>> Cheers
>>
>> Paul
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at =A0http://vger.kernel.org/majordomo-info.html




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
