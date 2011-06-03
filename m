From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: crash on umount
Date: Fri, 3 Jun 2011 08:39:05 -0700
Message-ID: <20110603153905.GA22186@dreamer>
References: <4DE8BA2C.6030309@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58183 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754913Ab1FCPjH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2011 11:39:07 -0400
Content-Disposition: inline
In-Reply-To: <4DE8BA2C.6030309@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 03, 2011 at 01:40:44PM +0300, Fyodor Ustinov wrote:
> Hi!
> 
> kernel 2.6.39
> ceph - 0.28.2
> 
> In sysctl.conf set
> vm.min_free_kbytes=262144
> 
> Jun  2 03:08:17 amanda kernel: [35398.757055] libceph: msg_new can't
> allocate 4096 bytes

... so first you run out of memory ...

> Jun  3 13:33:10 amanda kernel: [159291.960881] ------------[ cut
> here ]------------
> Jun  3 13:33:10 amanda kernel: [159291.960930] kernel BUG at
> mm/mempool.c:186!
...
> Jun  3 13:33:10 amanda kernel: [159291.970496] Call Trace:
> Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02a59e2>]
> ceph_msgpool_destroy+0x12/0x20 [libceph]
> Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02a7fc3>]
> ceph_osdc_stop+0x83/0xb0 [libceph]
> Jun  3 13:33:10 amanda kernel: [159291.970496]  [<ffffffffa02a158d>]
> ceph_destroy_client+0x1d/0x60 [libceph]

And then, the mempool destroy goes wrong. And that's because...

/**
 * mempool_destroy - deallocate a memory pool
 * @pool:      pointer to the memory pool which was allocated via
 *             mempool_create().
 *
 * this function only sleeps if the free_fn() function sleeps. The caller
 * has to guarantee that all elements have been returned to the pool (ie:
 * freed) prior to calling mempool_destroy().
 */
void mempool_destroy(mempool_t *pool)
{
	/* Check for outstanding elements */
	BUG_ON(pool->curr_nr != pool->min_nr);
	free_pool(pool);
}

We didn't empty the pool before trying to release it. It's either one
of these

	ceph_msgpool_destroy(&osdc->msgpool_op);
	ceph_msgpool_destroy(&osdc->msgpool_op_reply);

but I can't easily tell which one.

Summary so far: we're leaking msgpool_op or msgpool_op_reply entries
when unmounting kclient while out of memory.

devs: If anyone else has a good idea where this is heading, please
take over.

-- 
:(){ :|:&};:
