From: Gregory Farnum <greg@inktank.com>
Subject: Re: WriteBack Throttle kill the performace of the disk
Date: Mon, 13 Oct 2014 12:50:59 -0700
Message-ID: <CAPYLRzh5vrv2e2QPe=Cf9FgVbhSWn5wgWs_SCGLOmvhQsnda3A@mail.gmail.com>
References: <CALZt5jzUduePJzgH+-NJ=7WckxioCbUZvxvnCFM8VBxHxXt4dg@mail.gmail.com>
	<543BD3B9.2000600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55703 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaJMTvA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 15:51:00 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so5538843qcw.17
        for <ceph-devel@vger.kernel.org>; Mon, 13 Oct 2014 12:51:00 -0700 (PDT)
In-Reply-To: <543BD3B9.2000600@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Nicheal <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 13, 2014 at 6:29 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 10/13/2014 05:18 AM, Nicheal wrote:
>>
>> Hi,
>>
>> I'm currently finding that enable WritebackThrottle lead to lower IOPS
>> for large number of small io. Since WritebackThrottle calls
>> fdatasync(fd) to flush an object content to disk, large number of
>> ramdom small io always cause the WritebackThrottle to submit one or
>> two 4k io every time.
>> Thus, it is much slower than the global sync in
>> FileStore::sync_entry().  Note:: here, I use xfs as the FileStore
>> underlying filesystem. So I would know that if any impact when I
>> disable Writeback throttles. I cannot catch the idea on the website
>> (http://ceph.com/docs/master/dev/osd_internals/wbthrottle/).
>> Large number of inode will cause longer time to sync, but submitting a
>> batch of write to disk always faster than submitting few io update to
>> the disk.
>
>
> Hi Nichael,
>
> When the wbthrottle code was introduced back around dumpling we had to
> increase the sync intervals quite a bit to get it performing similarly to
> cuttlefish.  Have you tried playing with the various wbthrottle xfs
> tuneables to see if you can improve the behaviour?
>
> OPTION(filestore_wbthrottle_enable, OPT_BOOL, true)
> OPTION(filestore_wbthrottle_xfs_bytes_start_flusher, OPT_U64, 41943040)
> OPTION(filestore_wbthrottle_xfs_bytes_hard_limit, OPT_U64, 419430400)
> OPTION(filestore_wbthrottle_xfs_ios_start_flusher, OPT_U64, 500)
> OPTION(filestore_wbthrottle_xfs_ios_hard_limit, OPT_U64, 5000)
> OPTION(filestore_wbthrottle_xfs_inodes_start_flusher, OPT_U64, 500)

In particular, these are semi-tuned for a standard spinning hard
drive. If you have an SSD as your backing store, you'll want to put
them all way up.
Alternatively, if you have a very large journal, you will see the
flusher as slowing down shorter benchmarks, because it's trying to
keep the journal from getting too far ahead of the backing store. But
this is deliberate; it's making you pay a closer approximation to the
true cost up front instead of letting you overload the system and then
have all your writes get very slow as syncfs calls start taking tens
of seconds.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
