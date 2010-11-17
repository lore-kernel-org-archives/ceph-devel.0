From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH] rbd: replace the rbd sysfs interface
Date: Wed, 17 Nov 2010 15:00:17 -0800
Message-ID: <AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
References: <1289953929-30896-1-git-send-email-yehuda@hq.newdream.net>
	<20101117171924.GC12050@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55148 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840Ab0KQXAU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Nov 2010 18:00:20 -0500
In-Reply-To: <20101117171924.GC12050@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 17, 2010 at 9:19 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 16, 2010 at 04:32:09PM -0800, Yehuda Sadeh wrote:
>> Hi Greg,
>>
>> Following is the new rbd sysfs interface. It lists devices in their =
own
>> subdirectories, as well as their underlying snapshots. Please let us
>> know if there's any issue you think we missed or did wrong.
>>
>> Thanks,
>> Yehuda
>>
>> ---
>>
>> The new interface creates directories per mapped image
>> and under each it creates a subdir per available snapshot.
>> This allows keeping a cleaner interface within the sysfs
>> guidelines. The ABI documentation was updated too.
>>
>> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
>> ---
>> =A0Documentation/ABI/testing/sysfs-class-rbd | =A0 83 +++
>> =A0drivers/block/rbd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0775 +++++++++++++++++------------
>> =A02 files changed, 547 insertions(+), 311 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-rbd b/Documentati=
on/ABI/testing/sysfs-class-rbd
>> new file mode 100644
>> index 0000000..4d96618
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-rbd
>> @@ -0,0 +1,83 @@
>> +What: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/sys/class/rbd/
>
> I thought I mentioned that you should not add new classes to the kern=
el.
> Please don't do that, make it a bus_type instead.


Ahmm.. apparently not in the rbd related threads. So moving things
around and having rbd under /sys/bus we'll have the following:

/sys/bus/rbd/drivers/rbd/..
    add - add a device
    remove - remove a device

/sys/bus/rbd/devices/<id>
   name
   pool
   ...

/sys/bus/rbd/devices/<id>/snaps/<name>
    id
    size
    ...


Would this work?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
