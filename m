From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
Date: Wed, 06 Jun 2012 17:10:52 -0500
Message-ID: <4FCFD56C.9050103@dreamhost.com>
References: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35525 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab2FFWKr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 18:10:47 -0400
In-Reply-To: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On 06/06/2012 03:03 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> The bug can cause NULL pointer dereference in write_partial_msg_pages
> 
> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
> ---
>  net/ceph/messenger.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 1a80907..785b953 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -598,6 +598,7 @@ static void prepare_write_message(struct ceph_connection *con)
>  	     le32_to_cpu(con->out_msg->footer.front_crc),
>  	     le32_to_cpu(con->out_msg->footer.middle_crc));
>  
> +	m->bio_iter = NULL;
>  	/* is there a data payload? */
>  	if (le32_to_cpu(m->hdr.data_len) > 0) {
>  		/* initialize page iterator */

OK, now that I've looked at this a little bit I think I have a small
preference for doing this assignment earlier in that function, where
there is already special handling that is dependent on whether the
message being processed is being re-sent or not:

        /*
         * only assign outgoing seq # if we haven't sent this message
         * yet.  if it is requeued, resend with it's original seq.
         */
        if (m->needs_out_seq) {
                m->hdr.seq = cpu_to_le64(++con->out_seq);
                m->needs_out_seq = false;
        }

So I'd suggest it look like:

        /*
         * only assign outgoing seq # if we haven't sent this message
         * yet.  if it is requeued, resend with it's original seq.
         */
        if (m->needs_out_seq) {
                m->hdr.seq = cpu_to_le64(++con->out_seq);
                m->needs_out_seq = false;
        }
#ifdef CONFIG_BLOCK
	else {
		/* Need to reinitialize the iterator on resends */
		m->bio_iter = NULL;
	}
#endif

Please let me know if you concur with my proposed modification or
whether you feel strongly we should go with your original fix.

In any case, I think your fix looks like the right thing to do.

Reviewed-by: Alex Elder <elder@inktank.com>



Now let me know if you see anything wrong in the following explanation
of the problem.

The first time a message is sent, it will have been allocated via
ceph_msg_new(), which will initialize both the bio and bio_iter
fields to NULL (and bio_seg to 0).

rbd is an osd client.  It sets up its request queue with
request_queue->request_fn = rbd_rq_fn()
So here's the path that leads to a bio in a message:
  rbd_rq_fn()
  ->rbd_req_{read,write}()
    ->rbd_do_op()
      ->rbd_do_request()
        ->ceph_osdc_alloc_request()

And rbd_osdc_alloc_request() assigns the passed-in bio to req->r_bio
and grabs a reference to it.

Later, ceph_osdc_start_request() will copy the osd request's r_bio
pointer value into the request message that will be sent to the osd
server.  It does not update either of the other two bio-related fields
in that message--in particular, bio_iter is still NULL.

Then, in write_partial_msg_pages(), this code uses the null bio_iter
as an indicator that we're just starting with processing the message
that is currently referred to in con->out_msg, and initializes the
iteration fields.

#ifdef CONFIG_BLOCK
        if (msg->bio && !msg->bio_iter)
                init_bio_iter(msg->bio, &msg->bio_iter, &msg->bio_seg);
#endif

So...

In order for this to work properly, msg->bio_iter needs to be
a null pointer when we're first processing a message in
write_partial_msg_pages().  And that's fine the first time through,
but if a connection failure occurs in the middle of processing
a bio request, and ceph_fault() gets called, all sent messages get
re-queued to be re-sent, and at that point, msg->bio_iter is not
guaranteed to be a null pointer.

(I worked through describing all this because in doing so I can
convince myself I understand the problem enough to know this is
the right fix.)

					-Alex
