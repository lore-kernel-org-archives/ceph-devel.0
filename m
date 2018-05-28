From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: fix use-after-free in ceph_statfs
Date: Mon, 28 May 2018 18:37:40 +0100
Message-ID: <20180528173740.26491-1-lhenriques@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

KASAN found an UAF in ceph_statfs.  This was a one-off bug but looking at
the code it looks like the monmap access needs to be protected as it can
be modified while we're accessing it.  Fix this by protecting the access
with the monc->mutex.

[  234.282067] BUG: KASAN: use-after-free in ceph_statfs+0x21d/0x2c0
[  234.284109] Read of size 8 at addr ffff88006844f2e0 by task trinity-c5/304

[  234.287646] CPU: 0 PID: 304 Comm: trinity-c5 Not tainted 4.17.0-rc6+ #172
[  234.289831] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[  234.292220] Call Trace:
[  234.292576]  dump_stack+0xa5/0x11b
[  234.293091]  ? show_regs_print_info+0x5/0x5
[  234.293663]  ? kmsg_dump_rewind+0x118/0x118
[  234.294258]  ? ceph_statfs+0x21d/0x2c0
[  234.294762]  print_address_description+0x73/0x2b0
[  234.295387]  ? ceph_statfs+0x21d/0x2c0
[  234.295923]  kasan_report+0x243/0x360
[  234.296445]  ceph_statfs+0x21d/0x2c0
[  234.296944]  ? ceph_umount_begin+0x80/0x80
[  234.297514]  ? kmem_cache_alloc+0xdf/0x1a0
[  234.298092]  statfs_by_dentry+0x79/0xb0
[  234.298801]  vfs_statfs+0x28/0x110
[  234.299398]  user_statfs+0x8c/0xe0
[  234.299915]  ? vfs_statfs+0x110/0x110
[  234.300469]  ? __fdget_raw+0x10/0x10
[  234.301163]  __se_sys_statfs+0x5d/0xa0
[  234.301872]  ? user_statfs+0xe0/0xe0
[  234.302566]  ? mutex_unlock+0x1d/0x40
[  234.303186]  ? __x64_sys_statfs+0x20/0x30
[  234.303880]  do_syscall_64+0xee/0x290
[  234.304488]  ? syscall_return_slowpath+0x1c0/0x1c0
[  234.305316]  ? page_fault+0x1e/0x30
[  234.305938]  ? syscall_return_slowpath+0x13c/0x1c0
[  234.306746]  ? prepare_exit_to_usermode+0xdb/0x140
[  234.307530]  ? syscall_trace_enter+0x330/0x330
[  234.308198]  ? __put_user_4+0x1c/0x30
[  234.308738]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  234.309477] RIP: 0033:0x7fb9b45fc229
[  234.310007] RSP: 002b:00007ffeedbd29a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
[  234.311068] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb9b45fc229
[  234.312105] RDX: 4400d4d4d4d4d4d4 RSI: 00007fb9b4b98000 RDI: 0000558bf5900d90
[  234.313179] RBP: 00007fb9b4caf000 R08: 0000000000000000 R09: 0036363636363636
[  234.314146] R10: 00000000000000b8 R11: 0000000000000246 R12: 0000000000000089
[  234.315127] R13: 00007fb9b4caf048 R14: 00007fb9b4cd9ad8 R15: 00007fb9b4caf000

[  234.316370] Allocated by task 130:
[  234.316945]  __kmalloc+0x124/0x210
[  234.317484]  ceph_monmap_decode+0x1c1/0x400
[  234.318008]  dispatch+0x113/0xd20
[  234.318380]  ceph_con_workfn+0xa7e/0x44e0
[  234.318837]  process_one_work+0x5f0/0xa30
[  234.319296]  worker_thread+0x184/0xa70
[  234.319715]  kthread+0x1a0/0x1c0
[  234.320083]  ret_from_fork+0x35/0x40

[  234.320676] Freed by task 130:
[  234.321039]  kfree+0xb8/0x210
[  234.321385]  dispatch+0x15a/0xd20
[  234.321766]  ceph_con_workfn+0xa7e/0x44e0
[  234.322244]  process_one_work+0x5f0/0xa30
[  234.322668]  worker_thread+0x184/0xa70
[  234.323067]  kthread+0x1a0/0x1c0
[  234.323531]  ret_from_fork+0x35/0x40

[  234.324401] The buggy address belongs to the object at ffff88006844f2e0
                which belongs to the cache kmalloc-192 of size 192
[  234.325786] The buggy address is located 0 bytes inside of
                192-byte region [ffff88006844f2e0, ffff88006844f3a0)
[  234.326876] The buggy address belongs to the page:
[  234.327576] page:ffffea0001a11380 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
[  234.329493] flags: 0x4000000000008100(slab|head)
[  234.330396] raw: 4000000000008100 0000000000000000 0000000000000000 00000001000f000f
[  234.331882] raw: ffffea0001a4d4a0 ffffea00018a3720 ffff88006d002a40 0000000000000000
[  234.332947] page dumped because: kasan: bad access detected

[  234.334227] Memory state around the buggy address:
[  234.335074]  ffff88006844f180: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  234.336296]  ffff88006844f200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  234.337549] >ffff88006844f280: fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb fb
[  234.338713]                                                        ^
[  234.339787]  ffff88006844f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  234.341011]  ffff88006844f380: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
[  234.342177] ==================================================================
[  234.343394] Disabling lock debugging due to kernel taint

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/super.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b33082e6878f..9c788e59fc04 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -45,7 +45,7 @@ static void ceph_put_super(struct super_block *s)
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(d_inode(dentry));
-	struct ceph_monmap *monmap = fsc->client->monc.monmap;
+	struct ceph_mon_client *monc = &fsc->client->monc;
 	struct ceph_statfs st;
 	u64 fsid;
 	int err;
@@ -58,7 +58,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 
 	dout("statfs\n");
-	err = ceph_monc_do_statfs(&fsc->client->monc, data_pool, &st);
+	err = ceph_monc_do_statfs(monc, data_pool, &st);
 	if (err < 0)
 		return err;
 
@@ -94,8 +94,11 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = NAME_MAX;
 
 	/* Must convert the fsid, for consistent values across arches */
-	fsid = le64_to_cpu(*(__le64 *)(&monmap->fsid)) ^
-	       le64_to_cpu(*((__le64 *)&monmap->fsid + 1));
+	mutex_lock(&monc->mutex);
+	fsid = le64_to_cpu(*(__le64 *)(&monc->monmap->fsid)) ^
+	       le64_to_cpu(*((__le64 *)&monc->monmap->fsid + 1));
+	mutex_unlock(&monc->mutex);
+
 	buf->f_fsid.val[0] = fsid & 0xffffffff;
 	buf->f_fsid.val[1] = fsid >> 32;
 
