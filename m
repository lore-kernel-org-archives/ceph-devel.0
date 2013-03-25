From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: implement RECONNECT_SEQ feature
Date: Mon, 25 Mar 2013 08:45:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303250842010.10753@cobra.newdream.net>
References: <1363733312-26760-1-git-send-email-sage@inktank.com> <51504F29.5020703@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48048 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504Ab3CYPpT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 11:45:19 -0400
In-Reply-To: <51504F29.5020703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 25 Mar 2013, Alex Elder wrote:
> On 03/19/2013 05:48 PM, Sage Weil wrote:
> > This is an old protocol extension that allows the client and server to
> > avoid resending old messages after a reconnect (following a socket error).
> > Instead, the exchange their sequence numbers during the handshake.  This
> > avoids sending a bunch of useless data over the socket.
> > 
> > It has been supported in the server code since v0.22 (Sep 2010).
> 
> OK, a few comments below, but this looks good to me.
> Make the suggested (or implied) changes below if you
> like, but either way:
> 
> Reviewed-by: Alex Elder <elder@inktank.com>
> 
> > Signed-off-by: Sage Weil <sage@inktank.com>
> > ---
> >  include/linux/ceph/ceph_features.h |    2 ++
> >  include/linux/ceph/msgr.h          |    1 +
> >  net/ceph/messenger.c               |   47 +++++++++++++++++++++++++++++++++---
> >  3 files changed, 46 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> > index 76554ce..4c420803 100644
> > --- a/include/linux/ceph/ceph_features.h
> > +++ b/include/linux/ceph/ceph_features.h
> > @@ -41,6 +41,7 @@
> >   */
> >  #define CEPH_FEATURES_SUPPORTED_DEFAULT  \
> >  	(CEPH_FEATURE_NOSRCADDR |		\
> > +	 CEPH_FEATURE_RECONNECT_SEQ |		\
> >  	 CEPH_FEATURE_PGID64 |			\
> >  	 CEPH_FEATURE_PGPOOL3 |			\
> >  	 CEPH_FEATURE_OSDENC |			\
> > @@ -51,6 +52,7 @@
> >  
> >  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
> >  	(CEPH_FEATURE_NOSRCADDR |	 \
> > +	 CEPH_FEATURE_RECONNECT_SEQ |	 \
> >  	 CEPH_FEATURE_PGID64 |		 \
> >  	 CEPH_FEATURE_PGPOOL3 |		 \
> >  	 CEPH_FEATURE_OSDENC)
> 
> Is it really a required feature?

I suppose not, but it's been present since v0.32 or something crazy-old, 
so there's not much point in considering the not-supported version.  The 
only way to really test it would be to misreport whether the client 
supports it, so I'm not sure it's worth the effort.
 
> If the other end doesn't support it is there any
> reason we can't fall back to the old behavior?
> 
> This code is only *responding* to a SEQ tag, it doesn't
> initiate one.  If one is never sent by the server the
> behavior remains correct, just slower.
> 
> I also have two points you might help clarify for me:
> - Is this a server initiated feature, or could a client
>   send it?

The server initiates.

> - Because it's a tagged bit of message data it really
>   could occur at any time--though at the end of a
>   reconnect negotiation is where it's valuable.  Correct?

True, although the server never does that.

I'll combine those blocks below and then push.  Thanks!
sage

> 
> > diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
> > index 680d3d6..3d94a73 100644
> > --- a/include/linux/ceph/msgr.h
> > +++ b/include/linux/ceph/msgr.h
> > @@ -87,6 +87,7 @@ struct ceph_entity_inst {
> >  #define CEPH_MSGR_TAG_BADPROTOVER  10  /* bad protocol version */
> >  #define CEPH_MSGR_TAG_BADAUTHORIZER 11 /* bad authorizer */
> >  #define CEPH_MSGR_TAG_FEATURES      12 /* insufficient features */
> > +#define CEPH_MSGR_TAG_SEQ           13 /* 64-bit int follows with seen seq number */
> >  
> >  
> >  /*
> > diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> > index 997dacc..2bf2806 100644
> > --- a/net/ceph/messenger.c
> > +++ b/net/ceph/messenger.c
> > @@ -1247,6 +1247,24 @@ static void prepare_write_ack(struct ceph_connection *con)
> >  }
> >  
> >  /*
> > + * Prepare to share the seq during handshake
> > + */
> > +static void prepare_write_seq(struct ceph_connection *con)
> > +{
> > +	dout("prepare_write_seq %p %llu -> %llu\n", con,
> > +	     con->in_seq_acked, con->in_seq);
> > +	con->in_seq_acked = con->in_seq;
> > +
> > +	con_out_kvec_reset(con);
> > +
> > +	con->out_temp_ack = cpu_to_le64(con->in_seq_acked);
> > +	con_out_kvec_add(con, sizeof (con->out_temp_ack),
> > +			 &con->out_temp_ack);
> > +
> > +	con_flag_set(con, CON_FLAG_WRITE_PENDING);
> > +}
> > +
> > +/*
> >   * Prepare to write keepalive byte.
> >   */
> >  static void prepare_write_keepalive(struct ceph_connection *con)
> > @@ -1582,6 +1600,13 @@ static void prepare_read_ack(struct ceph_connection *con)
> >  	con->in_base_pos = 0;
> >  }
> >  
> > +static void prepare_read_seq(struct ceph_connection *con)
> > +{
> > +	dout("prepare_read_seq %p\n", con);
> > +	con->in_base_pos = 0;
> > +	con->in_tag = CEPH_MSGR_TAG_SEQ;
> > +}
> > +
> >  static void prepare_read_tag(struct ceph_connection *con)
> >  {
> >  	dout("prepare_read_tag %p\n", con);
> > @@ -2059,6 +2084,7 @@ static int process_connect(struct ceph_connection *con)
> >  		prepare_read_connect(con);
> >  		break;
> >  
> > +	case CEPH_MSGR_TAG_SEQ:
> >  	case CEPH_MSGR_TAG_READY:
> >  		if (req_feat & ~server_feat) {
> >  			pr_err("%s%lld %s protocol feature mismatch,"
> > @@ -2089,7 +2115,12 @@ static int process_connect(struct ceph_connection *con)
> >  
> >  		con->delay = 0;      /* reset backoff memory */
> >  
> > -		prepare_read_tag(con);
> > +		if (con->in_reply.tag == CEPH_MSGR_TAG_SEQ) {
> > +			prepare_write_seq(con);
> > +			prepare_read_seq(con);
> > +		} else {
> > +			prepare_read_tag(con);
> > +		}
> >  		break;
> >  
> >  	case CEPH_MSGR_TAG_WAIT:
> > @@ -2123,7 +2154,6 @@ static int read_partial_ack(struct ceph_connection *con)
> >  	return read_partial(con, end, size, &con->in_temp_ack);
> >  }
> >  
> > -
> >  /*
> >   * We can finally discard anything that's been acked.
> >   */
> > @@ -2148,8 +2178,6 @@ static void process_ack(struct ceph_connection *con)
> >  }
> >  
> >  
> > -
> > -
> >  static int read_partial_message_section(struct ceph_connection *con,
> >  					struct kvec *section,
> >  					unsigned int sec_len, u32 *crc)
> > @@ -2628,6 +2656,17 @@ more:
> >  		if (con->in_base_pos)
> >  			goto more;
> >  	}
> > +	if (con->in_tag == CEPH_MSGR_TAG_SEQ) {
> > +		/*
> > +		 * the final seq exchange is semantically equivalent
> > +		 * to an ACK; re-use those helpers.
> > +		 */
> > +		ret = read_partial_ack(con);
> > +		if (ret <= 0)
> > +			goto out;
> > +		process_ack(con);
> > +		goto more;
> > +	}
> 
> This block (above) is identical to the block a little later on
> that handles CEPH_MSGR_TAG_ACK.  It might be nice to make that
> fact obvious by combining them (and if so, I would say here, not
> below).  (It's OK as-is, however.)
> 
> >  	if (con->in_tag == CEPH_MSGR_TAG_READY) {
> >  		/*
> >  		 * what's next?
> > 
> 
> 
