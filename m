From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: ceph osd memory free problem
Date: Tue, 13 Jun 2017 05:37:28 +0000
Message-ID: <20170613053728.GJ23586@orbis-terrarum.net>
References: <CAE5T3Nw4Ok6xcpWgOsRCj+NC5AiswUGShQmXRzxrJ_cNSPgCHw@mail.gmail.com>
 <robbat2-20170612T060139-811827739Z@orbis-terrarum.net>
 <CAE5T3Nx+Tt54BLJfzCEigu9dQkgYWpo8=7Rab74LCXfuT3ozZg@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49356 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdFMFh3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Jun 2017 01:37:29 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id E52953419C4
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 05:37:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAE5T3Nx+Tt54BLJfzCEigu9dQkgYWpo8=7Rab74LCXfuT3ozZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5LqO55u45rSL?= <penglaiyxy@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 12, 2017 at 02:37:48PM +0800, 于相洋 wrote:
> Appreciate to receive you reply, Robin Hugh.
> I have also try to adjust the vm configuration before ,but get no effect.
> 
> Now I will accept your method to do "echo 2 "> drop_caches
That's strictly a workaround.

The OTHER way we can recover memory is to stop the OSD process for a
given filesystem, umount the filesystem, (not just remount), mount it
again and restart the OSD process.

Can you share some of your OOM messages, and we can try and confirm if
it's the same issue? Also possibly fixed in much newer kernels, but I think
BlueStore is going to make the bug irrelevant as well by avoiding XFS systems
with lots of inodes.

In our case, each XFS filesystem has ~6M inodes (over ~52k directories), and
this hugely impacts slab.

From "slabtop -s c", to sort by size:
  OBJS   ACTIVE    USE OBJ-SIZE  SLABS OBJ/SLAB CACHE-SIZE NAME                   
 4017576  1872371  46%    2.00K 251186       16   8037952K kmalloc-2048
19057016 17725140  93%    0.38K 455004       42   7280064K mnt_cache
 4952967  2288054  46%    1.06K 167276       30   5352832K xfs_inode
 5346579  2380752  44%    0.57K 191958       28   3071328K radix_tree_node
 6701565  6694510  99%    0.10K 171835       39    687340K buffer_head
 7478016  2597615  34%    0.06K 116844       64    467376K kmalloc-64
  832624   256901  30%    0.50K  26021       32    416336K kmalloc-512
   71220    68291  95%    3.50K   7916        9    253312K task_struct
  238380   104089  43%    1.00K   7487       32    239584K kmalloc-1024
  896658   612456  68%    0.19K  21349       42    170792K dentry
  121930   116536  95%    0.61K   3616       52    115712K proc_inode_cache


-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
