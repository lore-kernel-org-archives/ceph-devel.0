From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH] libceph: clean up skipped message logic
Date: Tue, 5 Mar 2013 12:09:13 -0800
Message-ID: <77EAE308555F4359AF0494C573521375@inktank.com>
References: <51361048.50500@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:34301 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab3CEUJS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 15:09:18 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so4930469pbb.34
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 12:09:17 -0800 (PST)
In-Reply-To: <51361048.50500@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, March 5, 2013 at 7:33 AM, Alex Elder wrote:
> (This patch is available as the top commit in branch
> "review/wip-4324" in the ceph-client git repository.)
> 
> In ceph_con_in_msg_alloc() it is possible for a connection's
> alloc_msg method to indicate an incoming message should be skipped.
> By default, read_partial_message() initializes the skip variable
> to 0 before it gets provided to ceph_con_in_msg_alloc().
> 
> The osd client, mon client, and mds client each supply an alloc_msg
> method. The mds client always assigns skip to be 0.
> 
> The other two leave the skip value of as-is, or assigns it to zero,
> except:
> - if no (osd or mon) request having the given tid is found, in
> which case skip is set to 1 and NULL is returned; or
> - in the osd client, if the data of the reply message is not
> adequate to hold the message to be read, it assigns skip
> value 1 and returns NULL.
> So the returned message pointer will always be NULL if skip is ever
> non-zero.
> 
> Clean up the logic a bit in ceph_con_in_msg_alloc() to make this
> state of affairs more obvious. Add a comment explaining how a null
> message pointer can mean either a message that should be skipped or
> a problem allocating a message.
> 
> This resolves:
> http://tracker.ceph.com/issues/4324
> 
> Reported-by: Greg Farnum <greg@inktank.com (mailto:greg@inktank.com)>
> Signed-off-by: Alex Elder <elder@inktank.com (mailto:elder@inktank.com)>
> ---
> net/ceph/messenger.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 5bf1bb5..644cb6c 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2860,18 +2860,21 @@ static int ceph_con_in_msg_alloc(struct
> ceph_connection *con, int *skip)
> ceph_msg_put(msg);
> return -EAGAIN;
> }
> - con->in_msg = msg;
> - if (con->in_msg) {
> + if (msg) {
> + BUG_ON(*skip);
> + con->in_msg = msg;
> con->in_msg->con = con->ops->get(con);
> BUG_ON(con->in_msg->con == NULL);
> - }
> - if (*skip) {
> - con->in_msg = NULL;
> - return 0;
> - }
> - if (!con->in_msg) {
> - con->error_msg =
> - "error allocating memory for incoming message";
> + } else {
> + /*
> + * Null message pointer means either we should skip
> + * this message or we couldn't allocate memory. The
> + * former is not an error.
> + */
> + if (*skip)
> + return 0;
> + con->error_msg = "error allocating memory for incoming message";
> +
> return -ENOMEM;
> }
> memcpy(&con->in_msg->hdr, &con->in_hdr, sizeof(con->in_hdr));
> -- 
> 1.7.9.5

Reviewed-by: Greg Farnum <greg@inktank.com> 

