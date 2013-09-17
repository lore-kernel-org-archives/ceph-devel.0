From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v2] rbd: add ioctl for rbd
Date: Tue, 17 Sep 2013 11:11:36 -0500
Message-ID: <52387F38.8020506@linaro.org>
References: <1379401443-13569-1-git-send-email-guangliang@unitedstack.com> <52386A4E.6030805@linaro.org> <52387421.3080906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55094 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3IQQLX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Sep 2013 12:11:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so5756439obc.33
        for <ceph-devel@vger.kernel.org>; Tue, 17 Sep 2013 09:11:23 -0700 (PDT)
In-Reply-To: <52387421.3080906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Guangliang Zhao <guangliang@unitedstack.com>, ceph-devel@vger.kernel.org, sage@inktank.com, lucienchao@gmail.com

On 09/17/2013 10:24 AM, Josh Durgin wrote:

. . .

>>
>> OK, now I have a very broad (and too detailed) suggestion.
>> (I got a little carried away, sorry about that.)
>>
>> At this point there is only one IOCTL request that is handled
>> by this function.  I know it doesn't match the general-purpose
>> structure of your typical ioctl routine, but unless you think
>> there are more ioctls that should be added, I think this could
>> be made simpler by structuring the function something like:
> 
> I like this refactoring of it, but there are two minor issues
> present in the original patch too:
> 
>> rbd_ioctl(...)
>> {
>>     ret = 0;
>>     int argval;
>>     bool want_ro;
>>
>>     if (cmd != BLKROSET)
>>         return -EINVAL;
> 
> According to block/ioctl.c, this should be -ENOTTY or -ENOIOCTLCOMMAND,
> not -EINVAL.

I wondered about that, and actually looked at it but I thought
I saw other ioctl functions returning -EINVAL so I stopped looking
and didn't mention anything.

>>     if (get_user(argval, ...))
>>         return -EFAULT;
>>     want_ro = !!argval;
>>
>>     spin_lock();
>>     if (rbd_dev->mapping.read_only == want_ro)
>>         goto err_unlock;    /* No change, OK */
>>
>>     if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !want_ro) {
>>         ret = -EROFS;
>>         goto err_unlock;
>>     }
>>
>>     /* Change requested; don't allow if already open */
>>     if (rbd_dev->open_count) {
>>         ret = -EBUSY;
>>         goto err_unlock;
>>     }
>>
>>     rbd_dev->mapping.read_only = want_ro;
>>     spin_unlock();
>>     set_device_ro(bdev, want_ro ? 1 : 0);
> 
> block/ioctl.c will already call set_device_ro() for us after this
> driver-specific handling completes successfully, so we don't need to
> call it here. Also, it appears the block layer has a bug in that
> it does the check for CAP_SYS_ADMIN *after* calling the driver-specific
> code for BLKROSET. So the driver-specific part could succeed, but the
> generic code could fail due to this later check without the driver
> knowing, possibly leaving the driver inconsistent with the block layer.

I wonder if that's intentional, but I doubt it.  It predates
the original Linux-2.6.12-rc2 git commit.

But I agree with you, I think it's a bug.  Do you plan to submit
a patch upstream to propose a fix?

					-Alex
