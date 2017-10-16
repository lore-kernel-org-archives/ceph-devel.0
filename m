From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: Delete unused variable in mds_client
Date: Mon, 16 Oct 2017 11:12:53 +0200
Message-ID: <CAOi1vP-MTz5sfpYGW_PipSOqKafQoPecSQY4Zq7OAHeUd-o9qw@mail.gmail.com>
References: <1507975272-8264-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507975272-8264-1-git-send-email-chris.gekas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sat, Oct 14, 2017 at 12:01 PM, Christos Gkekas <chris.gekas@gmail.com> wrote:
> Variable 'err' is set but never used, so should be removed.
>
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
> ---
>  fs/ceph/mds_client.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f23c820..7cd4fd9 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3801,7 +3801,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
>         u32 num_fs;
>         u32 mount_fscid = (u32)-1;
>         u8 struct_v, struct_cv;
> -       int err = -EINVAL;
>
>         ceph_decode_need(&p, end, sizeof(u32), bad);
>         epoch = ceph_decode_32(&p);
> @@ -3852,7 +3851,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
>                                    0, true);
>                 ceph_monc_renew_subs(&fsc->client->monc);
>         } else {
> -               err = -ENOENT;
>                 goto err_out;
>         }
>         return;

This doesn't seem right.  I think the original intent was to return
-EINVAL if decoding fails (like we do in many other places) and -ENOENT
if there is no filesystem with that name.  This is user-visible: it's
propagated all the way up and reported by mount(8).

I'd rather we do something like this:

commit 2b330133e10e7f53f0b169335c3b6000782e9123
Author: Ilya Dryomov <idryomov@gmail.com>
Date:   Mon Oct 16 10:32:50 2017 +0200

    ceph: -EINVAL on decoding failure in ceph_mdsc_handle_fsmap()

    Don't set ->mdsmap_err to -ENOENT unconditionally, and drop unneeded
    return statement while at it.

    Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 51f8af685a1f..aaa8879c8098 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3878,14 +3878,14 @@ void ceph_mdsc_handle_fsmap(struct
ceph_mds_client *mdsc, struct ceph_msg *msg)
                goto err_out;
        }
        return;
+
 bad:
        pr_err("error decoding fsmap\n");
 err_out:
        mutex_lock(&mdsc->mutex);
-       mdsc->mdsmap_err = -ENOENT;
+       mdsc->mdsmap_err = err;
        __wake_requests(mdsc, &mdsc->waiting_for_map);
        mutex_unlock(&mdsc->mutex);
-       return;
 }

 /*

Thanks,

                Ilya
