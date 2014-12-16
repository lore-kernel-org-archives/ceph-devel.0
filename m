From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: introduce global empty snap context
Date: Tue, 16 Dec 2014 13:51:51 +0300
Message-ID: <CALFYKtCc-j494MJWYTc2v30Z+cynygfn4QUEQrSBEYT2nCAUmQ@mail.gmail.com>
References: <CALFYKtAHtrg10kH7L_yVU_5UzL-fXtoPZyFNMJ8h94b_vfqYFQ@mail.gmail.com>
	<CALFYKtDHA+M-TU9nOQRx9sTd0aixHWMt5JQFd1+nPUOebwK89w@mail.gmail.com>
	<C2BBC3D2-34E6-4C46-91D7-B63C6D9FB8F1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:39968 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaLPKvw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Dec 2014 05:51:52 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so10089194qgf.30
        for <ceph-devel@vger.kernel.org>; Tue, 16 Dec 2014 02:51:51 -0800 (PST)
In-Reply-To: <C2BBC3D2-34E6-4C46-91D7-B63C6D9FB8F1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 16, 2014 at 11:43 AM, =E4=B8=A5=E6=AD=A3 <zyan@redhat.com> =
wrote:
>
>> =E5=9C=A8 2014=E5=B9=B412=E6=9C=8815=E6=97=A5=EF=BC=8C21:00=EF=BC=8C=
Ilya Dryomov <ilya.dryomov@inktank.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Thu, Nov 13, 2014 at 11:23 PM, Ilya Dryomov <ilya.dryomov@inktank=
=2Ecom> wrote:
>>> This patch wasn't posted on ceph-devel, posting..
>>
>> Hi Zheng,
>>
>> Ping - I had some comments (below), mostly trivial but a potential
>> cached_context leak is what worries me.
>>
>> Thanks,
>>
>>               Ilya
>
>
> here is the updated patch, thanks.
>
> =E2=80=94
> From 6de279d244d56b78da70efe7968b815db0f3bb5f Mon Sep 17 00:00:00 200=
1
> From: "Yan, Zheng" <zyan@redhat.com>
> Date: Thu, 6 Nov 2014 15:09:41 +0800
> Subject: [PATCH] ceph: introduce global empty snap context
>
> Current snaphost code does not properly handle moving inode from one
> empty snap realm to another empty snap realm. After changing inode's
> snap realm, some dirty pages' snap context can be not equal to inode'=
s
> i_head_snap. This can trigger BUG() in ceph_put_wrbuffer_cap_refs()
>
> The fix is introduce a global empty snap context for all empty snap
> realm. This avoids triggering the BUG() for filesystem with no snapsh=
ot.
>
> Fixes: http://tracker.ceph.com/issues/9928
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
> fs/ceph/snap.c  | 28 ++++++++++++++++++++++++++--
> fs/ceph/super.c | 10 ++++++++--
> fs/ceph/super.h |  2 ++
> 3 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index c1cc993..3035b8f 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -288,6 +288,9 @@ static int cmpu64_rev(const void *a, const void *=
b)
>         return 0;
> }
>
> +
> +static struct ceph_snap_context *empty_snapc;
> +
> /*
>  * build the snap context for a given realm.
>  */
> @@ -328,6 +331,12 @@ static int build_snap_context(struct ceph_snap_r=
ealm *realm)
>                 return 0;
>         }
>
> +       if (num =3D=3D 0 && realm->seq =3D=3D empty_snapc->seq) {
> +               ceph_get_snap_context(empty_snapc);
> +               snapc =3D empty_snapc;
> +               goto done;
> +       }
> +
>         /* alloc new snap context */
>         err =3D -ENOMEM;
>         if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> @@ -364,7 +373,7 @@ static int build_snap_context(struct ceph_snap_re=
alm *realm)
>         dout("build_snap_context %llx %p: %p seq %lld (%u snaps)\n",
>              realm->ino, realm, snapc, snapc->seq,
>              (unsigned int) snapc->num_snaps);
> -
> +done:
>         ceph_put_snap_context(realm->cached_context);
>         realm->cached_context =3D snapc;
>         return 0;
> @@ -465,6 +474,9 @@ void ceph_queue_cap_snap(struct ceph_inode_info *=
ci)
>                    cap_snap.  lucky us. */
>                 dout("queue_cap_snap %p already pending\n", inode);
>                 kfree(capsnap);
> +       } else if (ci->i_snap_realm->cached_context =3D=3D empty_snap=
c) {
> +               dout("queue_cap_snap %p empty snapc\n", inode);
> +               kfree(capsnap);
>         } else if (dirty & (CEPH_CAP_AUTH_EXCL|CEPH_CAP_XATTR_EXCL|
>                             CEPH_CAP_FILE_EXCL|CEPH_CAP_FILE_WR)) {
>                 struct ceph_snap_context *snapc =3D ci->i_head_snapc;
> @@ -925,5 +937,17 @@ out:
>         return;
> }
>
> +int __init ceph_snap_init(void)
> +{
> +       empty_snapc =3D ceph_create_snap_context(0, GFP_NOFS);
> +       if (!empty_snapc)
> +               return -ENOMEM;
> +       empty_snapc->seq =3D 1;
> +       empty_snapc->num_snaps =3D 0;
> +       return 0;
> +}
>
> -
> +void ceph_snap_exit(void)
> +{
> +       ceph_put_snap_context(empty_snapc);
> +}
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index f6e1237..3b5c1e3 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1028,15 +1028,20 @@ static int __init init_ceph(void)
>
>         ceph_flock_init();
>         ceph_xattr_init();
> +       ret =3D ceph_snap_init();
> +       if (ret)
> +               goto out_xattr;
>         ret =3D register_filesystem(&ceph_fs_type);
>         if (ret)
> -               goto out_icache;
> +               goto out_snap;
>
>         pr_info("loaded (mds proto %d)\n", CEPH_MDSC_PROTOCOL);
>
>         return 0;
>
> -out_icache:
> +out_snap:
> +       ceph_snap_exit();
> +out_xattr:
>         ceph_xattr_exit();
>         destroy_caches();
> out:
> @@ -1047,6 +1052,7 @@ static void __exit exit_ceph(void)
> {
>         dout("exit_ceph\n");
>         unregister_filesystem(&ceph_fs_type);
> +       ceph_snap_exit();
>         ceph_xattr_exit();
>         destroy_caches();
> }
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index aca2287..9f63f18 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -699,6 +699,8 @@ extern void ceph_queue_cap_snap(struct ceph_inode=
_info *ci);
> extern int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>                                   struct ceph_cap_snap *capsnap);
> extern void ceph_cleanup_empty_realms(struct ceph_mds_client *mdsc);
> +extern int __init ceph_snap_init(void);
> +extern void ceph_snap_exit(void);
>
> /*
>  * a cap_snap is "pending" if it is still awaiting an in-progress
> --
> 1.9.3
>
>
>
>>
>>
>>>
>>> From d57f921fd3c7cbe768f13bc58e547d83274f47a8 Mon Sep 17 00:00:00 2=
001
>>> From: "Yan, Zheng" <zyan@redhat.com>
>>> Date: Thu, 6 Nov 2014 15:09:41 +0800
>>> Subject: [PATCH] ceph: introduce global empty snap context
>>>
>>> Current snaphost code does not properly handle moving inode from on=
e
>>> empty snap realm to another empty snap realm. After changing inode'=
s
>>> snap realm, some dirty pages' snap context can be not equal to inod=
e's
>>> i_head_snap. This can trigger BUG() in ceph_put_wrbuffer_cap_refs()
>>>
>>> The fix is introduce a global empty snap context for all empty snap
>>> realm. This avoids triggering the BUG() for filesystem with no snap=
shot.
>>>
>>> Fixes: http://tracker.ceph.com/issues/9928
>>> Signed-off-by: Yan, Zheng <zyan@redhat.com>
>>> ---
>>> fs/ceph/snap.c  | 26 +++++++++++++++++++++++++-
>>> fs/ceph/super.c |  6 ++++++
>>> fs/ceph/super.h |  2 ++
>>> 3 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
>>> index c1cc993225e3..24b454a0e64c 100644
>>> --- a/fs/ceph/snap.c
>>> +++ b/fs/ceph/snap.c
>>> @@ -288,6 +288,9 @@ static int cmpu64_rev(const void *a, const void=
 *b)
>>>       return 0;
>>> }
>>>
>>> +
>>> +static struct ceph_snap_context *empty_snapc;
>>> +
>>> /*
>>> * build the snap context for a given realm.
>>> */
>>> @@ -328,6 +331,12 @@ static int build_snap_context(struct
>>> ceph_snap_realm *realm)
>>>               return 0;
>>>       }
>>>
>>> +       if (num =3D=3D 0 && realm->seq =3D=3D empty_snapc->seq) {
>>> +               ceph_get_snap_context(empty_snapc);
>>> +               realm->cached_context =3D empty_snapc;
>>> +               return 0;
>>>
>>> Can there be a cached_context here that we would need to let go of?
>>> IOW, shouldn't this be
>>>
>>> +       if (num =3D=3D 0 && realm->seq =3D=3D empty_snapc->seq) {
>>> +               ceph_get_snap_context(empty_snapc);
>>> +               goto out;
>>> +       }
>>>
>>>       ...
>>>
>>>            realm->ino, realm, snapc, snapc->seq,
>>>            (unsigned int) snapc->num_snaps);
>>>
>>> +out:
>>>       ceph_put_snap_context(realm->cached_context);
>>>       realm->cached_context =3D snapc;
>>>       return 0;
>>>
>>> ?
>>>
>>> +       }
>>> +
>>>       /* alloc new snap context */
>>>       err =3D -ENOMEM;
>>>       if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
>>> @@ -465,6 +474,9 @@ void ceph_queue_cap_snap(struct ceph_inode_info=
 *ci)
