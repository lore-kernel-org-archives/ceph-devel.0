From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] ceph: a few more messenger cleanups
Date: Mon, 18 Jun 2012 10:29:12 -0500
Message-ID: <4FDF4948.10306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:35700 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2FRP3N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:29:13 -0400
Received: by ghrr11 with SMTP id r11so3753039ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:29:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here are a few more messenger cleanup patches.

[PATCH 1/6] libceph: encapsulate out message data setup
[PATCH 2/6] libceph: encapsulate advancing msg page
    These two encapsulate some code involved in sending message data
    into separate functions.
[PATCH 3/6] libceph: don't mark footer complete before it is
    This moves the setting of the "FOOTER_COMPLETE" flag so that it
    doesn't get done until the footer really is complete.
[PATCH 4/6] libceph: move init_bio_*() functions up
    This simply moves two functions, preparing for the next patch.
[PATCH 5/6] libceph: move init of bio_iter
    This makes a message's bio_iter field get initialized when
    the rest of the message is initialized, rather than conditionally
    every time any attempt is made to send message data.
[PATCH 6/6] libceph: don't use bio_iter as a flag
    Because bio_iter is now initialized in the "right" place we no
    longer need to use its value as a flag to determine whether it
    needs initialization.

					-Alex
