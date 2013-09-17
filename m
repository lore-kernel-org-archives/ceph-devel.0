From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH v2] rbd: add ioctl for rbd
Date: Tue, 17 Sep 2013 08:24:17 -0700
Message-ID: <52387421.3080906@inktank.com>
References: <1379401443-13569-1-git-send-email-guangliang@unitedstack.com> <52386A4E.6030805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:52629 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab3IQPYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Sep 2013 11:24:09 -0400
Received: by mail-qa0-f49.google.com with SMTP id k15so2057171qaq.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 Sep 2013 08:24:07 -0700 (PDT)
In-Reply-To: <52386A4E.6030805@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <alex.elder@linaro.org>
Cc: Guangliang Zhao <guangliang@unitedstack.com>, ceph-devel@vger.kernel.org, sage@inktank.com, lucienchao@gmail.com

On 09/17/2013 07:42 AM, Alex Elder wrote:
> On 09/17/2013 02:04 AM, Guangliang Zhao wrote:
>> When running the following commands:
>>      [root@ceph0 mnt]# blockdev --setro /dev/rbd2
>>      [root@ceph0 mnt]# blockdev --getro /dev/rbd2
>>      0
>
> I think this is a good change to make, and I think what
> you've done is overall fine.

I agree, and have a couple more comments.

> I do see one bug though.
>
> And despite my statement that "it's fine," I have a lot of
> input and suggestions for you to consider, below.
>
>> The block setro didn't take effect, it is because
>> the rbd doesn't support ioctl of block driver.
>>
>> The results with this patch:
>> root@ceph-client01:~# rbd map img
>> root@ceph-client01:~# blockdev --getro /dev/rbd1
>> 0
>> root@ceph-client01:~# cat /sys/block/rbd1/ro
>> 0
>> root@ceph-client01:~# blockdev --setro /dev/rbd1
>> root@ceph-client01:~# blockdev --getro /dev/rbd1
>> 1
>> root@ceph-client01:~# cat /sys/block/rbd1/ro
>> 1
>> root@ceph-client01:~# dd if=/dev/zero of=/dev/rbd1 count=1
>> dd: opening `/dev/rbd1': Read-only file system`
>> root@ceph-client01:~# blockdev --setrw /dev/rbd1
>> root@ceph-client01:~# blockdev --getro /dev/rbd1
>> 0
>> root@ceph-client01:~# cat /sys/block/rbd1/ro
>> 0
>> root@ceph-client01:~# dd if=/dev/zero of=/dev/rbd1 count=1
>> 1+0 records in
>> 1+0 records out
>> 512 bytes (512 B) copied, 0.14989 s, 3.4 kB/s
>
> As long as you're testing...
>
> It would be good to demonstrate that it's writable after
> a setrw call (i.e., by actually writing to it).
>
> And it would be good to show an attempt to change to
> read-write a mapped "base" image as well as a mapped
> snapshot image, both opened (mounted) and not.

Also a read-only mapped non-snapshot, which will catch
a bug with this patch:

rbd_request_fn reads rbd_dev->mapping.read_only when it is first
called, but once it's in the processing loop it never checks it again.
This will prevent an initially read-only mapping from ever becoming
read-write. The request loop needs to check for an updated
rbd_dev->mapping.read_only value.

This makes me notice another cleanup, though it doesn't affect the
functionality in this patch:

The place where the rbd driver calls set_device_ro() should be changed 
as well - it only needs to be done once, when the device is being added,
not during each open() call.

