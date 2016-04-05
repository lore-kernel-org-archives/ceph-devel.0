From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph-disk improvements
Date: Tue, 5 Apr 2016 16:42:52 +0200
Message-ID: <CAOi1vP--kDzPeaaPW+VVGtYA6PxcHtoLC1_zWNaPopm5=37Fgg@mail.gmail.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
	<2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<alpine.DEB.2.11.1604030859210.19675@cpach.fuggernut.com>
	<1651492587.2194.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<CA+HUO7LfPzCvFzi59ydivYdkCcbrRqdQSJVjVZtuar6avND9tA@mail.gmail.com>
	<CAOi1vP_mnMP_n7xSPXgEycYRifja0k4LE7PBG7epL1uUNWjaJw@mail.gmail.com>
	<570391B5.1050207@dachary.org>
	<CAJ3CzQWJnC7O6pcAF57MqYXMyZEpZVUSWhfynb6yue2iLKXfLA@mail.gmail.com>
	<CAOi1vP_CQJDW=0EBTXE965Lqtu7aewUraipJHkT_VqQau1FL2w@mail.gmail.com>
	<CAJ3CzQUWyF-B6o5wBmJ0rcfK_aBkmSX7LcRDkLj=W5COSbPwnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34814 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbcDEOmy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 10:42:54 -0400
Received: by mail-lf0-f66.google.com with SMTP id e190so1510634lfe.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 07:42:53 -0700 (PDT)
In-Reply-To: <CAJ3CzQUWyF-B6o5wBmJ0rcfK_aBkmSX7LcRDkLj=W5COSbPwnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Yaple <sam@yaple.net>
Cc: Loic Dachary <loic@dachary.org>, Sebastien Han <shan@redhat.com>, Wido den Hollander <wido@42on.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Kent Overstreet <kent.overstreet@gmail.com>

On Tue, Apr 5, 2016 at 4:10 PM, Sam Yaple <samuel@yaple.net> wrote:
> On Tue, Apr 5, 2016 at 1:26 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Tue, Apr 5, 2016 at 1:48 PM, Sam Yaple <samuel@yaple.net> wrote:
>> > On Tue, Apr 5, 2016 at 10:21 AM, Loic Dachary <loic@dachary.org> wrote:
>> >>
>> >> Hi Ilya,
>> >>
>> >> On 05/04/2016 11:26, Ilya Dryomov wrote:
>> >> > On Tue, Apr 5, 2016 at 10:30 AM, Sebastien Han <shan@redhat.com>
>> >> > wrote:
>> >> >> Wido, I just discussed that with Sam last week and it seems that
>> >> >> bcache allocates a minor of 1 when creating the device.
>> >> >> Sam ended up writing this:
>> >> >> https://yaple.net/2016/03/31/bcache-partitions-and-dkms/
>> >> >> The fix is not complex not sure why it is not part of bcache yet...
>> >> >
>> >> > I think it's just that no one complained loud enough.
>> >> >
>> >> >>
>> >> >> Not sure if it's ceph-disk's job to do all of this with bcache
>> >> >> though...
>> >> >> We might need to check with the bache guys what are their plans
>> >> >> about
>> >> >> this.
>> >> >> If this will go through at some point we might just wait, if not we
>> >> >> could implement the partition trick on ceph-disk.
>> >> >
>> >> > Making something like this go through shouldn't be a problem.  Sam's
>> >> > patch is a bit of quick hack though - it messes up bcache device IDs
>> >> > and also limits the number of partitions to 16.  Better to avoid
>> >> > another hard-coded constant, if possible.
>> >
>> >
>> > This has already been discussed with Kent Overstreet in the IRCs. I am
>> > looking into patching properly (this was very much a quick-and-dirty
>> > hack)
>> > but I will admit it is not a top priority for me. As far as it 'messing
>> > up
>> > bcache devices IDs' I would entirely disagree. For starters, this is how
>> > zfs
>> > spits out its volumes (/dev/zdb0, /dev/zdb16, etc). But more importantly
>> > I
>> > think is that up until this point bcache has been using the device minor
>> > number _as_ the bcache device number. Changing that behavior is less
>> > than
>> > ideal to me and surely more prone to bugs. Since you can't be assured
>> > that
>> > bcache0 will be the same device after a reboot anyway, I dont see why it
>> > matters. Use PartUUIDs and other labels and be done with it.
>>
>> This is just common sense: if I create three bcache devices on my
>> system, I'd expect them to be named /dev/bcache{0,1,2} (or {1,2,3}, or
>> {a,b,c}) just like other block devices are.  An out-of-tree zfs is
>> hardly the best example to follow here.
>
>
> They actually _won't_ be named bcache{0,1,2} in a long running system.
> Scenario is you create and delete a bcache device, the module keeps track of
> that counter so it might be /dev/bcache{0,4,5}. Maybe call it a bug? either
> way thats how it currently works. Fair enough about zfs, and frankly I don't
> have strong opinions about the naming. Im worried about regressions though.

Does it?  It's not a simple counter - those IDs are managed by an ida
tree.  You grab an ID, when you are done with it (i.e. delete a device),
you put it back and it becomes available for reuse.

>>
>>
>> Of course if userspace tooling expects or relies on minor numbers being
>> equal to device IDs, that's a good enough reason to keep it as is.  The
>> same goes for limiting the number of partitions to 16: if tools expect
>> the major to be the same for all bcache device partitions, it'd have to
>> be hard-coded.
>
> The hard-coded-ness was part of the quick-and-dirty fix. I haven't looked at
> how, say, the sd* drivers work but they, by default, increment by 16. So at
> the very least it could be a sane default. The loop driver has a max_part
> option. Not a big fan of that myself, but it is an option. And again I
> really don't care about the way we solve this as long as it is solved. Like
> Kent said, we just need to find the "standard" way to do this, or the least
> bad.

I think the most "standard" way is:

- Reuse device IDs.  It looks like bcache is already using an ida tree
  for its minors (device IDs, currently), so if you are seeing {0,1,4},
  it's probably a bug.

- Preallocate 16 minors.  Don't introduce max_part or anything like
  that.

- Use extended devt to support devices with more than 16 partitions.
  The catch is those (p17+) partitions are going to have a different
  (fixed) major, so one would have to make sure that bcache tools are
  fine with that.

That's what rbd, virtblk and a bunch of other block device drivers are
doing and that's the patch that I had in mind.

Thanks,

                Ilya
