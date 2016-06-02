From: Haomai Wang <haomai@xsky.com>
Subject: Re: msgr2 protocol
Date: Thu, 2 Jun 2016 23:59:35 +0800
Message-ID: <CACJqLybY4Y1t787arDojNa=zLD+LdNMDukEO8yZcV+E2NSxUvA@mail.gmail.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
	<CADRKj5T7bqCLU+Sua60EYS-Ah2-SiRtMCDccKru_aANfiyijaA@mail.gmail.com>
	<alpine.DEB.2.11.1605271333350.4873@cpach.fuggernut.com>
	<CADRKj5QYePLm0Kr241DiiHFy8Sf=G5CMh0OLNyowFR5TZSbXoA@mail.gmail.com>
	<alpine.DEB.2.11.1606021137190.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0104.outbound.protection.outlook.com ([104.47.125.104]:60347
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161105AbcFBP7s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Jun 2016 11:59:48 -0400
Received: by mail-vk0-f48.google.com with SMTP id a6so76942720vkg.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 08:59:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606021137190.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 2, 2016 at 11:43 PM, Sage Weil <sweil@redhat.com> wrote:
> Based on the discussion during CDM yesterday I wrote up a nicer-looking
> spec of the protocol in rst:
>
>         https://github.com/ceph/ceph/pull/9461
>
> Please let me know if this looks right.  I have two questions:
>
> 1. Is TAG_START is really necessary?  I guess it doesn't hurt, and makes
> it easy to add flags later.
>
> 2. We don't explicitly have anything here that indicates a session is
> stateless or stateful.  Currently this is determined by the Policy stuff
> on either end and the peers just happen to agree.  Setting/asserting
> it explicitly has part of the handshake seems like a good idea.  Maybe a
> flags field in the TAG_IDENT message, with a flags for lossy/lossess,
> whether we initiate connections (true for client or p2p servers)?

we already have CEPH_MSG_CONNECT_LOSSY flag when handshake.

>
> sage
>
>
> On Sat, 28 May 2016, Yehuda Sadeh-Weinraub wrote:
>
>> On Fri, May 27, 2016 at 10:37 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Fri, 27 May 2016, Yehuda Sadeh-Weinraub wrote:
>> >> On Thu, May 26, 2016 at 11:17 AM, Sage Weil <sweil@redhat.com> wrote:
>> >> > I wrote up a basic proposal for the new msgr2 protocol:
>> >> >
>> >> >         http://pad.ceph.com/p/msgr2
>> >> >
>> >> > It is pretty similar to the current protocol, with a few key changes:
>> >> >
>> >> > 1. The initial banner has a version number for protocl features supported
>> >> > and required.  This will allow optional behavior later.  The current
>> >> > protocol doesn't allow this (the banner string is fixed and has to match
>> >> > verbatim).
>> >> >
>> >> > 2. The auth handshake is a low-level msgr exchange now.  This more or less
>> >> > matches the MAuth and MAuthReply exchange with the mon.  Also, the
>> >> > authenticator/ticket presentation for established clients can be sent here
>> >> > as part of this exchange, instead of as part of the msg_connect and
>> >> > msg_connect_reply exchnage.
>> >> >
>> >> > 3. The identification of peers during connect is moved to the TAG_IDENT
>> >> > stage.  This way it could happen after authentication and/or encryption,
>> >> > if we like.  (Not sure it matters.)
>> >> >
>> >> > 4. Signatures are a separate message now that follows the previous
>> >> > message.  If a message doesn't have a signature that follows, it is
>> >> > dropped.  Once authenticated we can sign all the other handshake exchanges
>> >> > (TAG_IDENT, etc.) as well as the messages themselves.
>> >> >
>> >>
>> >> Is there a reason why the signature needs to be a separate message? It
>> >> would add extra overhead, and it seems to me that it would complicate
>> >> implementation (in terms of message state and such).
>> >
>> > It doesn't have to be--I was just wanting to keep things simple.  We could
>> > similarly make it part of the underlying format, e.g.,
>> >
>> >  tag byte
>> >  8 byte signature
>> >  payload
>>
>> signature should come after payload, but yeah. Might need to define
>> extended envelope to allow future extensions.
>>
>> >
>> > or whatever.  That's basically the same thing, except we save 1 byte.
>> >
>> >> > 5. The reconnect behavior for stateful connections is a separate
>> >> > exchange. This keeps the stateless connections free of clutter.
>> >> >
>> >> > 6. A few changes in the auth_none and cephx integratoin will be needed.
>> >> > For example, all the current stubs assume that authentication happens over
>> >> > MAuth message and authorization happens in an authorizer blob in
>> >> > ceph_msg_connect.  Now both are part of TAG_AUTH_REQUEST, so we'll need to
>> >> > multiplex the cephx message blobs. Also, because the IDENT exchanges
>> >> > happens later, we may need to pass additional info in the auth handshake
>> >> > messages (like the peer type, or whatever else is needed).
>> >> >
>> >> > 7. Lots of messages can go either way, and I tried ot avoid a strict
>> >> > request/response model so that things could be pipelined, and we'd spend a
>> >> > minimal amount of time waiting for a response from the other end.  For
>> >> > example,
>> >> >
>> >> > C:
>> >> >  initiates connection
>> >> > S:
>> >> >  accepts connection
>> >> >  -> banner
>> >> >  -> TAG_AUTH_METHODS
>> >> > C:
>> >> >  -> banner
>> >> >  -> TAG_AUTH_SET_METHOD
>> >> >  -> TAG_AUTH_AUTH_REQUEST
>> >> > S:
>> >> >  -> TAG_AUTH_REPLY
>> >> > C:
>> >> >  -> TAG_ENCRYPT_BEGIN
>> >> >  -> TAG_IDENT
>> >> >  -> TAG_SIGNATURE
>> >>
>> >> Can we have the client start authenticating with some predetermined
>> >> auth params, and resort to having the server responding with
>> >> AUTH_METHODS only if it doesn't support the method selected by the
>> >> client. Even if not having it preconfigured, the auth method usually
>> >> doesn't change across connection instances, so we can have the client
>> >> cache that info per server. That would then be something like this:
>> >>
>> >> a first connection:
>> >>
>> >> C:
>> >>  initiates connection
>> >>  -> banner
>> >>  -> TAG_AUTH_GET_METHODS <-- be explicit
>> >>  -> TAG_AUTH_SET_METHOD  <-- opportunistically trying a specific
>> >> method type anyway
>> >>  -> TAG_AUTH_AUTH_REQUEST
>> >>
>> >> S:
>> >>  accepts connection
>> >>  -> banner
>> >>  -> TAG_AUTH_REPLY
>> >>
>> >>
>> >> a followup connection:
>> >>
>> >>
>> >> C:
>> >>  initiates connection
>> >>  -> banner
>> >>  -> TAG_AUTH_SET_METHOD
>> >>  -> TAG_AUTH_AUTH_REQUEST
>> >>
>> >> S:
>> >>  accepts connection
>> >>  -> banner
>> >>  -> TAG_AUTH_REPLY
>> >
>> > Yeah.. of even just make the initial connection try it's preferred method
>> > and only do the GET_METHODS if it is rejected.
>> >
>>
>> Right. In any case, the protocol should enable this flexibility.
>>
>>
>> > If you do a connect and immediately write a few bytes to teh TCP stream,
>> > does that actaully translate to fewer packets?  I was guessing that the
>> > server writing the first bytes of the exchange would be fine but if it
>> > speeds things up for the client to optimistically start the exchange too
>> > we may as well...
>> >
>>
>> While haven't really looked at it recently, I don't think it'd be
>> possible to embed data with the SYN packet using the plain vanilla tcp
>> implementation. However, I believe that doing connect() and sending
>> data immediately following it should improve things, specifically if
>> doing async connect (as with the async messenger), but this still
>> needs to be proven.
>>
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
