From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: why ZFS on ceph is unstable?
Date: Fri, 19 Sep 2014 10:50:18 -0500
Message-ID: <541C50BA.2010400@redhat.com>
References: <CALZt5jz12FAoSY0B65CohTf10hO9b9929_tKdx_NpZEajpQ75g@mail.gmail.com> <8D1A2373558873D-1014-A645@webmail-vm039.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:39738 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbaISPuO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 11:50:14 -0400
Received: by mail-ig0-f170.google.com with SMTP id a13so1138745igq.5
        for <ceph-devel@vger.kernel.org>; Fri, 19 Sep 2014 08:50:13 -0700 (PDT)
In-Reply-To: <8D1A2373558873D-1014-A645@webmail-vm039.sysops.aol.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric0e@aol.com>, zay11022@gmail.com, ceph-devel@vger.kernel.org

On 09/19/2014 10:40 AM, Eric Eastman wrote:
>>  Hi developers,it mentioned in the source code that
>
> OPTION(filestore_zfs_snap,OPT_BOOL, false) // zfsonlinux is still
> unstable.
>
>>  So if we turn on filestore_zfs_snap and neglect journal like btrf,
>
> it will be unstable?As is mentioned on the "zfs on linux community",
>
>>  It is stable enough to run a ZFS root filesystem on a GNU/Linux
>
> installation for yourworkstation as something to play around with.
>
>> It is copy-on-write,supports compression, deduplication, file
>
> atomicity, off-disk caching,(encryption not support), and much more.
>
>>  So it seems that allfeatures are supported except for
>
> encryption.Thus, I am puzzled that the unstable, you mean, is
>
>> ZFS unstableitself. Or it now is already stable on linux, but still
>
> unstable when used as ceph FileStore filesystem.If so,
>
>> what will happen if we use it, losing data or frequent crash?
>
>
>
> In testing I did last year, there were multiple issues with using ZFS
> for my OSD backend, that would lock up the ZFS file systems, and take
> the OSD down.
>
> Several of these have been fixed by the ZFS team. See:
>
>
>
> https://github.com/zfsonlinux/zfs/issues/1891
>
> https://github.com/zfsonlinux/zfs/issues/1961
>
> https://github.com/zfsonlinux/zfs/issues/2015
>
>
>
> The recommendation is to use xattr=sa, but looking at the current open
> issues for ZFS, there seems to still be issues with this option.  See:
>
>
>
> https://github.com/zfsonlinux/zfs/issues/2700
>
> https://github.com/zfsonlinux/zfs/issues/2717
>
> https://github.com/zfsonlinux/zfs/issues/2663
>
> and others

SA xattrs are pretty important from a performance perspective for Ceph 
on ZFS based on some testing I did a while back with Brian Behlendorf.

>
>
>
> Also per the recent ZFS posting on clusterhq, aio will not be supported
> until 0.64 so the following needs to be added to your ceph.conf file
>
>
>
>       filestore zfs_snap = 1
>
>       journal aio = 0
>
>       journal dio = 0
>
>
>
> My plans are to retest ZFS as an OSD backend once ZFS version 0.64 has
> been released.
>
>
>
> Please test ZFS with Ceph, and submit bugs, as this is how it will get
> stable enough to use in production.
>
>
>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

