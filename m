From: Sebastien Han <shan@redhat.com>
Subject: Re: ceph-disk improvements
Date: Tue, 5 Apr 2016 10:30:05 +0200
Message-ID: <CA+HUO7LfPzCvFzi59ydivYdkCcbrRqdQSJVjVZtuar6avND9tA@mail.gmail.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <alpine.DEB.2.11.1604030859210.19675@cpach.fuggernut.com> <1651492587.2194.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37053 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcDEIa0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 04:30:26 -0400
Received: by mail-wm0-f41.google.com with SMTP id n3so11216016wmn.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 01:30:25 -0700 (PDT)
In-Reply-To: <1651492587.2194.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, Samuel Yaple <sam@yaple.net>

Wido, I just discussed that with Sam last week and it seems that
bcache allocates a minor of 1 when creating the device.
Sam ended up writing this:
https://yaple.net/2016/03/31/bcache-partitions-and-dkms/
The fix is not complex not sure why it is not part of bcache yet...

Not sure if it's ceph-disk's job to do all of this with bcache though..=
=2E
We might need to check with the bache guys what are their plans about t=
his.
If this will go through at some point we might just wait, if not we
could implement the partition trick on ceph-disk.

In addition to that, ceph-disk could have a more general cache option
where we could add "plugins" like bcache, dm-cache etc.
Thanks!


On Mon, Apr 4, 2016 at 3:04 PM, Wido den Hollander <wido@42on.com> wrot=
e:
>
>> Op 3 april 2016 om 14:59 schreef Sage Weil <sweil@redhat.com>:
>>
>>
>> On Sat, 2 Apr 2016, Wido den Hollander wrote:
>> > > Op 1 april 2016 om 17:36 schreef Sage Weil <sweil@redhat.com>:
>> > > Hi all,
>> > >
>> > > There are a couple of looming features for ceph-disk:
>> > >
>> > > 1- Support for additional devices when using BlueStore.  There c=
an be up
>> > > to three: the main device, a WAL/journal device (small, ~128MB, =
ideally
>> > > NVRAM), and a fast metadata device (as big as you have available=
; will be
>> > > used for internal metadata).
>> > >
>> > > 2- Support for setting up dm-cache, bcache, and/or FlashCache un=
derneath
>> > > filestore or bluestore.
>> > >
>> >
>> > Keep in mind that you can't create a partition on a bcache device.=
 So when
>> > using
>> > bcache, the journal has to be filebased and not a partition.
>>
>> Can you create a bcache device out of a partition, though?
>>
>
> Yes. If you have /dev/sdb which is a SSD and /dev/sdc which is a disk=
, you can
> do:
>
> /dev/sdc can be used as a caching device:
>
> $ make-bcache -C /dev/sdb
>
> Now, you can partition /dev/sdc (the HDD):
>
> $ parted /dev/sdc mklabel gpt
> $ parted /dev/sdc mkpart primary 2048s 10G
> $ parted /dev/sdc mkpart primary 10G 100%
> $ make-bcache -B /dev/sdc2
>
> Now you still have to attach /dev/bcache0 (which is /dev/sdc2) to /de=
v/sdb by
> echoing the UUID to /sys/block/bcache0/bcache/attach
>
> This is explained in a quick howto here:
> https://wiki.archlinux.org/index.php/Bcache
>
> So for BlueStore this would work. A small, non-bcache, parition for X=
=46S and
> /dev/bcache0 for BlueStore directly.
>
> The question will be if you want ceph-disk to prepare bcache complete=
ly, or ask
> the user to provide a already configured device.
>
> $ ceph-disk prepare --bluestore --bcache /dev/sdc1:/dev/bcache0
>
> The first device will be the XFS partition with metadata and the seco=
nd will be
> data device.
>
> Wido
>
>> sage
>>
>> > If we add the flag --file-based-journal or --no-partitions we can =
create
>> > OSDs on
>> > both bcache and dm-cache.
>> >
>> > With BlueStore this becomes a problem since it requires the small =
(XFS)
>> > filesystem for it's metadata.
>> >
>> > Wido
>> >
>> > > The current syntax of
>> > >
>> > >  ceph-disk prepare [--dmcrypt] [--bluestore] DATADEV [JOURNALDEV=
]
>> > >
>> > > isn't terribly expressive.  For example, the journal device size=
 is set
>> > > via a config option, not on the command line.  For bluestore, th=
e metadata
>> > >
>> > > device will probably want/need explicit user input so they can e=
nsure it's
>> > >
>> > > 1/Nth of their SSD (if they have N HDDs to each SSD).
>> > >
>> > > And if we put dmcache in there, that partition will need to be s=
ized too.
>> > >
>> > > Another consideration is that right now we don't play nice with =
LVM at
>> > > all.  Should we?  dm-cache is usually used in conjunction with L=
VM
>> > > (although it doesn't have to be).  Does LVM provide value?  Like=
, the
>> > > ability for users to add a second SSD to a box and migrate cache=
, wal, or
>> > > journal partitions around?
>> > >
>> > > I'm interested in hearing feedback on requirements, approaches, =
and
>> > > interfaces before we go too far down the road...
>> > >
>> > > Thanks!
>> > > sage
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Cheers

=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Senior Cloud Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
