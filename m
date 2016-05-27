From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: msgr2 protocol
Date: Fri, 27 May 2016 02:44:54 -0700
Message-ID: <CADRKj5T7bqCLU+Sua60EYS-Ah2-SiRtMCDccKru_aANfiyijaA@mail.gmail.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33013 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbcE0Jo4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2016 05:44:56 -0400
Received: by mail-vk0-f41.google.com with SMTP id r140so136807713vkf.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2016 02:44:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 26, 2016 at 11:17 AM, Sage Weil <sweil@redhat.com> wrote:
> I wrote up a basic proposal for the new msgr2 protocol:
>
>         http://pad.ceph.com/p/msgr2
>
> It is pretty similar to the current protocol, with a few key changes:
>
> 1. The initial banner has a version number for protocl features supported
> and required.  This will allow optional behavior later.  The current
> protocol doesn't allow this (the banner string is fixed and has to match
> verbatim).
>
> 2. The auth handshake is a low-level msgr exchange now.  This more or less
> matches the MAuth and MAuthReply exchange with the mon.  Also, the
> authenticator/ticket presentation for established clients can be sent here
> as part of this exchange, instead of as part of the msg_connect and
> msg_connect_reply exchnage.
>
> 3. The identification of peers during connect is moved to the TAG_IDENT
> stage.  This way it could happen after authentication and/or encryption,
> if we like.  (Not sure it matters.)
>
> 4. Signatures are a separate message now that follows the previous
> message.  If a message doesn't have a signature that follows, it is
> dropped.  Once authenticated we can sign all the other handshake exchanges
> (TAG_IDENT, etc.) as well as the messages themselves.
>

Is there a reason why the signature needs to be a separate message? It
would add extra overhead, and it seems to me that it would complicate
implementation (in terms of message state and such).

> 5. The reconnect behavior for stateful connections is a separate
> exchange. This keeps the stateless connections free of clutter.
>
> 6. A few changes in the auth_none and cephx integratoin will be needed.
> For example, all the current stubs assume that authentication happens over
> MAuth message and authorization happens in an authorizer blob in
> ceph_msg_connect.  Now both are part of TAG_AUTH_REQUEST, so we'll need to
> multiplex the cephx message blobs. Also, because the IDENT exchanges
> happens later, we may need to pass additional info in the auth handshake
> messages (like the peer type, or whatever else is needed).
>
> 7. Lots of messages can go either way, and I tried ot avoid a strict
> request/response model so that things could be pipelined, and we'd spend a
> minimal amount of time waiting for a response from the other end.  For
> example,
>
> C:
>  initiates connection
> S:
>  accepts connection
>  -> banner
>  -> TAG_AUTH_METHODS
> C:
>  -> banner
>  -> TAG_AUTH_SET_METHOD
>  -> TAG_AUTH_AUTH_REQUEST
> S:
>  -> TAG_AUTH_REPLY
> C:
>  -> TAG_ENCRYPT_BEGIN
>  -> TAG_IDENT
>  -> TAG_SIGNATURE

Can we have the client start authenticating with some predetermined
auth params, and resort to having the server responding with
AUTH_METHODS only if it doesn't support the method selected by the
client. Even if not having it preconfigured, the auth method usually
doesn't change across connection instances, so we can have the client
cache that info per server. That would then be something like this:

a first connection:

C:
 initiates connection
 -> banner
 -> TAG_AUTH_GET_METHODS <-- be explicit
 -> TAG_AUTH_SET_METHOD  <-- opportunistically trying a specific
method type anyway
 -> TAG_AUTH_AUTH_REQUEST

S:
 accepts connection
 -> banner
 -> TAG_AUTH_REPLY


a followup connection:


C:
 initiates connection
 -> banner
 -> TAG_AUTH_SET_METHOD
 -> TAG_AUTH_AUTH_REQUEST

S:
 accepts connection
 -> banner
 -> TAG_AUTH_REPLY



> S:
>  -> TAG_ENCRYPT_BEGIN
>  -> TAG_IDENT
>  -> TAG_SIGNATURE
> C:
>  -> TAG_START
>  -> TAG_SIGNATURE
>  -> TAG_MSG
>  -> TAG_SIGNATURE
>     ...
> S:
>  -> TAG_MSG
>  -> TAG_SIGNATURE
>     ...
>
> Comments, please!  The exhange is a bit less structured as far as who
> sends what message, with the idea that we could pipeline a lot of it, but
> it may end up being too ambiguous.  Let me know what you think...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
