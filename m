From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/13] libceph: cleanups preparing for state cleanup
Date: Wed, 30 May 2012 14:24:44 -0500
Message-ID: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f180.google.com ([209.85.160.180]:47064 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab2E3TYn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:24:43 -0400
Received: by ghbz12 with SMTP id z12so182523ghb.11
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:24:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am working on some fairly big changes to the ceph/RADOS client
messenger code.  The ultimate goal is to simplify the code by
having it more obviously follow a state machine, but getting to
that point isn't necessarily easy.

My approach is to make evolutionary changes, making a long series
of small changes, each of which either produces code that works
identical to before, or which very explicitly fixes a bug or adds
or modifies a feature while continuing to provide functionality
that is equivalent and/or meets what is required.

This series contains a few small batches of changes to begin this
process.  In general they're dependent on each other, so they are
being provided in one series, but I group them below into some
smaller logical subsets.

					-Alex

[PATCH 01/13] libceph: eliminate connection state "DEAD"
[PATCH 02/13] libceph: kill bad_proto ceph connection op
[PATCH 03/13] libceph: delete useless SOCK_CLOSED manipulations
     These three delete dead/unused code

[PATCH 04/13] libceph: rename socket callbacks
[PATCH 05/13] libceph: rename kvec_reset and kvec_add functions
     These two simply rename some symbols.

[PATCH 06/13] libceph: embed ceph messenger structure in ceph_client
[PATCH 07/13] libceph: embed ceph connection structure in mon_client
     These two each change a structure definition so that what was
     once a pointer to a structure becomes instead an embedded
     structure of the pointed-to type.  Doing this makes it obvious
     that the relationship between the containing structure and the
     embedded one is purely one-to-one.

[PATCH 08/13] libceph: start separating connection flags from state
     This identifies a set of values kept in the "state" field and
     records them instead in a new "flags" field, so it is obvious
     the role each plays (whether it's a state diagram state, or
     whether it's a Boolean flag).

[PATCH 09/13] libceph: start tracking connection socket state
     This adds code to explicitly track the state of the socket
     used by a ceph connection.  It begins the process of trying
     to clean up some fuzziness in how the overall state of a
     ceph connection is tracked.

[PATCH 10/13] libceph: provide osd number when creating osd
[PATCH 11/13] libceph: init monitor connection when opening
[PATCH 12/13] libceph: fully initialize connection in con_init()
[PATCH 13/13] libceph: set CLOSED state bit in con_init
     This series moves things around a bit so that all ceph
     connection initialization is done at one time, by code
     defined with the "net/ceph/messenger.c" source file.  It
     also makes explicit that a newly initialized ceph connection
     is in CLOSED state.

