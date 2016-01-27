From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Build failure on latest master with jemalloc enabled
Date: Wed, 27 Jan 2016 00:22:39 +0000
Message-ID: <CO1PR02MB208BDDA41DF07B13BA967DBF4D90@CO1PR02MB208.namprd02.prod.outlook.com>
References: <CO1PR02MB2084E3A447F20BBF7FE1AF4F4C90@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1601112056580.27580@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0076.outbound.protection.outlook.com ([65.55.169.76]:7728
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751190AbcA0AWn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 19:22:43 -0500
In-Reply-To: <alpine.DEB.2.11.1601112056580.27580@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,
Created the following pull request to address this..

https://github.com/ceph/ceph/pull/7368

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Monday, January 11, 2016 5:59 PM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: Re: Build failure on latest master with jemalloc enabled

On Mon, 11 Jan 2016, Somnath Roy wrote:
> Hi Sage,
> Latest master build is failing on Bluestore if I enable jemalloc. Problem is, we have to disable Rocksdb if I want to enable jemalloc and rocksdb is mandatory for Bluestore.
> What's the way out ? May be building rocksdb with jemalloc ?

Yeah, that sounds like the best path.

It would also be possible to adapt the rocksdb::Env into a leveldb::Env and make rocksdb optional, but it probably won't perform as well.

sage
