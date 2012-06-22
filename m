From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/9] another batch of messenger patches
Date: Fri, 22 Jun 2012 17:44:04 -0500
Message-ID: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34486 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2FVWoF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:44:05 -0400
Received: by ghrr11 with SMTP id r11so1974731ghr.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:44:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Here is another set of small (though not necessarily trivial)
patches to the ceph client messenger code.

They are all the result of recent work that was aimed at making
the messenger code more clearly based on independent states, in
hopes of making the result a bit simpler and more reliable.

Most of these involve making what happens when a connection
reset or closed get handled a bit more completely and/or
consistently.

					-Alex

[PATCH 1/9] libceph: encapsulate and document connect sequence
[PATCH 2/9] libceph: encapsulate and document negotiation phase
    Each of these moves some blocks of code into their own functions,
    and adds a lot of commentary about what's going on during the
    connect sequence.

[PATCH 3/9] libceph: close the connection's socket on reset
    Resetting a connection clears all connection state, but never
    actually closes the socket.  Now it will.

[PATCH 4/9] libceph: don't close socket in OPENING state
    This removes the unnecessary call to con_close_socket() when
    a socket is found to be in OPENING state.

[PATCH 5/9] libceph: change TAG_CLOSE handling
[PATCH 6/9] libceph: kill fail_protocol()
    These let the normal fault handling code take care of the receipt
    of a CLOSE tag from the peer, or of one of the other tags that
    can be sent to indicate a connection problem.

[PATCH 7/9] libceph: close connection on reset tag
    This causes a more complete reset to occur when a RESETSESSION
    tag is received.

[PATCH 8/9] libceph: close connection on connect failure
    This removes the unnecessary call to con_close_socket() when
    a socket is found to be in CLOSED state.  (Probably should
    have been moved up next to patch 4/9, above.)

[PATCH 9/9] libceph: set CONNECTING state even earlier
    This sets the state of a connection to CONNECTING earlier
    than it was occurring before.
