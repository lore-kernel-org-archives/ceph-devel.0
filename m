From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH] libceph: print more info for short message header
Date: Thu, 30 May 2013 10:36:55 -0700
Message-ID: <7fdbb481-4a02-4091-a1e3-7c906c920cea@email.android.com>
References: <51A66A3F.4040707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58284 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab3E3Sgm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 14:36:42 -0400
In-Reply-To: <51A66A3F.4040707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Alex Elder <elder@inktank.com> wrote:

>If an osd client response message arrives that has a front section
>that's too big for the buffer set aside to receive it, a warning
>gets reported and a new buffer is allocated.
>
>The warning says nothing about which connection had the problem.
>Add the peer type and number to what gets reported, to be a bit more
>informative.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> net/ceph/osd_client.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>index e0abb83..61147fe 100644
>--- a/net/ceph/osd_client.c
>+++ b/net/ceph/osd_client.c
>@@ -2454,8 +2454,10 @@ static struct ceph_msg *get_reply(struct
>ceph_connection *con,
> 	ceph_msg_revoke_incoming(req->r_reply);
>
> 	if (front > req->r_reply->front.iov_len) {
>-		pr_warning("get_reply front %d > preallocated %d\n",
>-			   front, (int)req->r_reply->front.iov_len);
>+		pr_warning("get_reply front %d > preallocated %d (%u#%llu)\n",
>+			   front, (int)req->r_reply->front.iov_len,
>+			   (unsigned int)con->peer_name.type,
>+			   le64_to_cpu(con->peer_name.num));
> 		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front, GFP_NOFS, false);
> 		if (!m)
> 			goto out;

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
