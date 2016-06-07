From: Sage Weil <sage@newdream.net>
Subject: Re: Anybody else hitting this panic in latest master with
 bluestore?
Date: Tue, 7 Jun 2016 09:05:43 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606070903500.6221@cpach.fuggernut.com>
References: <CY1PR0201MB1820F45DA0E891966F2CBC42855D0@CY1PR0201MB1820.namprd02.prod.outlook.com> <BL2PR02MB2115D774BB2D4CFC43F8C847F45D0@BL2PR02MB2115.namprd02.prod.outlook.com> <8dd167e2-89c2-84dc-fee1-216be0dc6392@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43280 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbcFGNFS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 09:05:18 -0400
In-Reply-To: <8dd167e2-89c2-84dc-fee1-216be0dc6392@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 7 Jun 2016, Mark Nelson wrote:
> I believe this is due to the rocksdb submodule update in PR #9466.  I'm
> working on tracking down the commit in rocksdb that's causing it.

Is it possible that the problem is that your build *didn't* update 
rocksdb?

The ceph makefile isn't smart enough to notice changes in the rocksdb/ dir 
and rebuild.  You have to 'cd rocksdb ; make clean ; cd ..' after the 
submodule updates to get a fresh build.

Maybe you didn't do that, and some of the ceph code is build using the new 
headers and data structures that don't match the previously compiled 
rocksdb code?

sage
