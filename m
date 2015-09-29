From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Pull request for FileStore write path optimization
Date: Tue, 29 Sep 2015 15:18:14 -0500
Message-ID: <560AF206.509@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE5B30C@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbbI2USS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Sep 2015 16:18:18 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE5B30C@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yay!  Very much looking forward to checking this out Somnath!  I'll let 
you know how it goes.

Mark

On 09/29/2015 01:14 PM, Somnath Roy wrote:
> Hi Mark,
> I have sent out the following pull request for my write path changes.
>
> https://github.com/ceph/ceph/pull/6112
>
> Meanwhile, if you want to give it a spin to your SSD cluster , take the following branch.
>
> https://github.com/somnathr/ceph/tree/wip-write-path-optimization
>
> 1. Please use the following config options to enable the fast write path..
>
>          filestore_odsync_write = true //This will make the actual transaction write as O_DSYNC
>          filestore_fast_commit = true //This will disable all of the existing throttling scheme
>          filestore_do_fast_sync = true    //This is presently only applicable to XFS backend. In general , it should be fine for any FS where FileStore is going for write_ahead journaling. I will open it for other FS (like ext4) after testing.
>
>
> 2. If both data and journal are on the same SSD , please tune the following parameter starting from lower value.
>
>          journal_max_write_entries = 10
>
> This heavily depends on how fast your backend and journal is. If you go for bigger value , the journal will be going further ahead (since applying transaction will be always slower) and memory usage for OSD will be increasing. You need to increase this value till you see memory is piling up. Increasing this value     should increase performance considerably.
>
> 3. Another parameter we need to tune mostly in case of say NVRAM as journal is the following.
>
>        journal_induce_delay
>
> But, I found the default value I gave should be fine if both data and journal is on the same SSD. Since you have faster backend, you may want to make it a bit lower. I would say play with journal_max_write_entries first.
> I have a plan to automate this parameter from inside by recognizing the workload patter in future.
>
> 4. I found disabling journal aio is giving me more stable performance out. Aio is not giving me any performance gain for me either.
>
>      journal_aio = false
>
> 5. Finally, I found the following VM tuning params are useful to deal with the xfsaild problem that I mentioned sometimes back. This should stabilize the write performance.
>
>    sysctl -w vm.dirty_ratio=80
>    sysctl -w vm.dirty_background_ratio=3
>    sysctl -w fs.xfs.xfssyncd_centisecs=720000
>    sysctl -w fs.xfs.xfsbufd_centisecs=3000
>    sysctl -w fs.xfs.age_buffer_centisecs=720000
>
> Let me know if you need further information on this.
>
> Thanks & Regards
> Somnath
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
