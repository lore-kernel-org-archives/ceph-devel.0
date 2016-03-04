From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Re: [ceph-fuse] fuse fails to invalidate dentry when ceph-fuse mounts
 sub directory as root_directory
Date: Fri, 4 Mar 2016 10:40:32 +0800
Message-ID: <CAGkCoN+-18-ub5bcNBZAiVN=YaUJEctqpVuLp5C1UKHfHadmQw@mail.gmail.com>
References: <CAGkCoNKm+XeUGnfTT7QfC7OfMyEqhT8xSeRirJFeeNyvGivebQ@mail.gmail.com>
 <CAAM7YAmh8y5U6kDaAs-N=PNXGGm54Yj5aN=8yyUHrjauNi6UOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33699 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbcCDClN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2016 21:41:13 -0500
Received: by mail-wm0-f46.google.com with SMTP id l68so2521381wml.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Mar 2016 18:41:12 -0800 (PST)
In-Reply-To: <CAAM7YAmh8y5U6kDaAs-N=PNXGGm54Yj5aN=8yyUHrjauNi6UOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com


On Thu, Mar 3, 2016 at 8:16 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Mon, Feb 29, 2016 at 4:13 PM, Zhi Zhang <zhang.david2011@gmail.com> wrote:
>> Hi cepher,
>>
>> Steps to reproduce this issue:
>> 1. reduce mds_cache_size to 200 for quick verification
>> 2. mount sub directory as root_directory, e.g, ceph-fuse -r /zhi_test
>> /mnt/cephfs
>> 3. create a new sub directory under /mnt/cephfs, e.g, /mnt/cephfs/sub_dir
>> 4. write more than 200 files into /mnt/cephfs/sub_dir/ directory
>> 5. client should start to trim_caps, but caps are not released.
>>
>> ceph version: 0.94.1 with some backports
>> fuse version: both 2.8.3 or 2.9.2
>>
>> By further looking at the codes, ceph-fuse wants fuse to invalidate
>> some dentries by calling Client::_async_dentry_invalidate, which will
>> call dentry_invalidate_cb in fuse_ll.cc and fuse's API
>> fuse_lowlevel_notify_delete.
>>
>> Within these calls, the parent's inode (dirino) is our mount point's
>> inode (zhi_test), NOT the original default root inode ("/"), the child
>> inode may be a fake inode or sub directory's inode (sub_dir).
>>
>> However, fuse's API fuse_lowlevel_notify_delete returns -2, so no
>> ll_forget will be called on those files under sub_dir and those caps
>> are not released. MDS will report failing to respond to cache
>> pressure.
>>
>> We have changed the parent's inode to the original default root inode
>> ("/") in Client::_async_dentry_invalidate, but no changes on child
>> inode. After this, fuse can invalidate child dentry (sub_dir)
>> successfully and ll_forget will be called on those files under
>> sub_dir.
>>
>> I didn't find much information from the fuse's doc
>> https://fossies.org/dox/fuse-2.9.5/fuse__lowlevel_8h.html#a94893b3eb83fe2a218e80e43089670a1.
>> But it looks like fuse looking for the child from the head of the
>> tree, can't from an intermediate node? otherwise is it a bug from ceph
>> side?
>
> Using fuse_lowlevel_notify_delete() to invalidate dentry no longer
> works for 3.18+ kernel.  See http://tracker.ceph.com/issues/9997 for
> detail
>

I am using centos-7 whose kernel is 3.10.x. I also tried to set
client_try_dentry_invalidate as false to force use remount to
invalidate dentry. It works but performance degrades.

fuse_lowlevel_notify_delete() works on kernel 3.10.x. What I found is
that the second args (fuse_ino_t parent) of this function should be
the ceph-fuse's root inode number ("/"), can't be others.


> Regards
> Yan, Zheng
>
>
>> Thanks.
>>
>> Regards,
>> Zhi Zhang (David)
>> Contact: zhang.david2011@gmail.com
>>               zhangz.david@outlook.com
