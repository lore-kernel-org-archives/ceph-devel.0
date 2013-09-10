From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fscache: check consistency does not
	decrement refcount
Date: Tue, 10 Sep 2013 13:34:33 +0100
Message-ID: <16357.1378816473@warthog.procyon.org.uk>
References: <fd69f2052bc16d5a5de0104ca00ccc59478e3569.1378750714.git.milosz@adfin.com>
	<alpine.DEB.2.00.1309091042520.18214@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <fd69f2052bc16d5a5de0104ca00ccc59478e3569.1378750714.git.milosz@adfin.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Milosz Tanski <milosz@adfin.com>
Cc: sage@inktank.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Milosz Tanski <milosz@adfin.com> wrote:

> __fscache_check_consistency() does not decrement the count of operations
> active after it finishes in the success case. This leads to a hung tasks on
> cookie de-registration (commonly in inode eviction).
> 
> INFO: task kworker/1:2:4214 blocked for more than 120 seconds.
> kworker/1:2     D ffff880443513fc0     0  4214      2 0x00000000
> Workqueue: ceph-msgr con_work [libceph]
>   ...
> Call Trace:
>  [<ffffffff81569fc6>] ? _raw_spin_unlock_irqrestore+0x16/0x20
>  [<ffffffffa0016570>] ? fscache_wait_bit_interruptible+0x30/0x30 [fscache]
>  [<ffffffff81568d09>] schedule+0x29/0x70
>  [<ffffffffa001657e>] fscache_wait_atomic_t+0xe/0x20 [fscache]
>  [<ffffffff815665cf>] out_of_line_wait_on_atomic_t+0x9f/0xe0
>  [<ffffffff81083560>] ? autoremove_wake_function+0x40/0x40
>  [<ffffffffa0015a9c>] __fscache_relinquish_cookie+0x15c/0x310 [fscache]
>  [<ffffffffa00a4fae>] ceph_fscache_unregister_inode_cookie+0x3e/0x50 [ceph]
>  [<ffffffffa007e373>] ceph_destroy_inode+0x33/0x200 [ceph]
>  [<ffffffff811c13ae>] ? __fsnotify_inode_delete+0xe/0x10
>  [<ffffffff8119ba1c>] destroy_inode+0x3c/0x70
>  [<ffffffff8119bb69>] evict+0x119/0x1b0
> 
> Signed-off-by: Milosz Tanski <milosz@adfin.com>

Acked-by: David Howells <dhowells@redhat.com>
