From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: can "rbd unmap" detect if device is mounted?
Date: Mon, 16 Jul 2012 19:00:43 -0400
Message-ID: <CACkq2mqM2vDke-0VnWvy0Mwh102heUc10AxJ=8KSZRNbM7eJ7A@mail.gmail.com>
References: <CACkq2mqt5ae4U_-yhNM94GYQnE_negqXqHTf3JaSZ0zsxya9Yw@mail.gmail.com>
 <500498FC.9070806@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46720 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab2GPXBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 19:01:05 -0400
Received: by lbbgm6 with SMTP id gm6so9342791lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 16:01:04 -0700 (PDT)
In-Reply-To: <500498FC.9070806@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the response, Josh. Sorry I didn't send in my version info
with the initial message.

On Mon, Jul 16, 2012 at 6:43 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 07/16/2012 12:59 PM, Travis Rhoden wrote:
>>
>> Hi folks,
>>
>> I've made this mistake a couple of times now (completely my fault,
>> when will I learn?), and am wondering if a bit of protection can be
>> put in place against user errors.
>
>
> Yeah, we've been working on advisory locking. The first step is
> just adding an option to lock via the rbd command line tool, so you
> could script lock/map and unmap/unlock.
>
> This is described a little more in this thread:
>
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/7094

I had in fact seen this.  Looks like the advisory locking is targeted
for 0.49.  That's great!  Thanks for reminding me of it.  I'll look
forward to it.
>
>
>> I mapped a device "rbd map", then formatted and and mounted the device
>> ("mkfs.extf /dev/rbd0..., mount /dev/rbd0...").  Then sometime later,
>> I want to remove the RBD device.  Stupidly, I do the "rbd unmap"
>> command before I unmount the device.  The kernel doesn't really care
>> for this.  Or more accurately, I can't remap that same RBD because I
>> run into:
>>
>> kernel: [2248653.941688] sysfs: cannot create duplicate filename
>> '/devices/virtual/block/rbd0'
>> ....
>> kernel: [2248653.941833] kobject_add_internal failed for rbd0 with
>> -EEXIST, don't try to register things with the same name in the same
>> directory.
>>
>> At this point, the "rbd map" command hangs indefinitely (producing the
>> logs from above).  Ctrl-C does exit out, though.  But if I try to fix
>> my mistake by doing the unmount now, I get the error:
>>
>> umount: device is busy.
>>
>> So really I get stuck.  I can't unmount without the device, and I
>> can't remap the device to the old block device.  I have to reboot to
>> clean up and move on.
>
>
> A similar issue was fixed in 3.4 (see
> http://tracker.newdream.net/issues/1907).
> What kernel are you using? 3.2 had a nasty possibility of preventing
> further operations if mapping hung while trying to connect to the
> monitors.

I am using the stock Ubuntu 12.04 kernel, which is in fact 3.2  Good
point.  So, the only way for me to get the updates you mentioned is to
upgrade to a 3.4 kernel, correct?
>
>
>> I imagine other bad things can happen with the block device goes away
>> out from under the mount point.  Any way the "rbd unmap" command can
>> detect when the device is in use or mounted and inform the user?
>
>
> Before actually unmapping the device, rbd unmap could check if it was
> present in mtab. If it's being used as a raw block device and not
> mounted or you created and used your own device node this wouldn't
> help, but it would be better than nothing.

That would be awesome.  Every little bit helps.
>
> Josh
