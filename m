From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: Kernel panic on CephFS kernel client when setting file ACL
Date: Wed, 19 Apr 2017 11:29:43 +0800
Message-ID: <5B1D0266-AE2B-4C39-8A2D-152DF9609D68@redhat.com>
References: <CAKQB+ftVKZCc-HYyCyn8X8rS6GSm89kdE7nXU1TswBUB25zrGg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759234AbdDSD3x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 23:29:53 -0400
In-Reply-To: <CAKQB+ftVKZCc-HYyCyn8X8rS6GSm89kdE7nXU1TswBUB25zrGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerry Lee <leisurelysw24@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


> On 18 Apr 2017, at 19:33, Jerry Lee <leisurelysw24@gmail.com> wrote:
> 
> Hi,
> 
> With the following operations on a CephFS, a kernel panic can be
> triggered easily.  It seems that updating the file attribute via
> __ceph_setattr() in ceph_set_acl() might race with another
> ceph_setattr() operation which results in the file attribute bounces
> back and forward.  Under such condition, the call stack is overran and
> kernel crashes.  Is it right?  Thanks for any idea and feedback in
> advance.
> 
> environment:
> =========
> linux-4.8.4
> ceph version v11.0.2
> 
> commands:
> =========
> 1) mount -t ceph x.x.x.x:/ /mnt/cephfs -o name=admin,secret=xxxx
> 2) setfacl -b /mnt/cephfs/
>    setfacl -m u:0:rwx,g:0:rwx /mnt/cephfs/
>    setfacl -dm u:0:rwx,g:0:rwx /mnt/cephfs/
>    setfacl -b /mnt/cephfs/
> 
> call traces:
> ========
> <1>[344341.767823] BUG: unable to handle kernel paging request at
> fffffffb8a5707a8
> <1>[344341.767826] IP: [<ffffffff810aff73>] cpuacct_charge+0x23/0x40
> <4>[344341.767830] PGD 1f21067 PUD 0
> <0>[344341.767831] Thread overran stack, or stack corrupted
> <4>[344341.767832] Oops: 0000 [#1] SMP
> <4>[344341.767872] Call Trace:
> <4>[344341.767875]  [<ffffffff810a1add>] update_curr+0xcd/0x130
> <4>[344341.767876]  [<ffffffff810a35ed>] enqueue_entity+0x3d/0xb40
> <4>[344341.767878]  [<ffffffff810a4153>] enqueue_task_fair+0x63/0x7d0
> <4>[344341.767879]  [<ffffffff8109f4b4>] ? sched_clock_cpu+0x94/0xa0
> <4>[344341.767881]  [<ffffffff8109657e>] enqueue_task+0x2e/0x70
> <4>[344341.767883]  [<ffffffff81099b2b>] activate_task+0x2b/0x30
> <4>[344341.767884]  [<ffffffff81099e03>]
> ttwu_do_activate.constprop.108+0x33/0x70
> <4>[344341.767886]  [<ffffffff8109a74d>] try_to_wake_up+0x22d/0x2f0
> <4>[344341.767887]  [<ffffffff8109a837>] wake_up_process+0x27/0x50
> <4>[344341.767891]  [<ffffffff81b40975>] ? _cond_resched+0x5/0x30
> <4>[344341.767894]  [<ffffffff81088a24>] wake_up_worker+0x24/0x30
> <4>[344341.767895]  [<ffffffff8108a93e>] insert_work+0x6e/0xb0
> <4>[344341.767896]  [<ffffffff81b40975>] ? _cond_resched+0x5/0x30
> <4>[344341.767899]  [<ffffffff8117fb4b>] ? kmem_cache_alloc+0x55b/0x690
> <4>[344341.767900]  [<ffffffff8108aaae>] __queue_work+0x12e/0x2f0
> <4>[344341.767902]  [<ffffffff8108b21e>] __queue_delayed_work+0x8e/0x140
> <4>[344341.767903]  [<ffffffff8108b2ed>] queue_delayed_work_on+0x1d/0x30
> <4>[344341.767907]  [<ffffffffa08e266e>] queue_con_delay+0x3e/0xf0 [libceph]
> <4>[344341.767909]  [<ffffffffa08e3c2a>] ceph_con_send+0xfa/0x1f0 [libceph]
> <4>[344341.767912]  [<ffffffffa0940360>] __do_request+0x200/0x2f0 [ceph]
> <4>[344341.767914]  [<ffffffffa094159d>] ceph_mdsc_do_request+0x9d/0x2a0 [ceph]
> <4>[344341.767916]  [<ffffffffa0925888>] __ceph_do_getattr+0xa8/0x1c0 [ceph]
> <4>[344341.767919]  [<ffffffffa093bd56>] __ceph_getxattr+0xa6/0x190 [ceph]
> <4>[344341.767921]  [<ffffffffa094657c>] ceph_get_acl+0x4c/0x150 [ceph]
> <4>[344341.767923]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767925]  [<ffffffff811efbb4>] get_acl+0x44/0x60
> <4>[344341.767926]  [<ffffffff811eff00>] posix_acl_chmod+0x40/0xd0
> <4>[344341.767928]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767929]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767931]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767934]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767935]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767936]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767938]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767940]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767941]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767942]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767944]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767945]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767947]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767949]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767950]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767951]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767953]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767954]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767956]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767957]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767958]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767961]  [<ffffffff811ef741>] ? posix_acl_alloc+0x21/0x40
> <4>[344341.767962]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767964]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767965]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767966]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767968]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767970]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767971]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767973]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767974]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767975]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767977]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767979]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767980]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767981]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767983]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767984]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767986]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767987]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767988]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767990]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767991]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.767993]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.767995]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.767996]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.767997]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.767999]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768000]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768002]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768003]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768004]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768006]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768008]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768009]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768010]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768012]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768013]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768015]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768016]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768017]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768019]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768020]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768022]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768024]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768025]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768026]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768028]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768029]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768031]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768032]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768033]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768035]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768037]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768038]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768039]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768041]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768042]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768044]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768045]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768046]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768048]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768049]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768051]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768052]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768053]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768055]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768056]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768058]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768059]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768060]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768062]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768063]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768065]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768067]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768068]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768069]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768071]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768072]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768074]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768075]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768076]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768078]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768079]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768081]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768082]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768083]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768085]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768087]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768088]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768089]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768090]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768092]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768094]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768095]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768096]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768098]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768099]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768101]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768102]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768103]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768105]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768106]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768108]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768109]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768110]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768112]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768114]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768115]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768117]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768118]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768119]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768121]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768122]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768124]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768125]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768126]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768128]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768130]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768131]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768132]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768133]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768135]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768137]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768138]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768139]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768141]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768142]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768144]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768145]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768147]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768149]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768151]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768163]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768164]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768165]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768167]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768169]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768170]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768172]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768173]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768174]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768176]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768178]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768189]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768190]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768192]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768193]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768195]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768196]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768197]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768199]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768201]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768202]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768204]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768205]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768206]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768208]  [<ffffffff81b43e95>] ? _raw_spin_lock+0x5/0x30
> <4>[344341.768210]  [<ffffffffa0946789>] ceph_set_acl+0x109/0x250 [ceph]
> <4>[344341.768211]  [<ffffffff810c8fca>] ? kfree_call_rcu+0x1a/0x20
> <4>[344341.768212]  [<ffffffff811eff62>] posix_acl_chmod+0xa2/0xd0
> <4>[344341.768214]  [<ffffffffa0925228>] ceph_setattr+0x3a8/0x960 [ceph]
> <4>[344341.768215]  [<ffffffff8119bbbb>] ? putname+0x5b/0x60
> <4>[344341.768217]  [<ffffffff811aeb31>] notify_change+0x1e1/0x340
> <4>[344341.768219]  [<ffffffff8118d723>] chmod_common+0xb3/0x130
> <4>[344341.768221]  [<ffffffff8118e96a>] SyS_chmod+0x4a/0xb0
> <4>[344341.768223]  [<ffffffff81b441d7>] entry_SYSCALL_64_fastpath+0x12/0x6a
> <4>[344341.768223] Code: 0f 1f 84 00 00 00 00 00 e8 bb 66 a9 00 48 8b
> 47 08 55 48 89 e5 48 63 48 10 48 8b 87 a0 06 00 00 48 8b 50 60 48 8b
> 82 b0 00 00 00 <48> 03 04 cd c0 30 06 82 48 01 30 48 8b 52 48 48 85 d2
> 75 e5 5d
> <1>[344341.768236] RIP  [<ffffffff810aff73>] cpuacct_charge+0x23/0x40
> <4>[344341.768237]  RSP <ffff88041db38008>
> <4>[344341.768238] CR2: fffffffb8a5707a8
> <4>[344341.768239] ---[ end trace 6c9d7c6b7c9430e7 ]---
> <1>[344342.248810] BUG: unable to handle kernel paging request at
> fffffffffffffff6
> <1>[344342.248812] IP: [<ffffffff8108e4de>] find_pid_ns+0x5e/0x80
> <4>[344342.248817] PGD 1f21067 PUD 1f23067 PMD 0
> <4>[344342.248818] Oops: 0000 [#2] SMP

Thank you for reporting this. I opened ticket http://tracker.ceph.com/issues/19688 and proposed a fix

Yan, Zheng