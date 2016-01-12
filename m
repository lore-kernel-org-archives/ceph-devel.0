From: Sage Weil <sage@newdream.net>
Subject: Re: Build failure on latest master with jemalloc enabled
Date: Mon, 11 Jan 2016 20:58:35 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601112056580.27580@cpach.fuggernut.com>
References: <CO1PR02MB2084E3A447F20BBF7FE1AF4F4C90@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35962 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759787AbcALB6d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jan 2016 20:58:33 -0500
In-Reply-To: <CO1PR02MB2084E3A447F20BBF7FE1AF4F4C90@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 11 Jan 2016, Somnath Roy wrote:
> Hi Sage,
> Latest master build is failing on Bluestore if I enable jemalloc. Problem is, we have to disable Rocksdb if I want to enable jemalloc and rocksdb is mandatory for Bluestore.
> What's the way out ? May be building rocksdb with jemalloc ?

Yeah, that sounds like the best path.

It would also be possible to adapt the rocksdb::Env into a leveldb::Env 
and make rocksdb optional, but it probably won't perform as well.

sage
