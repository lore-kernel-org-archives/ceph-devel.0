From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCHv2] cephfs: Fix scheduler warning due to nested blocking
Date: Wed, 12 Oct 2016 11:05:13 +0800
Message-ID: <C4874357-49D7-4111-A74A-199693664968@redhat.com>
References: <1476176649-13393-1-git-send-email-kernel@kyup.com>
 <1476177371-13652-1-git-send-email-kernel@kyup.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbcJLDHC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Oct 2016 23:07:02 -0400
In-Reply-To: <1476177371-13652-1-git-send-email-kernel@kyup.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nikolay Borisov <kernel@kyup.com>
Cc: idryomov@gmail.com, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org


> On 11 Oct 2016, at 17:16, Nikolay Borisov <kernel@kyup.com> wrote:
> 
> try_get_cap_refs can be used as a condition in a wait_event* calls.
> This is all fine until it has to call __ceph_do_pending_vmtruncate,
> which in turn acquires the i_truncate_mutex. This leads to a situation
> in which a task's state is !TASK_RUNNING and at the same time it's
> trying to acquire a sleeping primitive. In essence a nested sleeping
> primitives are being used. This causes the following warning:
> 
> WARNING: CPU: 22 PID: 11064 at kernel/sched/core.c:7631 __might_sleep+0x9f/0xb0()
> do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff8109447d>] prepare_to_wait_event+0x5d/0x110
> ipmi_msghandler tcp_scalable ib_qib dca ib_mad ib_core ib_addr ipv6
> CPU: 22 PID: 11064 Comm: fs_checker.pl Tainted: G           O    4.4.20-clouder2 #6
> Hardware name: Supermicro X10DRi/X10DRi, BIOS 1.1a 10/16/2015
> 0000000000000000 ffff8838b416fa88 ffffffff812f4409 ffff8838b416fad0
> ffffffff81a034f2 ffff8838b416fac0 ffffffff81052b46 ffffffff81a0432c
> 0000000000000061 0000000000000000 0000000000000000 ffff88167bda54a0
> Call Trace:
> [<ffffffff812f4409>] dump_stack+0x67/0x9e
> [<ffffffff81052b46>] warn_slowpath_common+0x86/0xc0
> [<ffffffff81052bcc>] warn_slowpath_fmt+0x4c/0x50
> [<ffffffff8109447d>] ? prepare_to_wait_event+0x5d/0x110
> [<ffffffff8109447d>] ? prepare_to_wait_event+0x5d/0x110
> [<ffffffff8107767f>] __might_sleep+0x9f/0xb0
> [<ffffffff81612d30>] mutex_lock+0x20/0x40
> [<ffffffffa04eea14>] __ceph_do_pending_vmtruncate+0x44/0x1a0 [ceph]
> [<ffffffffa04fa692>] try_get_cap_refs+0xa2/0x320 [ceph]
> [<ffffffffa04fd6f5>] ceph_get_caps+0x255/0x2b0 [ceph]
> [<ffffffff81094370>] ? wait_woken+0xb0/0xb0
> [<ffffffffa04f2c11>] ceph_write_iter+0x2b1/0xde0 [ceph]
> [<ffffffff81613f22>] ? schedule_timeout+0x202/0x260
> [<ffffffff8117f01a>] ? kmem_cache_free+0x1ea/0x200
> [<ffffffff811b46ce>] ? iput+0x9e/0x230
> [<ffffffff81077632>] ? __might_sleep+0x52/0xb0
> [<ffffffff81156147>] ? __might_fault+0x37/0x40
> [<ffffffff8119e123>] ? cp_new_stat+0x153/0x170
> [<ffffffff81198cfa>] __vfs_write+0xaa/0xe0
> [<ffffffff81199369>] vfs_write+0xa9/0x190
> [<ffffffff811b6d01>] ? set_close_on_exec+0x31/0x70
> [<ffffffff8119a056>] SyS_write+0x46/0xa0
> 
> This happens since wait_event_interruptible can interfere with the
> mutex locking code, since they both fiddle with the task state.
> 
> Fix the issue by using the newly-added nested blocking infrastructure
> in 61ada528dea0 ("sched/wait: Provide infrastructure to deal with
> nested blocking")
> 
> Link: https://lwn.net/Articles/628628/
> Signed-off-by: Nikolay Borisov <kernel@kyup.com>
> ---
> fs/ceph/caps.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index c69e1253b47b..9d401520b981 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2467,6 +2467,7 @@ int ceph_get_caps(struct ceph_inode_info *ci, int need, int want,
> 		  loff_t endoff, int *got, struct page **pinned_page)
> {
> 	int _got, ret, err = 0;
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> 
> 	ret = ceph_pool_perm_check(ci, need);
> 	if (ret < 0)
> @@ -2486,9 +2487,14 @@ int ceph_get_caps(struct ceph_inode_info *ci, int need, int want,
> 			if (err < 0)
> 				return err;
> 		} else {
> -			ret = wait_event_interruptible(ci->i_cap_wq,
> -					try_get_cap_refs(ci, need, want, endoff,
> -							 true, &_got, &err));
> +			add_wait_queue(&ci->i_cap_wq, &wait);
> +
> +			while (!try_get_cap_refs(ci, need, want, endoff,
> +                                                         true, &_got, &err))
> +				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> +
> +			remove_wait_queue(&ci->i_cap_wq, &wait);
> +
> 			if (err == -EAGAIN)
> 				continue;
> 			if (err < 0)
> -- 
> 2.5.0
> 

Applied, thanks

Yan, Zheng


