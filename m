From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [ceph-fuse] fuse fails to invalidate dentry when ceph-fuse mounts
 sub directory as root_directory
Date: Thu, 10 Mar 2016 01:22:24 -0800
Message-ID: <CAJ4mKGa_Jws1o4U2N9XTLcfAqok0CtXhAP5+ViapBps9DGKyiQ@mail.gmail.com>
References: <CAGkCoNKm+XeUGnfTT7QfC7OfMyEqhT8xSeRirJFeeNyvGivebQ@mail.gmail.com>
	<CAAM7YAmN1t7zA1w1bph5EkT7h_bAO07fDk5wCarLUp4L4UZ97g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34144 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227AbcCJJWZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 04:22:25 -0500
Received: by mail-vk0-f41.google.com with SMTP id e185so88298919vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 01:22:24 -0800 (PST)
In-Reply-To: <CAAM7YAmN1t7zA1w1bph5EkT7h_bAO07fDk5wCarLUp4L4UZ97g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <ukernel@gmail.com>

On Tue, Mar 8, 2016 at 1:06 AM, Yan, Zheng <ukernel@gmail.com> wrote:
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
> It's a bug in ceph-fuse. Fuse always uses 1 as root inode number. To
> invalidate dentries in root directory, the parent's inode number
> should be set to 1.

For those following along at home, the tracker ticket for this is
http://tracker.ceph.com/issues/15008, and the PR is at
https://github.com/ceph/ceph/pull/7976.
-Greg
