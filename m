From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph-disk improvements
Date: Tue, 5 Apr 2016 15:26:43 +0200
Message-ID: <CAOi1vP_CQJDW=0EBTXE965Lqtu7aewUraipJHkT_VqQau1FL2w@mail.gmail.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
	<2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<alpine.DEB.2.11.1604030859210.19675@cpach.fuggernut.com>
	<1651492587.2194.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<CA+HUO7LfPzCvFzi59ydivYdkCcbrRqdQSJVjVZtuar6avND9tA@mail.gmail.com>
	<CAOi1vP_mnMP_n7xSPXgEycYRifja0k4LE7PBG7epL1uUNWjaJw@mail.gmail.com>
	<570391B5.1050207@dachary.org>
	<CAJ3CzQWJnC7O6pcAF57MqYXMyZEpZVUSWhfynb6yue2iLKXfLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33802 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758876AbcDEN0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 09:26:45 -0400
Received: by mail-lb0-f173.google.com with SMTP id vo2so9277095lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 06:26:44 -0700 (PDT)
In-Reply-To: <CAJ3CzQWJnC7O6pcAF57MqYXMyZEpZVUSWhfynb6yue2iLKXfLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Yaple <sam@yaple.net>
Cc: Loic Dachary <loic@dachary.org>, Sebastien Han <shan@redhat.com>, Wido den Hollander <wido@42on.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>

On Tue, Apr 5, 2016 at 1:48 PM, Sam Yaple <samuel@yaple.net> wrote:
> On Tue, Apr 5, 2016 at 10:21 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi Ilya,
>>
>> On 05/04/2016 11:26, Ilya Dryomov wrote:
>> > On Tue, Apr 5, 2016 at 10:30 AM, Sebastien Han <shan@redhat.com> wrote:
>> >> Wido, I just discussed that with Sam last week and it seems that
>> >> bcache allocates a minor of 1 when creating the device.
>> >> Sam ended up writing this:
>> >> https://yaple.net/2016/03/31/bcache-partitions-and-dkms/
>> >> The fix is not complex not sure why it is not part of bcache yet...
>> >
>> > I think it's just that no one complained loud enough.
>> >
>> >>
>> >> Not sure if it's ceph-disk's job to do all of this with bcache
>> >> though...
>> >> We might need to check with the bache guys what are their plans about
>> >> this.
>> >> If this will go through at some point we might just wait, if not we
>> >> could implement the partition trick on ceph-disk.
>> >
>> > Making something like this go through shouldn't be a problem.  Sam's
>> > patch is a bit of quick hack though - it messes up bcache device IDs
>> > and also limits the number of partitions to 16.  Better to avoid
>> > another hard-coded constant, if possible.
>
>
> This has already been discussed with Kent Overstreet in the IRCs. I am
> looking into patching properly (this was very much a quick-and-dirty hack)
> but I will admit it is not a top priority for me. As far as it 'messing up
> bcache devices IDs' I would entirely disagree. For starters, this is how zfs
> spits out its volumes (/dev/zdb0, /dev/zdb16, etc). But more importantly I
> think is that up until this point bcache has been using the device minor
> number _as_ the bcache device number. Changing that behavior is less than
> ideal to me and surely more prone to bugs. Since you can't be assured that
> bcache0 will be the same device after a reboot anyway, I dont see why it
> matters. Use PartUUIDs and other labels and be done with it.

This is just common sense: if I create three bcache devices on my
system, I'd expect them to be named /dev/bcache{0,1,2} (or {1,2,3}, or
{a,b,c}) just like other block devices are.  An out-of-tree zfs is
hardly the best example to follow here.

Of course if userspace tooling expects or relies on minor numbers being
equal to device IDs, that's a good enough reason to keep it as is.  The
same goes for limiting the number of partitions to 16: if tools expect
the major to be the same for all bcache device partitions, it'd have to
be hard-coded.

Both of my points are just suggestions though.

>>
>> >
>> >     # ls -lh /dev/bcache*
>> >     brw-rw---- 1 root disk 254,  0 Mar 31 20:17 /dev/bcache0
>> >     brw-rw---- 1 root disk 254,  1 Mar 31 20:17 /dev/bcache0p1
>> >     brw-rw---- 1 root disk 254, 16 Mar 31 20:17 /dev/bcache16
>> >     brw-rw---- 1 root disk 254, 17 Mar 31 20:17 /dev/bcache16p1
>> >     brw-rw---- 1 root disk 254, 32 Mar 31 20:17 /dev/bcache32
>> >     brw-rw---- 1 root disk 254, 33 Mar 31 20:17 /dev/bcache32p1
>> >
>> > We had to solve almost exactly this problem in rbd.  I can submit
>> > a patch for bcache if it helps ceph-disk in the long run.
>
>
> While I was working on this, I have found myself busy don't have any idea of
> a time frame.
>
>>
>> It would help. Implementing a workaround in ceph-disk to compensate for
>> the fact that bcache does not support partitioning feels much better when
>> there is hope it will eventually be removed :-)
>
>
> There is no push back from Kent on this matter. I feel confident any
> implemented workaround in ceph-disk will be able to be removed.
>
> #bcache.2016-04-01.log:00:54 < py1hon> well, if you found it useful maybe
> other people will too, but to send a patch upstream I'd want to figure out
> what the most standard way is, if there is one :)

Thanks,

                Ilya
