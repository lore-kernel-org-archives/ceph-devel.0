From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [v3] ceph: if we are blacklisted, __do_request returns directly
Date: Mon, 20 Apr 2020 08:16:45 -0400
Message-ID: <ad6ca41f601d4feb2c3bd2850aeab95c3187bf2d.camel@kernel.org>
References: <20200417110723.12235-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgDTMQr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:16:47 -0400
In-Reply-To: <20200417110723.12235-1-gmayyyha@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yanhu Cao <gmayyyha@gmail.com>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 19:07 +0800, Yanhu Cao wrote:
> If we mount cephfs by the recover_session option,
> __do_request can return directly until the client automatically reconnects.
> 
> Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> ---
>  fs/ceph/mds_client.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 486f91f9685b..16ac5e5f7f79 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
>  
>  	put_request_session(req);
>  
> +	if (mdsc->fsc->blacklisted &&
> +	    ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
> +		err = -EBLACKLISTED;
> +		goto finish;
> +	}
> +

Why check for CLEANRECOVER? If we're mounted with recover_session=no
wouldn't we want to do the same thing here?

Either way, it's still blacklisted. The only difference is that it won't
attempt to automatically recover the session that way.


>  	mds = __choose_mds(mdsc, req, &random);
>  	if (mds < 0 ||
>  	    ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
-- 
Jeff Layton <jlayton@kernel.org>
