From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: v0.42 released
Date: Tue, 21 Feb 2012 17:44:19 +0100
Message-ID: <44330873.brIZUrsXEg@pc10>
References: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:55158 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab2BUQvo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Feb 2012 11:51:44 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 96FF110C866
	for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 17:44:24 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Montag, 20. Februar 2012, 10:01:55 schrieb Sage Weil:
> v0.42 is ready!  This has mostly been a stabilization release, with a few
> critical bugs fixed.  There is also an across-the-board change in data
> structure encoding that is not backwards-compatible, but is designed to
> allow future changes to be (both forwards- and backwards-).

Okay, what does that mean for updating from 0.41 to 0.42?

With data structure encodings, do you mean on-disk or on-wire? Am I at risk of 
losing all my data?

Do I have to bring down the entire cluster and restart it, or can I restart it 
piecemeal to avoid downtimes?

Can clients that still use 0.41 libs keep running?

Regards,

        Guido

PS: I'm sorry, I forgot again that this mailing list does not set reply-to 
headers, and accidentally sent this to Sage personally. I'm going to learn it 
one of these days...
