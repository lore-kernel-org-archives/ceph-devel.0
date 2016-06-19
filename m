From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Dramatic performance drop at certain number of objects in pool
Date: Mon, 20 Jun 2016 09:21:27 +1000
Message-ID: <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35757 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbcFSXVs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jun 2016 19:21:48 -0400
Received: by mail-vk0-f41.google.com with SMTP id j2so176211667vkg.2
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jun 2016 16:21:48 -0700 (PDT)
In-Reply-To: <1450235390.2134.1466084299677@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Wade Holler <wade.holler@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Wade,

(Apologies for the slowness - AFK for the weekend).

On 16 June 2016 at 23:38, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 16 juni 2016 om 14:14 schreef Wade Holler <wade.holler@gmail.com>:
>>
>>
>> Hi All,
>>
>> I have a repeatable condition when the object count in a pool gets to
>> 320-330 million the object write time dramatically and almost
>> instantly increases as much as 10X, exhibited by fs_apply_latency
>> going from 10ms to 100s of ms.
>>r filestore
>
> My first guess is the filestore splitting and the amount of files per directory.

I concur with Wido and suggest you try upping your filestore split and
merge threshold config values.

I've seen this issue a number of times now with write heavy workload,
and would love to at least write some docs about it, because it must
happen to a lot of users running RBD workloads on largish drives.
However, I'm not sure how to definitively diagnose the issue and
pinpoint the problem. The gist of the issue is the number of files
and/or directories on your OSD filesystems, at some system dependent
threshold you get to a point where you can no longer sufficiently
cache inodes and/or dentrys, so IOs on those files(ystems) have to
incur extra disk IOPS to read the filesystem structure from disk (I
believe that's the small read IO you're seeing, and unfortunately it
seems to effectively choke writes - we've seen all sorts of related
slow request issues). If you watch your xfs stats you'll likely get
further confirmation. In my experience xs_dir_lookups balloons (which
means directory lookups are missing cache and going to disk).

What I'm not clear on is whether there are two different pathologies
at play here, i.e., specifically dentry cache issues versus inode
cache issues. In the former case making Ceph's directory structure
shallower with more files per directory may help (or perhaps
increasing the number of PGs - more top-level directories), but in the
latter case you're likely to need various system tuning (lower vfs
cache pressure, more memory?, fewer files (larger object size))
depending on your workload.

-- 
Cheers,
~Blairo
