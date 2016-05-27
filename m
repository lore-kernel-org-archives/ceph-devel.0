From: Haomai Wang <haomai@xsky.com>
Subject: Re: msgr2 protocol
Date: Fri, 27 May 2016 12:41:35 +0800
Message-ID: <CACJqLyYbpFQynVcBFO4E254bvH5R05DvTAw+vfu68ptwa7oSZA@mail.gmail.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0110.outbound.protection.outlook.com ([104.47.126.110]:45705
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753845AbcE0Elu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2016 00:41:50 -0400
Received: by mail-vk0-f46.google.com with SMTP id k1so73859038vka.3
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2016 21:41:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 27, 2016 at 2:17 AM, Sage Weil <sweil@redhat.com> wrote:
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

Does msgrv2 need to talk with v1peer? Or we just reject this handshake?

If we reject v1, is it possible give our a chance to reset message version?

>
> 2. The auth handshake is a low-level msgr exchange now.  This more or less
> matches the MAuth and MAuthReply exchange with the mon.  Also, the
> authenticator/ticket presentation for established clients can be sent here
> as part of this exchange, instead of as part of the msg_connect and
> msg_connect_reply exchnage.

S: TAG_AUTH_METHODS          # list methods
    __le32 num_methods;
    __le32 methods[num_methods];   // CEPH_AUTH_{NONE, CEPHX}

From my view, it looks we need to force a method instead of letting
peer side select? What's use case that we allow client side to decide
method?

>
> 3. The identification of peers during connect is moved to the TAG_IDENT
> stage.  This way it could happen after authentication and/or encryption,
> if we like.  (Not sure it matters.)

C or S: TAG_ENCRYPT_BEGIN    # signal that all subsequent traffic will
be encrypted

__le32 len

<method specific payload>

do we also need encrypt info handshake? like key/algorithm?

>
> 4. Signatures are a separate message now that follows the previous
> message.  If a message doesn't have a signature that follows, it is
> dropped.  Once authenticated we can sign all the other handshake exchanges
> (TAG_IDENT, etc.) as well as the messages themselves.
>
> 5. The reconnect behavior for stateful connections is a separate
> exchange. This keeps the stateless connections free of clutter.

It will be a big task ......

>
> 6. A few changes in the auth_none and cephx integratoin will be needed.
> For example, all the current stubs assume that authentication happens over
> MAuth message and authorization happens in an authorizer blob in
> ceph_msg_connect.  Now both are part of TAG_AUTH_REQUEST, so we'll need to
> multiplex the cephx message blobs. Also, because the IDENT exchanges
> happens later, we may need to pass additional info in the auth handshake
> messages (like the peer type, or whatever else is needed).

Hmm, only need peer type? if address is needed, IDENT stage must
happen before auth

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

we may also change ceph_msg_header/ceph_msg_footer :

struct ceph_msg_header {
__le64 seq;       /* message seq# for this session */
__le64 tid;       /* transaction id */
__le16 type;      /* message type */
__le16 priority;  /* priority.  higher value == higher priority */
__le16 version;   /* version of message encoding */

__le32 front_len; /* bytes in main payload */
__le32 middle_len;/* bytes in middle payload */
__le32 data_len;  /* bytes of data payload */
__le16 data_off;  /* sender: include full offset;
    receiver: mask against ~PAGE_MASK */

struct ceph_entity_name src;

/* oldest code we think can decode this.  unknown if zero. */
__le16 compat_version;
__le16 reserved;
__le32 crc;       /* header crc32c */
} __attribute__ ((packed));

we may drop middle_len, src thing.

And could we drop footer and move crc to header? Because for each
message, we always add a system call for footer since it can't be
prefetched in userspace memory. Most of rpc impl only add a header to
actual data.

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
