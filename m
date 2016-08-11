From: Sage Weil <sage@newdream.net>
Subject: Re: potential issue with Bluestore collection_list
Date: Thu, 11 Aug 2016 19:44:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608111943090.17762@piezo.us.to>
References: <8231b124-5e67-aa5a-98c3-e8a5c5ddaac7@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53523 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbcHKTol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 15:44:41 -0400
In-Reply-To: <8231b124-5e67-aa5a-98c3-e8a5c5ddaac7@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Aug 2016, Igor Fedotov wrote:
> Looks like BlueStore::collection_list method makes my day today :)
> 
> While playing with new objectstore fio plugin (see
> https://github.com/ceph/ceph/pull/10267) I observed BlueStore fsck reports
> errors on restart. And completion if properly configured.
> 
> After significant test case simplification it appeared that BlueStore::fsck
> detects duplicate nid at the storage. More analysis showed that in fact it's
> Bluestore::collection_list who returned duplicate entities.
> 
> I have some gaps in my collection/object naming scheme understanding hence I
> can't say definitely if fio assigns collection names properly. IMHO it's
> rather an issue in BlueStore::collection_list.
> 
> Here is pretty simple (hopefully) log (2 collections and 2 objects total) each
> showing the case.
> 
> IMHO the issue somewhere below the following line:
> 
> 2016-08-11 18:30:44.595101 7fbe78f39780  1 bluestore(./fio-bluestore) fsck
> collection 281474976710656.0_head
> 
> where both object keys are reported.
> 
> Sage, could you please take a look and comment.

I think this is the problem:

2016-08-11 18:30:44.595104 7fbe78f39780 20 bluestore(./fio-bluestore) collection_list range '--'0x7ffefffffffffffe00000000'.' to '--'0x7ffefffffffffffeffffffff':' and '--'0x800100000000000000000000'.' to '--'0x8001000000000000ffffffff':' start GHMIN

for the .0 collection it is scanning the hash range that includes the 
.1 collection.  That's because create_collection is being passed a bit 
'bits' value:

2016-08-11 18:30:43.697022 7fbe78f39780 15 bluestore(./fio-bluestore) _create_collection 281474976710656.0_head bits 0
2016-08-11 18:30:43.697037 7fbe78f39780 10 bluestore(./fio-bluestore) _create_collection 281474976710656.0_head bits 0 = 0
2016-08-11 18:30:43.697038 7fbe78f39780 15 bluestore(./fio-bluestore) _create_collection 281474976710656.1_head bits 0
2016-08-11 18:30:43.697042 7fbe78f39780 10 bluestore(./fio-bluestore) _create_collection 281474976710656.1_head bits 0 = 0

Since there are 2 collections, we need (at least) 1 significant bit.

sage
