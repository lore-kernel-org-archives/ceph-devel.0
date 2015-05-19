From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: kernel BUG at .../fs/ceph/xattr.c:287!
Date: Tue, 19 May 2015 16:10:50 +0300
Message-ID: <CAOi1vP8kMTuteHfd-0kwmnouELRCB4prFOu8=aTKsDiLP5=iKw@mail.gmail.com>
References: <mjfatn$c1e$1@ger.gmane.org>
	<555B3185.8010304@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34361 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbESNKv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 09:10:51 -0400
Received: by wicmc15 with SMTP id mc15so116314597wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 06:10:50 -0700 (PDT)
In-Reply-To: <555B3185.8010304@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: CSa <salzmann@mi.fu-berlin.de>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 19, 2015 at 3:50 PM, Alex Elder <elder@ieee.org> wrote:
> On 05/19/2015 07:39 AM, CSa wrote:
>> Hi,
>>
>> we are encountering a bug in the cephfs client kernel module:
>>
>>
>> May 18 11:02:04 allegro kernel: [1020094.145209] ------------[ cut here
>> ]------------
>> May 18 11:02:04 allegro kernel: [1020094.149127] kernel BUG at /build/linux-
>> RGM_Ed/linux-3.16.7-ckt9/fs/ceph/xattr.c:287!
>> May 18 11:02:04 allegro kernel: [1020094.149127] invalid opcode: 0000 [#1]
>> SMP
>> [...]
>> May 18 11:02:04 allegro kernel: [1020094.149127] CPU: 2 PID: 1359 Comm: mv
>> Not tainted 3.16.0-4-amd64 #1 Debian 3.16.7-ckt9-3~deb8u1
>> [...]
>>
>> (see full log at http://paste.debian.net/180292)
>
> Based on a quick look at the code, I think this must be
> a use-after-free.
>
> The bug occurs if ceph_vxattrs_name_size() is given a non-NULL
> vxattrs pointer that is neither ceph_dir_vxattrs nor ceph_file_vxattrs.
> There is only one caller of ceph_vxattrs_name_size(), and it is
> passed a value that's a result of a call to ceph_inode_vxattrs().
> That function returns only three possible values: ceph_dir_vxattrs,
> ceph_file_vxattrs, or NULL.

Is there a symlink involved by any chance?  Probably fixed by
0abb43dcacb5 "ceph: fix llistxattr on symlink" in 3.18.

Thanks,

                Ilya
