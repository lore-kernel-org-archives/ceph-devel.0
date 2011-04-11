From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Dead code removal
Date: Mon, 11 Apr 2011 11:13:01 -0700
Message-ID: <20110411181301.GB2099@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54518 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab1DKSNB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 14:13:01 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 002B42C173
	for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 11:13:00 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. Last week, I was chasing some confusing things with both Automake
and Ceph internals. Both lead me to a land of dead, rotting code.
I.. ahem.. may have overreacted a bit ;) I just pushed a branch called
"dead-code", that does this:

 95 files changed, 257 insertions(+), 23366 deletions(-)

There's no reason to keep code around that has never compiled, or
hasn't compiled in years, or isn't even attempted to compile, or is
never used, etc etc. If you need it a year from now, it's easy to dig
back out from the version control.

And no, this is not all of the dead code, just the low hanging fruit.

Let me know what you think. If I get encouraging noises, that goes
into master.

-- 
:(){ :|:&};:
