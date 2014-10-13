From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: WriteBack Throttle kill the performace of the disk
Date: Mon, 13 Oct 2014 08:29:29 -0500
Message-ID: <543BD3B9.2000600@redhat.com>
References: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:50957 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbaJMN3d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 09:29:33 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so10389510igb.8
        for <ceph-devel@vger.kernel.org>; Mon, 13 Oct 2014 06:29:32 -0700 (PDT)
In-Reply-To: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/13/2014 05:18 AM, Nicheal wrote:
> Hi,
>
> I'm currently finding that enable WritebackThrottle lead to lower IOPS
> for large number of small io. Since WritebackThrottle calls
> fdatasync(fd) to flush an object content to disk, large number of
> ramdom small io always cause the WritebackThrottle to submit one or
> two 4k io every time.
> Thus, it is much slower than the global sync in
> FileStore::sync_entry().  Note:: here, I use xfs as the FileStore
> underlying filesystem. So I would know that if any impact when I
> disable Writeback throttles. I cannot catch the idea on the website
> (http://ceph.com/docs/master/dev/osd_internals/wbthrottle/).
> Large number of inode will cause longer time to sync, but submitting a
> batch of write to disk always faster than submitting few io update to
> the disk.

Hi Nichael,

When the wbthrottle code was introduced back around dumpling we had to 
increase the sync intervals quite a bit to get it performing similarly 
to cuttlefish.  Have you tried playing with the various wbthrottle xfs 
tuneables to see if you can improve the behaviour?

OPTION(filestore_wbthrottle_enable, OPT_BOOL, true)
OPTION(filestore_wbthrottle_xfs_bytes_start_flusher, OPT_U64, 41943040)
OPTION(filestore_wbthrottle_xfs_bytes_hard_limit, OPT_U64, 419430400)
OPTION(filestore_wbthrottle_xfs_ios_start_flusher, OPT_U64, 500)
OPTION(filestore_wbthrottle_xfs_ios_hard_limit, OPT_U64, 5000)
OPTION(filestore_wbthrottle_xfs_inodes_start_flusher, OPT_U64, 500)

Mark

>
> Nicheal
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