>> This resolves:
>> 	http://tracker.ceph.com/issues/6265
>>
>> Signed-off-by: Guangliang Zhao <guangliang@unitedstack.com>
>> ---
>>   drivers/block/rbd.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 2f00778..f700f7c 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -508,10 +508,65 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>>   	put_device(&rbd_dev->dev);
>>   }
>>
>> +static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
>> +			unsigned int cmd, unsigned long arg)
>> +{
>> +	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
>> +	int ro, ret = 0;
>> +
>> +	BUG_ON(!rbd_dev);
>
> Use:
> 	rbd_assert(rbd_dev);
>
>> +	spin_lock_irq(&rbd_dev->lock);
>> +	if (rbd_dev->open_count > 1) {
>
> This comment is not *extremely* important, but...
>
> I think it should be harmless (and successful) if the
> request to change the read-only status ends up being a
> no-op.  That is, if it's already a read-only mapping,
> and this is a request to make the device read-only,
> it should succeed.
>
>> +		spin_unlock_irq(&rbd_dev->lock);
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +	spin_unlock_irq(&rbd_dev->lock);
>
> Now that you've released the lock I think the device state
> could change in undesirable ways.
>
>> +	switch (cmd) {
>> +	case BLKROSET:
>> +		if (get_user(ro, (int __user *)(arg))) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		/* Snapshot doesn't allow to write*/
>> +		if (rbd_dev->spec->snap_id != CEPH_NOSNAP && ro) {
>
> I think the way you are interpreting the value of "ro" here
> is backward.  If "ro" is non-zero, it's a request to *make*
> the device be read-only.  And for a snapshot it already is.
> (This is the bug I referred to above.)
>
>> +			ret = -EROFS;
>> +			goto out;
>> +		}
>> +
>> +		if (rbd_dev->mapping.read_only != ro) {
>> +			rbd_dev->mapping.read_only = ro;
>
> I know the C standard says this int value will automatically
> get converted to either a Boolean true (1) or false (0), but
> I personally would prefer making that more explicit by applying
> a double unary NOT operation, i.e.:
>
> 			rbd_dev->mapping.read_only = !!ro;
>
>> +			set_disk_ro(rbd_dev->disk, ro);
>
> Similarly, the int value recorded by the genhd code
> simply saves whatever you give it.  I'd personally rather
> see that get passed an explicit 1 or 0 rather than whatever
> int value the user space caller provided.  (So maybe setting
> the value of "ro" to 0 or 1 initially would address both
> of my concerns.  I.e.:  get_user(val, ...); ro = val ? 1 : 0;)
>
> This is really more of an issue I have with the genhd code
> than what you've done.
>
>> +			goto out;
>> +		}
>> +
>> +		break;
>
> OK, now I have a very broad (and too detailed) suggestion.
> (I got a little carried away, sorry about that.)
>
> At this point there is only one IOCTL request that is handled
> by this function.  I know it doesn't match the general-purpose
> structure of your typical ioctl routine, but unless you think
> there are more ioctls that should be added, I think this could
> be made simpler by structuring the function something like:

I like this refactoring of it, but there are two minor issues
present in the original patch too:

> rbd_ioctl(...)
> {
> 	ret = 0;
> 	int argval;
> 	bool want_ro;
>
> 	if (cmd != BLKROSET)
> 		return -EINVAL;

According to block/ioctl.c, this should be -ENOTTY or -ENOIOCTLCOMMAND,
not -EINVAL.

>
> 	if (get_user(argval, ...))
> 		return -EFAULT;
> 	want_ro = !!argval;
>
> 	spin_lock();
> 	if (rbd_dev->mapping.read_only == want_ro)
> 		goto err_unlock;	/* No change, OK */
>
> 	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !want_ro) {
> 		ret = -EROFS;
> 		goto err_unlock;
> 	}
>
> 	/* Change requested; don't allow if already open */
> 	if (rbd_dev->open_count) {
> 		ret = -EBUSY;
> 		goto err_unlock;
> 	}
>
> 	rbd_dev->mapping.read_only = want_ro;
> 	spin_unlock();
> 	set_device_ro(bdev, want_ro ? 1 : 0);

block/ioctl.c will already call set_device_ro() for us after this
driver-specific handling completes successfully, so we don't need to
call it here. Also, it appears the block layer has a bug in that
it does the check for CAP_SYS_ADMIN *after* calling the driver-specific
code for BLKROSET. So the driver-specific part could succeed, but the
generic code could fail due to this later check without the driver
knowing, possibly leaving the driver inconsistent with the block layer.

Josh

>
> 	return 0;
> err_unlock:
> 	spin_unlock();
> 	return ret;
> }
>
> Even if you kept the generic switch() ... structure,
> you could put the logic for the read-only change into
> a separate function.
>
> 					-Alex
>
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>> +#ifdef CONFIG_COMPAT
>> +static int rbd_compat_ioctl(struct block_device *bdev, fmode_t mode,
>> +				unsigned int cmd, unsigned long arg)
>> +{
>> +	return rbd_ioctl(bdev, mode, cmd, arg);
>> +}
>> +#endif /* CONFIG_COMPAT */
>> +
>>   static const struct block_device_operations rbd_bd_ops = {
>>   	.owner			= THIS_MODULE,
>>   	.open			= rbd_open,
>>   	.release		= rbd_release,
>> +	.ioctl			= rbd_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl		= rbd_compat_ioctl,
>> +#endif
>>   };
>>
>>   /*
>>
>

