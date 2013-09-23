From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH v3] rbd: add ioctl for rbd
Date: Mon, 23 Sep 2013 01:06:35 -0700
Message-ID: <523FF68B.80203@inktank.com>
References: <1379486151-8939-1-git-send-email-guangliang@unitedstack.com> <523DC10B.1080504@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50655 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab3IWIGo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 04:06:44 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so3123326obc.7
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 01:06:43 -0700 (PDT)
In-Reply-To: <523DC10B.1080504@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <alex.elder@linaro.org>, Guangliang Zhao <guangliang@unitedstack.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com, lucienchao@gmail.com

On 09/21/2013 08:53 AM, Alex Elder wrote:
> On 09/18/2013 01:35 AM, Guangliang Zhao wrote:
>> When running the following commands:
>>      [root@ceph0 mnt]# blockdev --setro /dev/rbd1
>>      [root@ceph0 mnt]# blockdev --getro /dev/rbd1
>>      0
>>
>> The block setro didn't take effect, it is because
>> the rbd doesn't support ioctl of block driver.
>
> Nicely done.
>
> I have a couple small comments below, and one simple
> change that needs to be made.
>
> I also point out another issue about the use of
> the spinlock to protect against read-only state
> changes; I'd like Josh to weigh in on how he thinks
> it might best be handled.
>
> Provided you make the simple change, and Josh has no
> problem with the read-only state thing:
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
> The required change is something Josh mentioned.  In
> rbd_request_fn(), the variable read_only is defined
> and assigned at the top of the function.  That line
> needs to be inside the while loop, to ensure that
> the most up-to-date value is used (in case it gets
> changed between requests).
>
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
> I don't necessarily want to see all this testing output
> in the commit description (a summary would suffice).  As
> Josh suggested, some sort of test script to validate all
> of this would be much appreciated.  It can be very simple:
> - map rbd device
> - run "blockdev --getro" on it, and verify it reports 0
> - run "blockdev --setro" and verify it is now read-only
> ... and so on.
>
> Tests we suggested, which I expect will pass but I
> don't see evidence of it in your description above:
> - verify changing the state (setro or setrw) fails on
>    a device that's already open (e.g. mounted) (EBUSY)
> - verify setro on a snapshot that's mounted (EBUSY)
> - verify setrw on a non-snapshot image that is mapped
>    read-only (EROFS)

To be clear, you have to use the sysfs interface with the 'ro' option
to test this case, rather than using the 'rbd map' command, which
has no way to pass the 'ro' or 'rw' options.

The syntax is documented in Documentation/ABI/testing/sysfs-bus-rbd.

> - verify setrw on a snapshot fails (EROFS)
>
>> This resolves:
>> 	http://tracker.ceph.com/issues/6265
>>
>> Signed-off-by: Guangliang Zhao <guangliang@unitedstack.com>
>> ---
>>   drivers/block/rbd.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 2f00778..fea826d 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -508,10 +508,69 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>>   	put_device(&rbd_dev->dev);
>>   }
>>
>> +static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
>> +{
>> +	int val;
>> +	bool ro;
>> +
>> +	if (get_user(val, (int __user *)(arg)))
>> +		return -EFAULT;
>> +
>> +	ro = val ? true : false;
>> +	/* Snapshot doesn't allow to write*/
>> +	if (rbd_dev->spec->snap_id != CEPH_NOSNAP && !ro)
>> +		return -EROFS;
>> +
>> +	if (rbd_dev->mapping.read_only != ro) {
>> +		rbd_dev->mapping.read_only = ro;
>> +		set_disk_ro(rbd_dev->disk, ro ? 1 : 0);
>
> This is interesting.  Josh mentioned that the set_device_ro()
> call you had here previously was not needed, because the generic
> ioctl code handled it.
>
> But I believe calling set_disk_ro() (which triggers a udev event)
> is the right thing to do, even though rbd doesn't support partitions.
> In fact, it might be more appropriate for the generic code to call
> that using bdev->bd_disk.  Hmmm.  (I don't have time to look into
> this any further right now, maybe if someone thinks it's worth
> pursuing they can do so.)
>
> In the mean time this does more than set_device_ro(), and the
> redundancy is harmless.  HOWEVER I believe that calling
> this while holding the spinlock will cause locking problems
> (or may just be a bad idea).  I don't know for sure; let
> lockdep be your guide.

I'm not sure about this either, it'd be good to verify it's
ok by running with lockdep.

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
>> +			unsigned int cmd, unsigned long arg)
>> +{
>> +	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
>> +	int ret = 0;
>> +
>> +	spin_lock_irq(&rbd_dev->lock);
>> +	/* prevent others open this device */
>
> I think indicating something more like "make sure we hold the only
> reference to this device" would make it clear why you're checking
> against 1 rather than 0.
>
>> +	if (rbd_dev->open_count > 1) {
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>
> You are adding a new ability to change a fundamental state
> for an image.  You're using the spinlock now to protect
> the read-only state, where previously it was only used to
> protect the open count and REMOVING state/flag.  This
> may mean you should check the read_only flag in rbd_open()
> inside the spinlock there.  And you may need to call the
> set_device_ro() there under protection of that lock.
>
> As I mentioned above, holding the lock could also lead
> to a problem when calling outside code (set_disk_ro()).
> If that's the case you may need to devise a different
> (possibly additional) way to protect this.
>
> Josh, please offer your insights.

I think with the current structure (rbd_open() calling set_device_ro())
protecting this with a spinlock won't cause a lock inversion, since
rbd_open() is not called with the bdev lock held.

With the change to rbd_request_fn() Alex mentioned, could you verify
it has no problems with lockdep enabled? If so, it looks good to me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>> +
>> +	switch (cmd) {
>> +	case BLKROSET:
>> +		ret = rbd_ioctl_set_ro(rbd_dev, arg);
>> +		break;
>> +	default:
>> +		ret = -ENOTTY;
>> +	}
>> +
>> +out:
>> +	spin_unlock_irq(&rbd_dev->lock);
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

