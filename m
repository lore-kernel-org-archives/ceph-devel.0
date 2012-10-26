From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [ceph-commit] Ceph Zfs
Date: Fri, 26 Oct 2012 12:38:17 -0700
Message-ID: <508AE6A9.3020104@inktank.com>
References: <441865dbf9e127f0b85193c512878a76@iihtcloudsolutions.com> <alpine.DEB.2.00.1210250834010.25762@cobra.newdream.net> <2a1583303809db2f73424d268d79e0ea@iihtcloudsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47518 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966222Ab2JZTiW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 15:38:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2981629pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 12:38:21 -0700 (PDT)
In-Reply-To: <2a1583303809db2f73424d268d79e0ea@iihtcloudsolutions.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Raghunandhan <raghunandhan.g@iihtcloudsolutions.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org



On 10/25/2012 09:46 PM, Raghunandhan wrote:
> Hi Sage,
>
> Thanks for replying back, Once a zpool is created if i mount it on
> /var/lib/ceph/osd/ceph-0 the cephfs doesnt recognize it as a superblock
> and hence it fails,

I assume you mean "once a zfs is created"?  One can't mount zpools, can one?

> Im trying to build this on our cloud storage since
> btrfs has not been stable nor they have come up with online dedup i have
> no other choice for now to work with zfs ceph which makes sense.
>
> So what i exactly did was created a zpool store
> 1 Then used the same store and made a block device from it using zfs create
> 2 Once the zfs create was successful i was able to format with ext4
> using xattr
> 3 On top of it was the ceph
>
> Following this process doesnt make sense because of multiple layer on
> the storage and the ceph consumes a lot of RAM and cpu cycles which ends
> up in kernel hung task. It would be great if there is a way i could
> directly use the zfs pool with ceph and make it work.

Have you actually tried making a zfs filesystem in the zpool, and using 
that as backing store for the osd?

>
> ---
> Regards,
> Raghunandhan.G
> IIHT Cloud Solutions Pvt. Ltd.
> #15, 4th Floor, 'A' Wing, Sri Lakshmi Complex,
> St. Marks Road, Bangalore - 560 001, India
>
> On 25-10-2012 22:06, Sage Weil wrote:
>> [moved to ceph-devel]
>>
>> On Thu, 25 Oct 2012, Raghunandhan wrote:
>>> Hi All,
>>>
>>> I have been working around ceph quite a long and trying to stitch zfs
>>> with
>>> ceph. I was able to do it to certain extent as follows:
>>> 1. zpool creation
>>> 2. set dedup
>>> 3. create a mountable volume of zfs (zfs create)
>>> 4. format the volume with ext4 and enabling xattr
>>> 5. mkcephfs on the volume
>>>
>>> This actually works and dedup is perfect. But i need to avoid
>>> multiple layers
>>> on the storage since the performance is very slow and the kernel timeout
>>> occurs often for a 8GB RAM. I want to test the performance between
>>> btrfs and
>>> zfs. I want to avoid the above multiple layering on storage and make
>>> the ceph
>>> cluster aware of zfs. Let me know if anyone has workaround this.
>>
>> I'm not familiar enough with zfs to know what 'mountable volume' means..
>> is that a block device/lun that you're putting ext4 on?  Probably the
>> best
>> results will come from creating a zfs *file system* (using the ZPL or
>> whatever it is) and running ceph-osd on top of that.
>>
>> There is at least one open bug from someone having problems there, but
>> we'd very much like to sort out the problem.
>>
>> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
