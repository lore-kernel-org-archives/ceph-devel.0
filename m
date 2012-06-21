From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/12] more libceph changes
Date: Thu, 21 Jun 2012 09:15:32 -0500
Message-ID: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34476 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab2FUOPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:15:34 -0400
Received: by gglu4 with SMTP id u4so489273ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:15:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to wrap up a lot of work I've done recently on the
Ceph client messenger code.  I had a number of loose ends that
never got committed along the way as I narrowed my focus to
things I discovered in the course of development.

I still have a few more, but here is another batch which are
ready to go, having undergone several hours of testing without
any problems.  They are based on the code resulting from this
series, which I submitted the other day:
    [PATCH 0/6] ceph: a few more messenger cleanups

They're a bit of a random collection, but I've put them into
several sort of related groups in the descriptions below.

					-Alex

[PATCH 01/12] libceph: SOCK_CLOSED is a flag, not a state
    This fixes a bug in which the SOCK_CLOSED bit was erroneously
    being manipulated in a ceph connection's "state" field.

[PATCH 02/12] libceph: don't change socket state on sock event
    This moves the setting of a ceph connection's error_msg
    value out of the socket event handler.

[PATCH 03/12] libceph: just set SOCK_CLOSED when state changes
    This makes it so the SOCK_CLOSED bit is set, rather than
    test-and-set, when the underlying Linux socket has closed
[PATCH 04/12] libceph: don't touch con state in con_close_socket()
    This drops the slightly puzzling setting and clearing of
    the SOCK_CLOSED bit in con_close_socket()

[PATCH 05/12] libceph: clear CONNECTING in ceph_con_close()
    This takes a step toward making the state bits always
    reflect the real state of a connection.
[PATCH 06/12] libceph: clear NEGOTIATING when done
    The NEGOTIATING state was never getting cleared until just
    before a new connection attempt was initiated.
[PATCH 07/12] libceph: define and use an explicit CONNECTED state
    This just defines a state to reflect when a ceph connection
    is fully connected to its peer.

[PATCH 08/12] libceph: separate banner and connect writes
    This splits up how some connection negotiation information
    gets sent when a client initiates a new connect sequence.
[PATCH 09/12] libceph: distinguish two phases of connect sequence
    This makes the banner and IP exchange portion of a connect
    sequence get treated as distinct state (NEGOTIATING), rather
    than being a sort of sub-state of CONNECTING.

[PATCH 10/12] libceph: small changes to messenger.c
    This just gathers a number of minor cleanups.
[PATCH 11/12] libceph: make ceph_con_get() (etc.) private
    This makes ceph_con_get() and ceph_con_put() have static
    scope, since they are only used in "messenger.c".
[PATCH 12/12] libceph: add some fine ASCII art
    This inserts a state diagram for a ceph connection socket
    into comments in "messenger.c".