>>>                  cap_snap.  lucky us. */
>>>               dout("queue_cap_snap %p already pending\n", inode);
>>>               kfree(capsnap);
>>> +       } else if (ci->i_snap_realm->cached_context =3D=3D empty_sn=
apc) {
>>> +               dout("queue_cap_snap %p empty snapc\n", inode);
>>> +               kfree(capsnap);
>>>       } else if (dirty & (CEPH_CAP_AUTH_EXCL|CEPH_CAP_XATTR_EXCL|
>>>                           CEPH_CAP_FILE_EXCL|CEPH_CAP_FILE_WR)) {
>>>               struct ceph_snap_context *snapc =3D ci->i_head_snapc;
>>> @@ -925,5 +937,17 @@ out:
>>>       return;
>>> }
>>>
>>> +int ceph_snap_init(void)
>>>
>>> I see you put __init on the declaration.  While that seems to work
>>> I think it's preferred to have it on the definition:
>>>
>>> int __init ceph_snap_init(void)
>>>
>>> +{
>>> +       empty_snapc =3D ceph_create_snap_context(0, GFP_NOFS);
>>> +       if (!empty_snapc)
>>> +               return -ENOMEM;
>>> +       empty_snapc->seq =3D 1;
>>> +       empty_snapc->num_snaps =3D 0;
>>>
>>> Setting num_snaps seems unnecessary, ceph_create_snap_context() doe=
s
>>> that for you.
>>>
>>> +       return 0;
>>> +}
>>>
>>> -
>>> +void ceph_snap_exit(void)
>>> +{
>>> +       ceph_put_snap_context(empty_snapc);
>>> +}
>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>> index f6e12377335c..2b5481f1b9c7 100644
>>> --- a/fs/ceph/super.c
>>> +++ b/fs/ceph/super.c
>>> @@ -1028,6 +1028,9 @@ static int __init init_ceph(void)
>>>
>>>       ceph_flock_init();
>>>       ceph_xattr_init();
>>> +       ret =3D ceph_snap_init();
>>> +       if (ret)
>>> +               goto out_xattr;
>>>       ret =3D register_filesystem(&ceph_fs_type);
>>>       if (ret)
>>>               goto out_icache;
>>> @@ -1037,6 +1040,8 @@ static int __init init_ceph(void)
>>>       return 0;
>>>
>>> out_icache:
>>>
>>> You could rename the nonsensical out_icache to out_snap while you a=
re
>>> at it.
>>>
>>> +       ceph_snap_exit();
>>> +out_xattr:
>>>       ceph_xattr_exit();
>>>       destroy_caches();
>>> out:
>>> @@ -1047,6 +1052,7 @@ static void __exit exit_ceph(void)
>>> {
>>>       dout("exit_ceph\n");
>>>       unregister_filesystem(&ceph_fs_type);
>>> +       ceph_snap_exit();
>>>       ceph_xattr_exit();
>>>       destroy_caches();
>>> }
>>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>>> index aca22879b41f..9f63f18bb783 100644
>>> --- a/fs/ceph/super.h
>>> +++ b/fs/ceph/super.h
>>> @@ -699,6 +699,8 @@ extern void ceph_queue_cap_snap(struct ceph_ino=
de_info *ci);
>>> extern int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>>>                                 struct ceph_cap_snap *capsnap);
>>> extern void ceph_cleanup_empty_realms(struct ceph_mds_client *mdsc)=
;
>>> +extern int __init ceph_snap_init(void);
>>>
>>> extern int ceph_snap_init(void); will do.
>>>
>>> +extern void ceph_snap_exit(void);
>>>
>>> /*
>>> * a cap_snap is "pending" if it is still awaiting an in-progress
>>> --
>>> 2.1.1

I fixed it up in testing manually.  Here is the diff:

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 28571cfa7f40..ce35fbd4ba5d 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -333,8 +333,8 @@ static int build_snap_context(struct ceph_snap_real=
m *realm)

        if (num =3D=3D 0 && realm->seq =3D=3D empty_snapc->seq) {
                ceph_get_snap_context(empty_snapc);
-               realm->cached_context =3D empty_snapc;
-               return 0;
+               snapc =3D empty_snapc;
+               goto done;
        }

        /* alloc new snap context */
