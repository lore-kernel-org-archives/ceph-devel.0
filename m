From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: regression with poll(2)
Date: Mon, 20 Aug 2012 10:02:05 -0700
Message-ID: <CA+55aFw6S85jR+5zP9W6YykdsTMSVw9T5ibW93Gtx2rjw-b2EA@mail.gmail.com>
References: <alpine.DEB.2.00.1208151226250.15721@cobra.newdream.net>
 <alpine.DEB.2.00.1208191051150.15570@cobra.newdream.net> <20120820090443.GA3275@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59947 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702Ab2HTRC1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 13:02:27 -0400
In-Reply-To: <20120820090443.GA3275@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sage Weil <sage@inktank.com>, David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, Neil Brown <neilb@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, michaelc@cs.wisc.edu, emunson@mgebm.net, Eric Dumazet <eric.dumazet@gmail.com>, Christoph Lameter <cl@linux.com>

On Mon, Aug 20, 2012 at 2:04 AM, Mel Gorman <mgorman@suse.de> wrote:
>
> Can the following patch be tested please? It is reported to fix an fio
> regression that may be similar to what you are experiencing but has not
> been picked up yet.

Andrew, is this in your queue, or should I take this directly, or
what? It seems to fix the problem for Eric and Sage, at least.

           Linus
