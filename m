From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: BUG: ceph_inode_cachep and ceph_dentry_cachep caches are not
 clean when destroying
Date: Wed, 19 Feb 2020 11:53:56 +0100
Message-ID: <CAOi1vP8b1aCph3NkAENEtAKfPDa8J03cNxwOZ+KSn1-te=6g0w@mail.gmail.com>
References: <23e2b9a7-5ff6-1f07-ff03-08abcbf1457f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f50.google.com ([209.85.166.50]:37059 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBSKxa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Feb 2020 05:53:30 -0500
Received: by mail-io1-f50.google.com with SMTP id k24so61961ioc.4
        for <ceph-devel@vger.kernel.org>; Wed, 19 Feb 2020 02:53:29 -0800 (PST)
In-Reply-To: <23e2b9a7-5ff6-1f07-ff03-08abcbf1457f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 19, 2020 at 10:39 AM Xiubo Li <xiubli@redhat.com> wrote:
>
> Hi Jeff, Ilya and all
>
> I hit this call traces by running some test cases when unmounting the fs
> mount points.
>
> It seems there still have some inodes or dentries are not destroyed.
>
> Will this be a problem ? Any idea ?

Hi Xiubo,

Of course it is a problem ;)

These are all in ceph_inode_info and ceph_dentry_info caches, but
I see traces of rbd mappings as well.  Could you please share your
test cases?  How are you unloading modules?

Thanks,

                Ilya
