From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: init sent and completed when starting
Date: Sat, 11 May 2013 14:11:37 -0700
Message-ID: <518EB409.8020404@inktank.com>
References: <518E81BC.5020702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:64783 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab3EKVL1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 17:11:27 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so10169132iee.13
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 14:11:26 -0700 (PDT)
In-Reply-To: <518E81BC.5020702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/11/2013 10:37 AM, Alex Elder wrote:
> The rbd code has a need to be able to restart an osd request that
> has already been started and completed once before.  This currently
> wouldn't work right because the osd client code assumes an osd
> request will be started exactly once  Certain fields in a request
> are never cleared and this leads to trouble if you try to reuse it.
>
> Specifically, the r_sent, r_got_reply, and r_completed fields are
> never cleared.  The r_sent field records the osd incarnation at the
> time the request was sent to that osd.  If that's non-zero, the
> message won't get re-mapped to a target osd properly, and won't be
> put on the unsafe requests list the first time it's sent as it
> should.  The r_got_reply field is used in handle_reply() to ensure
> the reply to a request is processed only once.  And the r_completed
> field is used for lingering requests to avoid calling the callback
> function every time the osd client re-sends the request on behalf of
> its initiator.
>
> Each osd request passes through ceph_osdc_start_request() when
> responsibility for the request is handed over to the osd client for
> completion.  We can safely zero these three fields there each time a
> request gets started.
>
> One last related change--clear the r_linger flag when a request
> is no longer registered as a linger request.
>
> This resolves:
>      http://tracker.ceph.com/issues/5026
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a3395fd..d5953b8 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1204,6 +1204,7 @@ void ceph_osdc_unregister_linger_request(struct
> ceph_osd_client *osdc,
>   	mutex_lock(&osdc->request_mutex);
>   	if (req->r_linger) {
>   		__unregister_linger_request(osdc, req);
> +		req->r_linger = 0;
>   		ceph_osdc_put_request(req);
>   	}
>   	mutex_unlock(&osdc->request_mutex);
> @@ -2120,7 +2121,9 @@ int ceph_osdc_start_request(struct ceph_osd_client
> *osdc,
>   	down_read(&osdc->map_sem);
>   	mutex_lock(&osdc->request_mutex);
>   	__register_request(osdc, req);
> -	WARN_ON(req->r_sent);
> +	req->r_sent = 0;
> +	req->r_got_reply = 0;
> +	req->r_completed = 0;
>   	rc = __map_request(osdc, req, 0);
>   	if (rc < 0) {
>   		if (nofail) {
>

