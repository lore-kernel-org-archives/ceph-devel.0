From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Hadoop on ceph
Date: Sat, 17 Mar 2012 13:18:57 -0700
Message-ID: <40A32C8E-D8D2-47DE-A679-2A5749F167AF@cs.ucsc.edu>
References: <4F623EB9.1000901@genome.wustl.edu> <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com> <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net> <DB33BD3B-B4FB-492F-B099-BECF0ED6764A@cs.ucsc.edu> <CAADCt4LBvF-oKpWRx9WO1zFnCqPRr_8EPmnv-qZqWY4jLq0-AQ@mail.gmail.com> <F0C7EFD2944442DFBB761475E0133398@dreamhost.com> <CAADCt4LfqtZ4_70TtBnwsXE+2WMBae1TLFXM86mzRFqx2zN9PQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37916 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab2CQUS7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Mar 2012 16:18:59 -0400
In-Reply-To: <CAADCt4LfqtZ4_70TtBnwsXE+2WMBae1TLFXM86mzRFqx2zN9PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org


On Mar 17, 2012, at 10:50 AM, Andrey Stepachev wrote:

> Hadoop read also better. Hadoop can read locally from replica.

Although not heavily tested yet, reading from replicas should be
working for Ceph.

- Noah