@@ -374,6 +374,7 @@ static int build_snap_context(struct ceph_snap_real=
m *realm)
             realm->ino, realm, snapc, snapc->seq,
             (unsigned int) snapc->num_snaps);

+done:
        ceph_put_snap_context(realm->cached_context);
        realm->cached_context =3D snapc;
        return 0;
@@ -939,13 +940,12 @@ out:
        return;
 }

-int ceph_snap_init(void)
+int __init ceph_snap_init(void)
 {
        empty_snapc =3D ceph_create_snap_context(0, GFP_NOFS);
        if (!empty_snapc)
                return -ENOMEM;
        empty_snapc->seq =3D 1;
-       empty_snapc->num_snaps =3D 0;
        return 0;
 }

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 8eef47c8909a..50f06cddc94b 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1031,13 +1031,13 @@ static int __init init_ceph(void)
                goto out_xattr;
        ret =3D register_filesystem(&ceph_fs_type);
        if (ret)
-               goto out_icache;
+               goto out_snap;

        pr_info("loaded (mds proto %d)\n", CEPH_MDSC_PROTOCOL);

        return 0;

-out_icache:
+out_snap:
        ceph_snap_exit();
 out_xattr:
        ceph_xattr_exit();
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 33885ad03203..e1aa32d0759d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -701,7 +701,7 @@ extern void ceph_queue_cap_snap(struct ceph_inode_i=
nfo *ci);
 extern int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
                                  struct ceph_cap_snap *capsnap);
 extern void ceph_cleanup_empty_realms(struct ceph_mds_client *mdsc);
-extern int __init ceph_snap_init(void);
+extern int ceph_snap_init(void);
 extern void ceph_snap_exit(void);

 /*

Please make sure I got it right.  With the above

Reviewed-by: Ilya Dryomov <idryomov@redhat.com>

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
