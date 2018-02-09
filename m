From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: fix slab error when removing ceph module
Date: Fri, 9 Feb 2018 22:28:04 +0800
Message-ID: <E360B4FA-6404-4463-9ED3-3DCD65AF7A0D@redhat.com>
References: <1518180059-171011-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751034AbeBIO2N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:28:13 -0500
In-Reply-To: <1518180059-171011-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com

I’m curious how did you make ceph_fs_debugfs_init fail

Yan, Zheng

> On 9 Feb 2018, at 20:40, Chengguang Xu <cgxu519@icloud.com> wrote:
> 
> When failing from ceph_fs_debugfs_init() in ceph_real_mount(),
> there is lack of dput of root_dentry and it causes slab errors,
> so change the calling order of ceph_fs_debugfs_init() and
> open_root_dentry() and do some cleanups to avoid this issue.
> 
> Detail error messages:
> =============================================================================
> BUG  ceph_inode_info  (Not  tainted):  Objects  remaining  in  ceph_inode_info  on  __kmem_cache_shutdown()
> -----------------------------------------------------------------------------
> Disabling  lock  debugging  due  to  kernel  taint
> INFO:  Slab  0x000000001037cfd2  objects=23  used=1  fp=0x000000006c0dc265  flags=0x2fffff80008100
> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  seabios-1.7.5-11.el7  04/01/2014
> Call  Trace:
> dump_stack+0x5c/0x7c
> slab_err+0xb4/0xe0
> ?  on_each_cpu_mask+0x24/0x60
> ?  on_each_cpu_cond+0xad/0x140
> ?  __kmalloc+0x1be/0x1f0
> ?  __kmem_cache_shutdown+0x175/0x3c0
> __kmem_cache_shutdown+0x196/0x3c0
> shutdown_cache+0x13/0x1a0
> kmem_cache_destroy+0x1e4/0x220
> destroy_caches+0x16/0x46  [ceph]
> SyS_delete_module+0x168/0x240
> ?  exit_to_usermode_loop+0x6e/0x93
> entry_SYSCALL_64_fastpath+0x20/0x83
> RIP:  0033:0x7f8650f87c27
> RSP:  002b:00007ffda546ff88  EFLAGS:  00000206
> INFO:  Object  0x00000000568b3053  @offset=0
> kmem_cache_destroy  ceph_inode_info:  Slab  cache  still  has  objects
> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  seabios-1.7.5-11.el7  04/01/2014
> Call  Trace:
> dump_stack+0x5c/0x7c
> kmem_cache_destroy+0x203/0x220
> destroy_caches+0x16/0x46  [ceph]
> SyS_delete_module+0x168/0x240
> ?  exit_to_usermode_loop+0x6e/0x93
> entry_SYSCALL_64_fastpath+0x20/0x83
> RIP:  0033:0x7f8650f87c27
> RSP:  002b:00007ffda546ff88  EFLAGS:  00000206
> =============================================================================
> BUG  ceph_dentry_info  (Tainted:  G  B  ):  Objects  remaining  in  ceph_dentry_info  on  __kmem_cache_shutdown()
> -----------------------------------------------------------------------------
> INFO:  Slab  0x00000000aabb3f88  objects=51  used=1  fp=0x000000002436421a  flags=0x2fffff80000100
> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  seabios-1.7.5-11.el7  04/01/2014
> Call  Trace:
> dump_stack+0x5c/0x7c
> slab_err+0xb4/0xe0
> ?  on_each_cpu_cond+0xad/0x140
> ?  __kmalloc+0x1be/0x1f0
> ?  __kmem_cache_shutdown+0x175/0x3c0
> __kmem_cache_shutdown+0x196/0x3c0
> shutdown_cache+0x13/0x1a0
> kmem_cache_destroy+0x1e4/0x220
> destroy_caches+0x3a/0x46  [ceph]
> SyS_delete_module+0x168/0x240
> ?  exit_to_usermode_loop+0x6e/0x93
> entry_SYSCALL_64_fastpath+0x20/0x83
> RIP:  0033:0x7f8650f87c27
> RSP:  002b:00007ffda546ff88  EFLAGS:  00000206
> INFO:  Object  0x0000000034be48a6  @offset=0
> kmem_cache_destroy  ceph_dentry_info:  Slab  cache  still  has  objects
> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  seabios-1.7.5-11.el7  04/01/2014
> Call  Trace:
> dump_stack+0x5c/0x7c
> kmem_cache_destroy+0x203/0x220
> destroy_caches+0x3a/0x46  [ceph]
> SyS_delete_module+0x168/0x240
> ?  exit_to_usermode_loop+0x6e/0x93
> entry_SYSCALL_64_fastpath+0x20/0x83
> RIP:  0033:0x7f8650f87c27
> 
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> fs/ceph/super.c | 16 +++++-----------
> 1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index a62d2a9..26526601 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -836,7 +836,6 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
> 	int err;
> 	unsigned long started = jiffies;  /* note the start time */
> 	struct dentry *root;
> -	int first = 0;   /* first vfsmount for this super_block */
> 
> 	dout("mount start %p\n", fsc);
> 	mutex_lock(&fsc->client->mount_mutex);
> @@ -861,17 +860,17 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
> 			path = fsc->mount_options->server_path + 1;
> 			dout("mount opening path %s\n", path);
> 		}
> +
> +		err = ceph_fs_debugfs_init(fsc);
> +		if (err < 0)
> +			goto out;
> +
> 		root = open_root_dentry(fsc, path, started);
> 		if (IS_ERR(root)) {
> 			err = PTR_ERR(root);
> 			goto out;
> 		}
> 		fsc->sb->s_root = dget(root);
> -		first = 1;
> -
> -		err = ceph_fs_debugfs_init(fsc);
> -		if (err < 0)
> -			goto fail;
> 	} else {
> 		root = dget(fsc->sb->s_root);
> 	}
> @@ -881,11 +880,6 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
> 	mutex_unlock(&fsc->client->mount_mutex);
> 	return root;
> 
> -fail:
> -	if (first) {
> -		dput(fsc->sb->s_root);
> -		fsc->sb->s_root = NULL;
> -	}
> out:
> 	mutex_unlock(&fsc->client->mount_mutex);
> 	return ERR_PTR(err);
> -- 
> 1.8.3.1
> 

