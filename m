From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: kill the "trail" portion of message data
Date: Sun, 10 Mar 2013 15:35:15 -0500
Message-ID: <513CEE83.4040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:45316 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3CJUfU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Mar 2013 16:35:20 -0400
Received: by mail-qc0-f172.google.com with SMTP id b25so1252065qca.3
        for <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 13:35:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The trail portion of message data was added to support
two distinct sets of data for an osd request--one a
pagelist for providing parameters to object method
calls; and a second a page array for receiving data
back from the result of such a call.

It's always been a bit of a weird thing bolted onto
a message though, and with the rework of the messenger
code it can now be removed.

This series eliminates the trail by allowing the osd
client to record a (non-trail) pagelist for data, and
using the fact that we now distinguish incoming from
outgoing data to allow that to be specified distinct
from the page array used for the incoming response.

Having done this, we can eliminate the trail from the
ceph message structure, and then that allows some
code to be simplified.

These patches are available in the "review/wip-kill-trail"
branch of the ceph-client git repository.  That branch
is based on branch "review/wip-cursor".

					-Alex

[PATCH 1/4] libceph: have osd requests support pagelist data
[PATCH 2/4] libceph: kill osd request r_trail
[PATCH 3/4] libceph: kill message trail
[PATCH 4/4] libceph: more cleanup of write_partial_msg_pages()

