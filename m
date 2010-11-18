From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH] rbd: replace the rbd sysfs interface
Date: Thu, 18 Nov 2010 14:53:35 -0800
Message-ID: <AANLkTi=7z40CNBUmfVUEa68J+1R=7nbn9d8vM7ETpajA@mail.gmail.com>
References: <1289953929-30896-1-git-send-email-yehuda@hq.newdream.net>
	<20101117171924.GC12050@kroah.com>
	<AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
	<20101118013002.GC8558@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49835 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab0KRWxk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Nov 2010 17:53:40 -0500
In-Reply-To: <20101118013002.GC8558@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 17, 2010 at 5:30 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 17, 2010 at 03:00:17PM -0800, Yehuda Sadeh Weinraub wrote=
:
>> On Wed, Nov 17, 2010 at 9:19 AM, Greg KH <greg@kroah.com> wrote:
>> > On Tue, Nov 16, 2010 at 04:32:09PM -0800, Yehuda Sadeh wrote:
>> >> Hi Greg,
>> >>
>> >> Following is the new rbd sysfs interface. It lists devices in the=
ir own
>> >> subdirectories, as well as their underlying snapshots. Please let=
 us
>> >> know if there's any issue you think we missed or did wrong.
>> >>
>> >> Thanks,
>> >> Yehuda
>> >>
>> >> ---
>> >>
>> >> The new interface creates directories per mapped image
>> >> and under each it creates a subdir per available snapshot.
>> >> This allows keeping a cleaner interface within the sysfs
>> >> guidelines. The ABI documentation was updated too.
>> >>
>> >> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
>> >> ---
>> >> ?Documentation/ABI/testing/sysfs-class-rbd | ? 83 +++
>> >> ?drivers/block/rbd.c ? ? ? ? ? ? ? ? ? ? ? | ?775 +++++++++++++++=
++------------
>> >> ?2 files changed, 547 insertions(+), 311 deletions(-)
>> >>
>> >> diff --git a/Documentation/ABI/testing/sysfs-class-rbd b/Document=
ation/ABI/testing/sysfs-class-rbd
>> >> new file mode 100644
>> >> index 0000000..4d96618
>> >> --- /dev/null
>> >> +++ b/Documentation/ABI/testing/sysfs-class-rbd
>> >> @@ -0,0 +1,83 @@
>> >> +What: ? ? ? ? ? ? ? ?/sys/class/rbd/
>> >
>> > I thought I mentioned that you should not add new classes to the k=
ernel.
>> > Please don't do that, make it a bus_type instead.
>>
>>
>> Ahmm.. apparently not in the rbd related threads. So moving things
>> around and having rbd under /sys/bus we'll have the following:
>>
>> /sys/bus/rbd/drivers/rbd/..
>> =A0 =A0 add - add a device
>> =A0 =A0 remove - remove a device
>
> These files could go in /sys/bus/rbd/ directly instead of burying und=
er
> 2 more layers, right?
>
>>
>> /sys/bus/rbd/devices/<id>
>> =A0 =A0name
>> =A0 =A0pool
>> =A0 =A0...
>>
>> /sys/bus/rbd/devices/<id>/snaps/<name>
>> =A0 =A0 id
>> =A0 =A0 size
>> =A0 =A0 ...
>>
>>
>> Would this work?
>
> With the change mentioned above, I think that seems sane, do you?
>

Yes, pretty much. One problem that I do see is that if we define the
snaps/ as a device (and not just as a kobj) as you suggested before,
it'll automatically create a 'uevent' entry under it which can be a
real issue in the case we have a snapshot named like that. Shouldn't
we just create it as a kobj in that case?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
