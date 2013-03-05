From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 3/5] ceph: only set message data pointers if
 non-empty
Date: Tue, 5 Mar 2013 13:20:47 -0800
Message-ID: <5692F205D39C4841832682B184BC835A@inktank.com>
References: <5135F859.1090606@inktank.com> <5135F8CA.1010706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:54642 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3CEVUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 16:20:53 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so4979369pbc.26
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 13:20:52 -0800 (PST)
In-Reply-To: <5135F8CA.1010706@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, March 5, 2013 at 5:53 AM, Alex Elder wrote:
> The ceph file system doesn't typically send information in the
> data portion of a message. (It relies on some functionality
> exported by the osd client to read and write page data.)
> 
> There are two spots it does send data though. The value assigned to
> an extended attribute is held in one or more pages allocated by
> ceph_sync_setxattr(). Eventually those pages are assigned to a
> request message in create_request_message().
> 
> The second spot is when sending a reconnect message, where a
> ceph pagelist is used to build up an array of snaprealm_reconnect
> structures to send to the mds.
> 
> Change it so we only assign the outgoing data information for
> these messages if there is outgoing data to send.
> 
> This is related to:
> http://tracker.ceph.com/issues/4284
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> fs/ceph/mds_client.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 42400ce..ae83aa9 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1718,7 +1718,12 @@ static struct ceph_msg
> *create_request_message(struct ceph_mds_client *mdsc,
> msg->front.iov_len = p - msg->front.iov_base;
> msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> 
> - ceph_msg_data_set_pages(msg, req->r_pages, req->r_num_pages, 0);
> + if (req->r_num_pages) {
> + /* outbound data set only by ceph_sync_setxattr() */
> + BUG_ON(!req->r_pages);
> + ceph_msg_data_set_pages(msg, req->r_pages,
> + req->r_num_pages, 0);
> + }
> 
> msg->hdr.data_len = cpu_to_le32(req->r_data_len);
> msg->hdr.data_off = cpu_to_le16(0);
> @@ -2599,10 +2604,13 @@ static void send_mds_reconnect(struct
> ceph_mds_client *mdsc,
> goto fail;
> }
> 
> - ceph_msg_data_set_pagelist(reply, pagelist);
> if (recon_state.flock)
> reply->hdr.version = cpu_to_le16(2);
> - reply->hdr.data_len = cpu_to_le32(pagelist->length);
> + if (pagelist->length) {
> + /* set up outbound data if we have any */
> + reply->hdr.data_len = cpu_to_le32(pagelist->length);
> + ceph_msg_data_set_pagelist(reply, pagelist);
> + }
> ceph_con_send(&session->s_con, reply);
> 
> mutex_unlock(&session->s_mutex);
> 
Reviewed-by: Greg Farnum <greg@inktank.com>
Software Engineer #42 @ http://inktank.com | http://ceph.com

