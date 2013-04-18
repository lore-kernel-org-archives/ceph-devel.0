From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor write performance
Date: Thu, 18 Apr 2013 12:01:20 -0500
Message-ID: <517026E0.9070905@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <CABYiri-9=ADNQgnVENJLrvW18f1+XcMTzDUSDmuLcikjS5u5iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53]:61082 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967752Ab3DRRBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 13:01:24 -0400
Received: by mail-vb0-f53.google.com with SMTP id i3so2608593vbh.26
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 10:01:23 -0700 (PDT)
In-Reply-To: <CABYiri-9=ADNQgnVENJLrvW18f1+XcMTzDUSDmuLcikjS5u5iA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: James Harper <james.harper@bendigoit.com.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/18/2013 11:46 AM, Andrey Korolyov wrote:
> On Thu, Apr 18, 2013 at 5:43 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
>> On 04/18/2013 06:46 AM, James Harper wrote:
>>>
>>> I'm doing some basic testing so I'm not really fussed about poor
>>> performance, but my write performance appears to be so bad I think I'm doing
>>> something wrong.
>>>
>>> Using dd to test gives me kbytes/second for write performance for 4kb
>>> block sizes, while read performance is acceptable (for testing at least).
>>> For dd I'm using iflag=direct for read and oflag=direct for write testing.
>>>
>>> My setup, approximately, is:
>>>
>>> Two OSD's
>>> . 1 x 7200RPM SATA disk each
>>> . 2 x gigabit cluster network interfaces each in a bonded configuration
>>> directly attached (osd to osd, no switch)
>>> . 1 x gigabit public network
>>> . journal on another spindle
>>>
>>> Three MON's
>>> . 1 each on the OSD's
>>> . 1 on another server, which is also the one used for testing performance
>>>
>>> I'm using debian packages from ceph which are version 0.56.4
>>>
>>> For comparison, my existing production storage is 2 servers running DRBD
>>> with iSCSI to the initiators which run Xen on top of a (C)LVM volumes on top
>>> of the iSCSI. Performance not spectacular but acceptable. The servers in
>>> question are the same specs as the servers I'm testing on.
>>>
>>> Where should I start looking for performance problems? I've tried running
>>> some of the benchmark stuff in the documentation but I haven't gotten very
>>> far...
>>
>>
>> Hi James!  Sorry to hear about the performance trouble!  Is it just
>> sequential 4KB direct IO writes that are giving you troubles?  If you are
>> using the kernel version of RBD, we don't have any kind of cache implemented
>> there and since you are bypassing the pagecache on the client, those writes
>> are being sent to the different OSDs in 4KB chunks over the network.  RBD
>> stores data in blocks that are represented by 4MB objects on one of the
>> OSDs, so without cache a lot of sequential 4KB writes will be hitting 1 OSD
>> repeatedly and then moving on to the next one.  Hopefully those writes would
>> get aggregated at the OSD level, but clearly that's not really happening
>> here given your performance.
>>
>> Here's a couple of thoughts:
>>
>> 1) If you are working with VMs, using the QEMU/KVM interface with virtio
>> drivers and RBD cache enabled will give you a huge jump in small sequential
>> write performance relative to what you are seeing now.
>>
>> 2) You may want to try upgrading to 0.60.  We made a change to how the
>> pg_log works that causes fewer disk seeks during small IO, especially with
>> XFS.
>
> Can you point into related commits, if possible?

here you go:

http://tracker.ceph.com/projects/ceph/repository/revisions/188f3ea6867eeb6e950f6efed18d53ff17522bbc


>
>>
>> 3) If you are still having trouble, testing your network, disk speeds, and
>> using rados bench to test the object store all may be helpful.
>>
>>>
>>> Thanks
>>>
>>> James
>>
>>
>> Good luck!
>>
>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

