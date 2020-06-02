From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [ceph-client:testing 9/30] include/linux/spinlock.h:353:9:
 sparse: sparse: context imbalance in 'ceph_handle_caps' - unexpected unlock
Date: Tue, 02 Jun 2020 09:51:32 -0400
Message-ID: <c66e1eb422662fabc10afed7d175f65067fec1c1.camel@kernel.org>
References: <202006021202.ox5WWela%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBNve (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:51:34 -0400
In-Reply-To: <202006021202.ox5WWela%lkp@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>

On Tue, 2020-06-02 at 12:38 +0800, kbuild test robot wrote:
> tree:   https://github.com/ceph/ceph-client.git testing
> head:   9c4e2af200ffe80d2f917b75f92ab57f0a091a17
> commit: 7833323363233c75fd8d10b5ceefbb9515cb3e32 [9/30] ceph: don't take i_ceph_lock in handle_cap_import
> config: microblaze-randconfig-s031-20200602 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-243-gc100a7ab-dirty
>         git checkout 7833323363233c75fd8d10b5ceefbb9515cb3e32
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=microblaze CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    fs/ceph/caps.c:3443:9: sparse: sparse: context imbalance in 'handle_cap_grant' - wrong count at exit
> > > include/linux/spinlock.h:353:9: sparse: sparse: context imbalance in 'ceph_handle_caps' - unexpected unlock
> 
> vim +/ceph_handle_caps +353 include/linux/spinlock.h
> 
> de8f5e4f2dc1f0 Peter Zijlstra  2020-03-21  350  
> 3490565b633c70 Denys Vlasenko  2015-07-13  351  static __always_inline void spin_lock(spinlock_t *lock)
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  352  {
> c2f21ce2e31286 Thomas Gleixner 2009-12-02 @353  	raw_spin_lock(&lock->rlock);
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  354  }
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  355  
> 
> :::::: The code at line 353 was first introduced by commit
> :::::: c2f21ce2e31286a0a32f8da0a7856e9ca1122ef3 locking: Implement new raw_spinlock
> 
> :::::: TO: Thomas Gleixner <tglx@linutronix.de>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

I think this is a false-positive, but I'd welcome someone else to sanity
check me here (Ilya?). My sparse says something a little different:

    fs/ceph/caps.c:4052:26: warning: context imbalance in 'ceph_handle_caps' - unexpected unlock

...and I get a similar warning when I move to the commit ahead of
7833323363233c as well.

All that patch does is push the i_ceph_lock acquisition from
handle_cap_import to ceph_handle_caps. I don't see how it would have
introduced a locking imbalance, but the locking in this code really is
quite confusing, so please do point it out if I'm wrong here.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
