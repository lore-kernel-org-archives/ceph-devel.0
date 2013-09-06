From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [next:master 3628/3827] include/linux/ceph/ceph_debug.h:4:0:
 warning: "pr_fmt" redefined
Date: Fri, 6 Sep 2013 11:02:08 -0400
Message-ID: <CANP1eJEMxsX7UtBTrE1wxTN1OTOCrcntH5gcCO4BtbYjqptb=Q@mail.gmail.com>
References: <522994e2.0osx2YtC5R+dhrq7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:55002 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3IFPCK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 11:02:10 -0400
Received: by mail-we0-f175.google.com with SMTP id q59so3126545wes.34
        for <ceph-devel@vger.kernel.org>; Fri, 06 Sep 2013 08:02:08 -0700 (PDT)
In-Reply-To: <522994e2.0osx2YtC5R+dhrq7%fengguang.wu@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Sage Weil <sage@inktank.com>, kbuild-all@01.org, ceph-devel <ceph-devel@vger.kernel.org>

I'm looking into this warning now.

On Fri, Sep 6, 2013 at 4:40 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   1a4082f8c32a7f27ecb2f803c7324bf47ab07280
> commit: cb0963fcf836232447e11f42ded9733612e4c63f [3628/3827] ceph: use fscache as a local presisent cache
> config: make ARCH=x86_64 allmodconfig
>
> All warnings:
>
>    In file included from fs/ceph/super.h:4:0,
>                     from fs/ceph/cache.c:26:
>>> include/linux/ceph/ceph_debug.h:4:0: warning: "pr_fmt" redefined [enabled by default]
>     #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>     ^
>    In file included from include/linux/kernel.h:13:0,
>                     from include/asm-generic/bug.h:13,
>                     from arch/x86/include/asm/bug.h:38,
>                     from include/linux/bug.h:4,
>                     from include/linux/thread_info.h:11,
>                     from include/linux/preempt.h:9,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/wait.h:7,
>                     from include/linux/fs.h:6,
>                     from include/linux/fscache.h:21,
>                     from fs/ceph/cache.c:24:
>    include/linux/printk.h:206:0: note: this is the location of the previous definition
>     #define pr_fmt(fmt) fmt
>     ^
>
> vim +/pr_fmt +4 include/linux/ceph/ceph_debug.h
>
>      1  #ifndef _FS_CEPH_DEBUG_H
>      2  #define _FS_CEPH_DEBUG_H
>      3
>    > 4  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>      5
>      6  #ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
>      7
>      8  /*
>      9   * wrap pr_debug to include a filename:lineno prefix on each line.
>     10   * this incurs some overhead (kernel size and execution time) due to
>     11   * the extra function call at each call site.
>     12   */
>
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
