From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:29:34 -0800 (PST)
Message-ID: <1227301575.47269.1320874174786.JavaMail.root@mail-01.cse.ucsc.edu>
References: <Pine.LNX.4.64.1111091323570.31435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37284 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab1KIV3f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:29:35 -0500
In-Reply-To: <Pine.LNX.4.64.1111091323570.31435@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

----- Original Message -----
> From: "Sage Weil" <sage@newdream.net>
>
> Hmm, interesting! In our case we jsut need the inodes in the libceph
> client cache.

I *think* HDFS does an RPC to get this info. So, since the client
calculates this info, we might see big start-up perf. gains with
large files.
