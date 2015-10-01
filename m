From: "Curley, Matthew" <matthew.curley@hpe.com>
Subject: Reproducing allocator performance differences
Date: Thu, 1 Oct 2015 15:32:49 +0000
Message-ID: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:57042 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbbJAPeR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Oct 2015 11:34:17 -0400
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id B9EBB1729
	for <ceph-devel@vger.kernel.org>; Thu,  1 Oct 2015 15:34:16 +0000 (UTC)
Received: from G2W4316.americas.hpqcorp.net (g2w4316.austin.hp.com [16.197.9.73])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g2t2352.austin.hp.com (Postfix) with ESMTPS id E083C4D
	for <ceph-devel@vger.kernel.org>; Thu,  1 Oct 2015 15:34:15 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We've been trying to reproduce the allocator performance impact on 4K random reads seen in the Hackathon (and more recent tests).  At this point though, we're not seeing any significant difference between tcmalloc and jemalloc so we're looking for thoughts on what we're doing wrong.  Or at least some suggestions to try out.

More detail here:
https://drive.google.com/file/d/0B2kp18maR7axTmU5WG9WclNKQlU/view?usp=sharing

Thanks for any input!

--MC
