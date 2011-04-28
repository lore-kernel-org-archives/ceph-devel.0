From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Ideas on NSS vs fork?
Date: Thu, 28 Apr 2011 14:29:02 -0700
Message-ID: <20110428212902.GA3932@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35276 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab1D1V3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 17:29:00 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 372802C166
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 14:29:00 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

NSS, the crypto library Red Hat likes to use, cannot tolerate
forks. NSS_NoDB_Init must be called after daemonization, and there
seems to be no way around it; for example, calling it again is
explicitly forbidden.

The code in branch wip-nss-vs-fork adds a common_init_daemonized
function, that things that (potentially) daemonize must call, after
the point where they'd daemonize. Non-daemons are handled in
common_preinit and need nothing special.

Users of libceph/librados cannot fork, and expect to keep using the
library :(

The "remove this" comment on libceph_initialized cannot be blindly
acted on; similar logic could be pushed down into ceph::crypto::init,
though.

This is ugly, but it's the best I could do. Please go through the code
and let me know if you have any ideas on how to make it less painful.

In the meanwhile, if you need NSS to work, you can always run in
non-daemonizing mode, with -f.


P.S. Please use Crypto++. For my sanity.

-- 
:(){ :|:&};:
