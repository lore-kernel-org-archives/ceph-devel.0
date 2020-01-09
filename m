From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 2/6] ceph: hold extra reference to r_parent over life of
 request
Date: Thu, 9 Jan 2020 10:05:04 +0800
Message-ID: <e8e28503-bda4-df57-6a42-33761e716fe4@redhat.com>
References: <20200106153520.307523-1-jlayton@kernel.org>
 <20200106153520.307523-3-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727754AbgAICFR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2020 21:05:17 -0500
In-Reply-To: <20200106153520.307523-3-jlayton@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com

On 2020/1/6 23:35, Jeff Layton wrote:
> Currently, we just assume that it will stick around by virtue of the
> submitter's reference, but later patches will allow the syscall to
> return early and we can't rely on that reference at that point.
>
> Take an extra reference to the inode when setting r_parent and release
> it when releasing the request.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/mds_client.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 94cce2ab92c4..b7122f682678 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -708,8 +708,10 @@ void ceph_mdsc_release_request(struct kref *kref)
>   		/* avoid calling iput_final() in mds dispatch threads */
>   		ceph_async_iput(req->r_inode);
>   	}
> -	if (req->r_parent)
> +	if (req->r_parent) {
>   		ceph_put_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
> +		ceph_async_iput(req->r_parent);
> +	}
>   	ceph_async_iput(req->r_target_inode);
>   	if (req->r_dentry)
>   		dput(req->r_dentry);
> @@ -2706,8 +2708,10 @@ int ceph_mdsc_submit_request(struct ceph_mds_cli=
ent *mdsc, struct inode *dir,
>   	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
>   	if (req->r_inode)
>   		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
> -	if (req->r_parent)
> +	if (req->r_parent) {
>   		ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
> +		ihold(req->r_parent);
> +	}

This might also fix another issue when the mdsc request is timedout and=20
returns to the vfs, then the r_parent maybe released in vfs. And then if=20
we reference it again in mdsc handle_reply() -->=20
ceph_mdsc_release_request(),=A0 some unknown issues may happen later ??

>   	if (req->r_old_dentry_dir)
>   		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
>   				  CEPH_CAP_PIN);
