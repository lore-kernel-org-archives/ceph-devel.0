From: Alex Elder <elder@inktank.com>
Subject: rbd: wrap up of initialization rework
Date: Tue, 30 Oct 2012 16:11:01 -0500
Message-ID: <50904265.2050603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38230 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934561Ab2J3VLF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 17:11:05 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1110383iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 14:11:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These four patches sort of finish out this bunch of patches
that have been reworking how rbd initialization of devices
is done.  With this foundation in place, probing for
parents of layered device fits in fairly neatly.

[PATCH 1/4] rbd: don't pass rbd_dev to rbd_get_client()
    This makes getting a reference to a client not depend
    on a particular rbd_dev.
[PATCH 2/4] rbd: consolidate rbd_dev init in rbd_add()
    This just moves some code around to make the next patch
    simpler.
[PATCH 3/4] rbd: define rbd_dev_{create,destroy}() helpers
    These helpers isolate some initialization and make
    cleanup in error paths easier.
[PATCH 4/4] rbd: encapsulate last part of probe
    This moves a big hunk of code into its own function,
    leaving rbd_add() much shorter and easier to follow.

					-Alex
