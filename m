From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: use frag's MDS in either mode
Date: Thu, 30 Jul 2020 12:46:05 -0400
Message-ID: <e9c69117a1ce870c2a96565d2a2d64d066a6604f.camel@kernel.org>
References: <20200730112242.31648-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200730112242.31648-1-gmayyyha@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yanhu Cao <gmayyyha@gmail.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2020-07-30 at 19:22 +0800, Yanhu Cao wrote:
> if frag.mds != cap->session->s_mds, the client's req will be resent.
> 
> e.g.
> 
> file: mnt/cephfs/dir03/dir003 (0x10000000003)
> ceph.dir.pin="1"
> 
> echo 'aaa' > /mnt/cephfs/dir03/dir003/file29
> 
> kernel: ceph:  __choose_mds 00000000ca362c7a is_hash=1 (0x7c768b89) mode 2
> kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe frag 0 mds1 (auth)
> kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe mds0 (auth cap 00000000679c38e2)
> kernel: ceph:  __choose_mds using resend_mds mds1
> 
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

I think you're right that there is a bug here, but this patch
description is not terribly descriptive. Can you explain the problem and
solution a bit better?

A good patch description should walk me through the problem and your
reasoning to fix it. Why is this wrong now, and how does your change
address it?

Thanks,
Jeff

> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a50497142e59..b2255a9be7c0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1103,8 +1103,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
>  				     frag.frag, mds);
>  				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
>  				    CEPH_MDS_STATE_ACTIVE) {
> -					if (mode == USE_ANY_MDS &&
> -					    !ceph_mdsmap_is_laggy(mdsc->mdsmap,
> +					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
>  								  mds))
>  						goto out;
>  				}

-- 
Jeff Layton <jlayton@kernel.org>
