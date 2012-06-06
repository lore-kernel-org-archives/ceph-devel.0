From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 4/4] libceph: make ceph_con_revoke_message() a msg op
Date: Wed, 06 Jun 2012 06:40:48 -0500
Message-ID: <4FCF41C0.20204@inktank.com>
References: <4FCECD7F.9030002@inktank.com> <4FCECF2C.8010200@inktank.com> <Pine.LNX.4.64.1206052219450.22586@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59605 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2FFLko (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 07:40:44 -0400
Received: by yhmm54 with SMTP id m54so4713939yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 04:40:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206052219450.22586@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/06/2012 12:22 AM, Sage Weil wrote:
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> > index 79f3032..a036141 100644
>> > --- a/net/ceph/messenger.c
>> > +++ b/net/ceph/messenger.c
>> > @@ -2456,17 +2456,24 @@ void ceph_msg_revoke(struct ceph_msg *msg)
>> >  /*
>> >   * Revoke a message that we may be reading data into
>> >   */
>> > -void ceph_con_revoke_message(struct ceph_connection *con, struct
>> > ceph_msg *msg)
>> > +void ceph_msg_revoke_incoming(struct ceph_msg *msg)
>> >  {
>> > +	struct ceph_connection *con;
>> > +
>> > +	BUG_ON(msg == NULL);
>> > +	if (!msg->con)
>> > +		return;		/* Message not in our posession */
> This case weirds me out.  I think it can happen, but maybe we should at 
> least get a debug msg, like the no-op one below.
> 
> Reviewed-by: Sage Weil <sage@inktank.com>
> 

I have not been inserting debug messages, but probably should be.
I'm just not accustomed to doing that.

I am not actually convinced this can happen, but did it this way to
match what was happening in the ceph_msg_revoke() case, where
the caller would blindly revoke a message when closing, in case
it was currently queued.

However given how this is used now (only called if an osd_client request
thinks it is waiting for the connection to fill the reply) I see
why it weirds you out--it's conceivable the osd client's notion of
which connection holds the message is out of synch with reality.

I truly want to do away with that osd client's req->r_con_filling_msg
field, which now is kept only for the benefit of reference counting the
ceph_osd...

I will put in a dout() call in this case.

					-Alex
