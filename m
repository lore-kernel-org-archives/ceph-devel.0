From: Sage Weil <sweil@redhat.com>
Subject: watch/notify changes ready for review
Date: Thu, 13 Nov 2014 17:20:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411131645430.10048@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44265 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934547AbaKNBUW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 20:20:22 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D463D80079
	for <ceph-devel@vger.kernel.org>; Thu, 13 Nov 2014 17:20:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B5BB580079
	for <ceph-devel@vger.kernel.org>; Thu, 13 Nov 2014 17:20:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

My pile of watch/notify changes are ready for review:

	https://github.com/ceph/ceph/pull/2924

This series does a ton of stuff that should make watch/notify more robust, 
useful, and reliable.

Highlights:

 - notify can tell who sent the message
 - notify acks are explicit
 - notify acks can include a payload that is delivered to the notifier
 - notifier can see who got the notify (and their ack payload, if any)
 - various useless arguments are dropped from watch, unwatch, notify calls
 - client/osd protocol now explicitly checks for watch staleness
   (i.e., we reliably detect when we may have missed a notify)
 - clients get an async notification when they were sent a notify but 
didn't ack it in time (not sure yet if this useful)
 - clients get an async notification when the watch was disconnected by 
the osd (timed out or explicitly killed or whatever)
 - clients have a new watch_check() call that synchronously checks for any 
pending errors, or tells us how recently we last confirmed watch liveness 
and notify async delivery.

The last bit is the what lets users draw strong conclusions about what 
notifications they may (not) have received so they can draw real 
conclusions.

Anyway, please take a look!
sage

