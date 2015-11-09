From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph:Fix error handling in the function down_reply
Date: Mon, 9 Nov 2015 18:15:14 +0800
Message-ID: <5C00713A-6AA6-437E-8C05-CFC993C2731E@redhat.com>
References: <1447038686-31928-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448AbbKIKP3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 05:15:29 -0500
In-Reply-To: <1447038686-31928-1-git-send-email-xerofoify@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org


> On Nov 9, 2015, at 11:11, Nicholas Krause <xerofoify@gmail.com> wrote:
> 
> This fixes error handling in the function down_reply in order to
> properly check and jump to the goto label, out_err for this
> particular function if a error code is returned by any function
> called in down_reply and therefore make checking be included
> for the call to ceph_update_snap_trace in order to comply with
> these error handling checks/paths.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
> fs/ceph/mds_client.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 51cb02d..0b01f94 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2495,14 +2495,17 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
> 	realm = NULL;
> 	if (rinfo->snapblob_len) {
> 		down_write(&mdsc->snap_rwsem);
> -		ceph_update_snap_trace(mdsc, rinfo->snapblob,
> -				rinfo->snapblob + rinfo->snapblob_len,
> -				le32_to_cpu(head->op) == CEPH_MDS_OP_RMSNAP,
> -				&realm);
> +		err = ceph_update_snap_trace(mdsc, rinfo->snapblob,
> +					     rinfo->snapblob + rinfo->snapblob_len,
> +					     le32_to_cpu(head->op) == CEPH_MDS_OP_RMSNAP,
> +					     &realm);
> 		downgrade_write(&mdsc->snap_rwsem);
> 	} else {
> 		down_read(&mdsc->snap_rwsem);
> 	}
> +
> +	if (err)
> +		goto out_err;
> 
> 	/* insert trace into our cache */
> 	mutex_lock(&req->r_fill_mutex);

Applied, thanks

Yan, Zheng

> -- 
> 2.5.0
> 

