From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v2 3/3] libceph: handle dead tcp connections during
 connection negotiation
Date: Sun, 26 Jan 2014 08:32:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401260823440.18304@cobra.newdream.net>
References: <1390302667-8729-1-git-send-email-ilya.dryomov@inktank.com> <1390302667-8729-4-git-send-email-ilya.dryomov@inktank.com> <alpine.DEB.2.00.1401241502010.2149@cobra.newdream.net> <CALFYKtDoPBddGcXu5crtcmTStstCOYNo7JK_0YeqLgyA4seakQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49063 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbaAZQcO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Jan 2014 11:32:14 -0500
In-Reply-To: <CALFYKtDoPBddGcXu5crtcmTStstCOYNo7JK_0YeqLgyA4seakQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 26 Jan 2014, Ilya Dryomov wrote:
> On Sat, Jan 25, 2014 at 1:07 AM, Sage Weil <sage@inktank.com> wrote:
> > On Tue, 21 Jan 2014, Ilya Dryomov wrote:
> >> Keepalive mechanism that we are currently using doesn't handle dead
> >> (e.g. half-open in RFC 793 sense) TCP connections: a) it's based on
> >> pending ceph_osd_requests which are not necessarily present, and b)
> >> keepalive byte is only sent if connection is in CON_STATE_OPEN state
> >> because of protocol restrictions.  This does not cover connection
> >> handshake and negotiation stages and can lead to kernel client hanging
> >> forever.  Fix it by forcibly resetting the connection if after two
> >> mount_timeouts we still haven't transitioned to CON_STATE_OPEN.
> >>
> >> Fixes: http://tracker.ceph.com/issues/7139
> >>
> >> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> >> ---
> >>  include/linux/ceph/messenger.h |    5 +++++
> >>  net/ceph/ceph_common.c         |    1 +
> >>  net/ceph/messenger.c           |   42 ++++++++++++++++++++++++++++++++++++++--
> >>  3 files changed, 46 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> >> index 20ee8b63a968..25d3ec8bcdde 100644
> >> --- a/include/linux/ceph/messenger.h
> >> +++ b/include/linux/ceph/messenger.h
> >> @@ -62,6 +62,8 @@ struct ceph_messenger {
> >>
> >>       u64 supported_features;
> >>       u64 required_features;
> >> +
> >> +     unsigned long connect_timeout;  /* jiffies */
> >>  };
> >>
> >>  enum ceph_msg_data_type {
> >> @@ -240,6 +242,8 @@ struct ceph_connection {
> >>
> >>       struct delayed_work work;           /* send|recv work */
> >>       unsigned long       delay;          /* current delay interval */
> >> +
> >> +     struct delayed_work connect_timeout_work;
> >>  };
> >>
> >>
> >> @@ -257,6 +261,7 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
> >>                       struct ceph_entity_addr *myaddr,
> >>                       u64 supported_features,
> >>                       u64 required_features,
> >> +                     unsigned long connect_timeout,
> >>                       bool nocrc);
> >>
> >>  extern void ceph_con_init(struct ceph_connection *con, void *private,
> >> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> >> index 67d7721d237e..bc41e5a392a4 100644
> >> --- a/net/ceph/ceph_common.c
> >> +++ b/net/ceph/ceph_common.c
> >> @@ -511,6 +511,7 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
> >>       ceph_messenger_init(&client->msgr, myaddr,
> >>               client->supported_features,
> >>               client->required_features,
> >> +             2 * client->options->mount_timeout * HZ,
> >
> > Any specific reason for 2x?  I would like 1/2 if I had to pull a number
> > out of a hat.  OTOH, mount_timeout could be 0, too, so it might make more
> > sense to make this a separate mount option entirely.  Either that, or just
> > make this a separate hard-coded value that is not related to
> > mount_timeout.
> 
> Yes, my logic for 2x was basically to not impose anything on the rest
> the system.  Apart from some cephfs-specific stuff, mount_timeout is
> used in __ceph_open_session, where 1/2 would theoretically interfere
> with the wait-for-maps loop by virtue of shutting down the socket too
> early.

If this is essentially manifesting as a socket reset/disconnect, then 
having it at 1/2 should trigger a ceph_fault and then reconnect within the 
messenger layer and give us a second chance before the mount_timeout 
expires.  At least, that's the way I'm reading the con_work:

		if ((fault = con_sock_closed(con))) {
			dout("%s: con %p SOCK_CLOSED\n", __func__, con);
			break;
		}

...

	if (fault)
		con_fault(con);

I still lean toward a separately defined timeout here...

> On mount_timeout=0 connect_timeout hammer isn't armed.  This was useful
> in testing, and it doesn't seem to change existing semantics at all.
> On the contrary, as it is, mount_timeout == 0 is a possible infinite
> loop anyway, so not arming connect_timeout (i.e. not defending against
> another endless hang) maps onto it quite nicely ;)

Sounds good.

sage
