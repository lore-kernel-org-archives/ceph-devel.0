From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [RFC] rbd sysfs interface
Date: Wed, 10 Nov 2010 21:16:47 -0800
Message-ID: <AANLkTikUjYUR-WguZ999YtyWLc8+U0184y0Sb6SSSgKz@mail.gmail.com>
References: <AANLkTinOeby9P847gJFn_t0h5nDY7cfi3cW9hEaUrS1v@mail.gmail.com>
	<20101106050721.GA2194@kroah.com>
	<AANLkTinQK_9qp-8jJ5j3-ChUjwhGiGzAmCu5cBtHX75g@mail.gmail.com>
	<AANLkTikdr=nJF45QUCKAOY8NSh9GNtv8c9K_oNdJeJfc@mail.gmail.com>
	<20101111010841.GA23127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42798 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0KKFQt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Nov 2010 00:16:49 -0500
In-Reply-To: <20101111010841.GA23127@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, linux-kernel@vger.kernel.org

On Wed, Nov 10, 2010 at 5:08 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 10, 2010 at 11:21:49AM -0800, Yehuda Sadeh Weinraub wrote=
:
>> On Fri, Nov 5, 2010 at 10:51 PM, Yehuda Sadeh Weinraub
>> <yehudasa@gmail.com> wrote:
>> > On Fri, Nov 5, 2010 at 10:07 PM, Greg KH <greg@kroah.com> wrote:
>> >> On Fri, Nov 05, 2010 at 04:09:31PM -0700, Yehuda Sadeh Weinraub w=
rote:
>> >>>
>> >>> Does this seem sane? Any comments would be greatly appreciated.
>> >>
>> >> It sounds like you need to use configfs instead of sysfs, as your=
 model
>> >> was the reason it was created.
>> >>
>> >> Have you tried that?
>> >
>> > Oh, will look at it now. With ceph (although for a different purpo=
se)
>> > we went through proc -> sysfs -> debugfs, however, it seems that w=
e've
>> > missed at least one userspace-kernel channel.
>> >
>>
>> Well, we looked a bit at what configfs does, and from what we see it
>> doesn't really fit our needs. Configfs would be more suitable to
>> configuring a static system than to control a dynamic one. The main
>> problem is that items creation is only driven by userspace. That wou=
ld
>> be ok if we had a static mapping of the images and snapshots, howeve=
r,
>> we don't. We need the system to reflect any state change with the
>> running configuration (e.g., a new snapshot was created by a differe=
nt
>> client), and it doesn't seem possible with configfs as long as items
>> creation is only driven by userspace operations. We need a system th=
at
>> would be able to reflect changes that happened due to some external
>> operation, and this doesn't seem to be the case here.
>>
>> There is second issue and that's committable items are not implement=
ed
>> there yet. So the interface itself would be a bit weird. E.g., had
>> committable items been implemented we would have done something like
>> the following:
>>
>> =A0/config/rbd# mkdir pending/myimage
>> =A0/config/rbd# echo foo > pending/myimage/name
>> =A0/config/rbd# cat ~/mykey > pending/myimge/key
>> =A0/config/rbd# echo 10.0.0.1 > pending/myimage/addr
>> ...
>> =A0/config/rbd# mv pending/myimage live/
>>
>> and that would do what we need in terms of initial configuration.
>> However, as this is not really implemented yet, there is no
>> distinction between images that are pending and images that are live=
,
>> so configuration would look something like:
>> =A0/config/rbd# mkdir myimage
>> =A0/config/rbd# echo foo > myimage/name
>> =A0/config/rbd# cat ~/mykey > myimge/key
>> =A0/config/rbd# echo 10.0.0.1 > myimage/addr
>> ...
>> =A0/config/rbd# echo 1 > myimage/go
>>
>> And having that, the myimage/ directory will still hold all those
>> config options that are moot after the image went live. It doesn't
>> seem to offer a significant improvement over the current sysfs one
>> liner configuration and with sysfs we can have it reflect any dynami=
c
>> change that occurred within the system. So we tend to opt for an
>> improved sysfs solution, similar to the one I described before.
>
> Ok, that makes sense as to why configfs would not work (I really wish
> someone would add the commit stuff to configfs, as you aren't the fir=
st
> ones to want that.)
>
> So, back to sysfs. =A0But I can't recall what your sysfs interface lo=
oked
> like, do you have Documentation/ABI/ files that show what it does? =A0=
If
> not, you are required to, so you might as well write them now :)
>

The original sysfs interface is described in the rbd.c prefix
comments, which we can copy to Documentation/ABI without much pain.
However, we were just thinking of modifying it a bit, as described
previously in my first email. The hierarchy will look like this:

rbd/
    add
    remove
    <id>/
      name
      pool
      size
      ..
      snap_add
      snap_remove
      snap_rollback
        <snap_name>/
          size

The 'add' entry will be used to add a device (as before):

 # echo "10.0.0.1 name=3Dadmin rbd myimage" > /sys/class/rbd/add

The devices that'll be created still be enumerated, and there'll be a
subdirectory under rbd/ for each (actually a soft link to
/sys/devices/virtual/rbd/<id>). For each device we'll have multiple
read-only properties (name, pool, size, client_id, major, cur_snap)
and a few control entries (e.g., snap_add, snap_remove, etc.)

There will be a subdirectory per snapshot under each device, and all
the snapshots properties will be kept there.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
