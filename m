From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [v2] ceph: use frag's MDS in either mode
Date: Fri, 31 Jul 2020 07:57:17 -0400
Message-ID: <8e87954aa5d04dd25330afd68b396ef40ff53398.camel@kernel.org>
References: <20200731082513.11806-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732689AbgGaL5T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:57:19 -0400
In-Reply-To: <20200731082513.11806-1-gmayyyha@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yanhu Cao <gmayyyha@gmail.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2020-07-31 at 16:25 +0800, Yanhu Cao wrote:
> When doing some tests with multiple mds, there are many
> mds forwarding requests between them and then the client request
> is resent.
> 
> If the request is a modification operation and the mode is set to USE_AUTH_MDS.
> Auth mds should be selected to handle the request, and if auth mds for
> frag is already set, it can be returned directly without the logic behind it.
> 
> But the current logic doesn't return directly because the condition
> 'mode == USE_AUTH_MDS', and sometimes frag's mds is not equal to
> cap's session mds, which then causes the request to be resent.
> 
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
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


Much better! A good changelog is as important as the patch, esp in code
like this that is quite non-obvious.

Merged into testing branch. I did clean up the changelog a bit before I
merged it. Please take a look when you have time and let me know if you
think I got it wrong.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
