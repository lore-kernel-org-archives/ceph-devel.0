From: Sage Weil <sweil@redhat.com>
Subject: msgr2 protocol
Date: Thu, 26 May 2016 14:17:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbcEZSRQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2016 14:17:16 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D1B84944D
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2016 18:17:16 +0000 (UTC)
Received: from cpach (ovpn-112-33.phx2.redhat.com [10.3.112.33])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4QIHD8p030470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2016 14:17:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I wrote up a basic proposal for the new msgr2 protocol:

	http://pad.ceph.com/p/msgr2

It is pretty similar to the current protocol, with a few key changes:

1. The initial banner has a version number for protocl features supported 
and required.  This will allow optional behavior later.  The current 
protocol doesn't allow this (the banner string is fixed and has to match 
verbatim).

2. The auth handshake is a low-level msgr exchange now.  This more or less 
matches the MAuth and MAuthReply exchange with the mon.  Also, the 
authenticator/ticket presentation for established clients can be sent here 
as part of this exchange, instead of as part of the msg_connect and 
msg_connect_reply exchnage.

3. The identification of peers during connect is moved to the TAG_IDENT 
stage.  This way it could happen after authentication and/or encryption, 
if we like.  (Not sure it matters.)

4. Signatures are a separate message now that follows the previous 
message.  If a message doesn't have a signature that follows, it is 
dropped.  Once authenticated we can sign all the other handshake exchanges 
(TAG_IDENT, etc.) as well as the messages themselves.

5. The reconnect behavior for stateful connections is a separate 
exchange. This keeps the stateless connections free of clutter.

6. A few changes in the auth_none and cephx integratoin will be needed.  
For example, all the current stubs assume that authentication happens over 
MAuth message and authorization happens in an authorizer blob in 
ceph_msg_connect.  Now both are part of TAG_AUTH_REQUEST, so we'll need to 
multiplex the cephx message blobs. Also, because the IDENT exchanges 
happens later, we may need to pass additional info in the auth handshake 
messages (like the peer type, or whatever else is needed).

7. Lots of messages can go either way, and I tried ot avoid a strict 
request/response model so that things could be pipelined, and we'd spend a 
minimal amount of time waiting for a response from the other end.  For 
example,

C:
 initiates connection
S:
 accepts connection
 -> banner
 -> TAG_AUTH_METHODS
C:
 -> banner
 -> TAG_AUTH_SET_METHOD
 -> TAG_AUTH_AUTH_REQUEST
S:
 -> TAG_AUTH_REPLY
C:
 -> TAG_ENCRYPT_BEGIN
 -> TAG_IDENT
 -> TAG_SIGNATURE
S:
 -> TAG_ENCRYPT_BEGIN
 -> TAG_IDENT
 -> TAG_SIGNATURE
C:
 -> TAG_START
 -> TAG_SIGNATURE
 -> TAG_MSG
 -> TAG_SIGNATURE
    ...
S:
 -> TAG_MSG
 -> TAG_SIGNATURE
    ...

Comments, please!  The exhange is a bit less structured as far as who 
sends what message, with the idea that we could pipeline a lot of it, but 
it may end up being too ambiguous.  Let me know what you think...

sage
