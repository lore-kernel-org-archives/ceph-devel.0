From: Phil Carns <carns@mcs.anl.gov>
Subject: Re: block device journal durability
Date: Wed, 16 Jun 2010 13:32:39 -0400
Message-ID: <4C190AB7.7000200@mcs.anl.gov>
References: <4C18E3C4.5030303@mcs.anl.gov> <Pine.LNX.4.64.1006161000170.12761@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailhost.anl.gov ([130.202.113.50]:32991 "EHLO mailhost.anl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308Ab0FPRcl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jun 2010 13:32:41 -0400
In-Reply-To: <Pine.LNX.4.64.1006161000170.12761@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 06/16/2010 01:03 PM, Sage Weil wrote:
> On Wed, 16 Jun 2010, Phil Carns wrote:
>    
>> I noticed that Ceph issues a warning if it detects that you are using a raw
>> block device as the journal and write caching is enabled on that device.
>>
>> When it opens the block device file, however, the FileJournal is using
>> O_DIRECT|O_SYNC.  In recent kernels, syncing a block device file actually
>> triggers a proper write barrier operation
>> (http://lxr.linux.no/linux+v2.6.34/fs/block_dev.c#L420).  The barrier
>> operation is also supported on MD and LVM now as well if you happen to have a
>> journal on a multi-disk volume.
>>
>> Does this mean that if you have a new enough kernel, and a block device that
>> understands barriers, that you can safely leave the write cache enabled for
>> the journal device?  It seems that way to me, but I wanted to make sure that I
>> am not missing a more subtle issue related to how Ceph performs its
>> journaling.
>>      
> You're correct.  The only concern is that the data is safely on disk when
> the write returns, and it sounds like recent kernels issue the barriers to
> make that happen.

Great, thanks for the confirmation.

>   Depending on how recent that behavior is, we can
> probably either remove the warning entirely, or try to guess based on
> kernel version.
>    

It looks like this first appeared in 2.6.33 (for both single devices and 
md/lvm) as best I can tell.  Its too bad there's not a better way to 
detect the fsync semantics from user space.  I don't know of any way 
other than by checking the kernel version.  It is actually an even 
tougher issue if an app wants to figure that out for an arbitrary file, 
because in that case it depends on the file system and the mount options 
as well.  In some ways it would be nice to have a "tell me what fsync 
semantic this file descriptor supports" ioctl :-)

-Phil
