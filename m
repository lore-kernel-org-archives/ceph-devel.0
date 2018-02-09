From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: [PATCH] ceph: fix slab error when removing ceph module
Date: Fri, 09 Feb 2018 22:53:38 +0800
Message-ID: <AC1D19AA-6ED0-4923-9B83-75F23F72E5DB@icloud.com>
References: <1518180059-171011-1-git-send-email-cgxu519@icloud.com>
 <E360B4FA-6404-4463-9ED3-3DCD65AF7A0D@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:33929 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBIOyA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Feb 2018 09:54:00 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3W008001343U00@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Fri, 09 Feb 2018 14:53:59 +0000 (GMT)
In-reply-to: <E360B4FA-6404-4463-9ED3-3DCD65AF7A0D@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>


> =D4=DA 2018=C4=EA2=D4=C29=C8=D5=A3=AC=CF=C2=CE=E710:28=A3=ACYan, Zheng =
<zyan@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
> I=A1=AFm curious how did you make ceph_fs_debugfs_init fail

Hi Yan,

Actually I got some error messages during my hacking work=20
in mount process, I did some diagnostics for the reason and
found this issue. Let ceph_fs_debugfs_init fail in a natural
way may be difficult, so I explicitly let it fail in the code
to see what will happen in this context.


>=20
> Yan, Zheng
>=20
>> On 9 Feb 2018, at 20:40, Chengguang Xu <cgxu519@icloud.com> wrote:
>>=20
>> When failing from ceph_fs_debugfs_init() in ceph_real_mount(),
>> there is lack of dput of root_dentry and it causes slab errors,
>> so change the calling order of ceph_fs_debugfs_init() and
>> open_root_dentry() and do some cleanups to avoid this issue.
>>=20
>> Detail error messages:
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> BUG  ceph_inode_info  (Not  tainted):  Objects  remaining  in  =
ceph_inode_info  on  __kmem_cache_shutdown()
>> =
--------------------------------------------------------------------------=
---
>> Disabling  lock  debugging  due  to  kernel  taint
>> INFO:  Slab  0x000000001037cfd2  objects=3D23  used=3D1  =
fp=3D0x000000006c0dc265  flags=3D0x2fffff80008100
>> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
>> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  =
seabios-1.7.5-11.el7  04/01/2014
>> Call  Trace:
>> dump_stack+0x5c/0x7c
>> slab_err+0xb4/0xe0
>> ?  on_each_cpu_mask+0x24/0x60
>> ?  on_each_cpu_cond+0xad/0x140
>> ?  __kmalloc+0x1be/0x1f0
>> ?  __kmem_cache_shutdown+0x175/0x3c0
>> __kmem_cache_shutdown+0x196/0x3c0
>> shutdown_cache+0x13/0x1a0
>> kmem_cache_destroy+0x1e4/0x220
>> destroy_caches+0x16/0x46  [ceph]
>> SyS_delete_module+0x168/0x240
>> ?  exit_to_usermode_loop+0x6e/0x93
>> entry_SYSCALL_64_fastpath+0x20/0x83
>> RIP:  0033:0x7f8650f87c27
>> RSP:  002b:00007ffda546ff88  EFLAGS:  00000206
>> INFO:  Object  0x00000000568b3053  @offset=3D0
>> kmem_cache_destroy  ceph_inode_info:  Slab  cache  still  has  =
objects
>> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
>> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  =
seabios-1.7.5-11.el7  04/01/2014
>> Call  Trace:
>> dump_stack+0x5c/0x7c
>> kmem_cache_destroy+0x203/0x220
>> destroy_caches+0x16/0x46  [ceph]
>> SyS_delete_module+0x168/0x240
>> ?  exit_to_usermode_loop+0x6e/0x93
>> entry_SYSCALL_64_fastpath+0x20/0x83
>> RIP:  0033:0x7f8650f87c27
>> RSP:  002b:00007ffda546ff88  EFLAGS:  00000206
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> BUG  ceph_dentry_info  (Tainted:  G  B  ):  Objects  remaining  in  =
ceph_dentry_info  on  __kmem_cache_shutdown()
>> =
--------------------------------------------------------------------------=
---
>> INFO:  Slab  0x00000000aabb3f88  objects=3D51  used=3D1  =
fp=3D0x000000002436421a  flags=3D0x2fffff80000100
>> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
>> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  =
seabios-1.7.5-11.el7  04/01/2014
>> Call  Trace:
>> dump_stack+0x5c/0x7c
>> slab_err+0xb4/0xe0
>> ?  on_each_cpu_cond+0xad/0x140
>> ?  __kmalloc+0x1be/0x1f0
>> ?  __kmem_cache_shutdown+0x175/0x3c0
>> __kmem_cache_shutdown+0x196/0x3c0
>> shutdown_cache+0x13/0x1a0
>> kmem_cache_destroy+0x1e4/0x220
>> destroy_caches+0x3a/0x46  [ceph]
>> SyS_delete_module+0x168/0x240
>> ?  exit_to_usermode_loop+0x6e/0x93
>> entry_SYSCALL_64_fastpath+0x20/0x83
>> RIP:  0033:0x7f8650f87c27
>> RSP:  002b:00007ffda546ff88  EFLAGS:  00000206
>> INFO:  Object  0x0000000034be48a6  @offset=3D0
>> kmem_cache_destroy  ceph_dentry_info:  Slab  cache  still  has  =
objects
>> CPU:  0  PID:  27086  Comm:  rmmod  Tainted:  G  B  4.15.0-rc8+  #7
>> Hardware  name:  Fedora  Project  OpenStack  Nova,  BIOS  =
seabios-1.7.5-11.el7  04/01/2014
>> Call  Trace:
>> dump_stack+0x5c/0x7c
>> kmem_cache_destroy+0x203/0x220
>> destroy_caches+0x3a/0x46  [ceph]
>> SyS_delete_module+0x168/0x240
>> ?  exit_to_usermode_loop+0x6e/0x93
>> entry_SYSCALL_64_fastpath+0x20/0x83
>> RIP:  0033:0x7f8650f87c27
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>> ---
>> fs/ceph/super.c | 16 +++++-----------
>> 1 file changed, 5 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index a62d2a9..26526601 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -836,7 +836,6 @@ static struct dentry *ceph_real_mount(struct =
ceph_fs_client *fsc)
>> 	int err;
>> 	unsigned long started =3D jiffies;  /* note the start time */
>> 	struct dentry *root;
>> -	int first =3D 0;   /* first vfsmount for this super_block */
>>=20
>> 	dout("mount start %p\n", fsc);
>> 	mutex_lock(&fsc->client->mount_mutex);
>> @@ -861,17 +860,17 @@ static struct dentry *ceph_real_mount(struct =
ceph_fs_client *fsc)
>> 			path =3D fsc->mount_options->server_path + 1;
>> 			dout("mount opening path %s\n", path);
>> 		}
>> +
>> +		err =3D ceph_fs_debugfs_init(fsc);
>> +		if (err < 0)
>> +			goto out;
>> +
>> 		root =3D open_root_dentry(fsc, path, started);
>> 		if (IS_ERR(root)) {
>> 			err =3D PTR_ERR(root);
>> 			goto out;
>> 		}
>> 		fsc->sb->s_root =3D dget(root);
>> -		first =3D 1;
>> -
>> -		err =3D ceph_fs_debugfs_init(fsc);
>> -		if (err < 0)
>> -			goto fail;
>> 	} else {
>> 		root =3D dget(fsc->sb->s_root);
>> 	}
>> @@ -881,11 +880,6 @@ static struct dentry *ceph_real_mount(struct =
ceph_fs_client *fsc)
>> 	mutex_unlock(&fsc->client->mount_mutex);
>> 	return root;
>>=20
>> -fail:
>> -	if (first) {
>> -		dput(fsc->sb->s_root);
>> -		fsc->sb->s_root =3D NULL;
>> -	}
>> out:
>> 	mutex_unlock(&fsc->client->mount_mutex);
>> 	return ERR_PTR(err);
>> --=20
>> 1.8.3.1
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

