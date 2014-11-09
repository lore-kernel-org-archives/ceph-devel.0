From: Sage Weil <sage@newdream.net>
Subject: ObjectStore collections
Date: Sat, 8 Nov 2014 20:59:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411081042010.15135@cobra.newdream.net>
References: <C8CF870384EBCF4CAB89D2041A5C80B30119DCC8@SHSMSX101.ccr.corp.intel.com> <CACJqLyaL4COg6CvkNF1jm_uZSrN96mP7SmvkO0FaZRZEN_r9vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34121 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaKIE7y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Nov 2014 23:59:54 -0500
In-Reply-To: <CACJqLyaL4COg6CvkNF1jm_uZSrN96mP7SmvkO0FaZRZEN_r9vQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "Xue, Chendi" <chendi.xue@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 8 Nov 2014, Haomai Wang wrote:
> As for OOM, I think the root cause is the mistake commit above too.
> Because "meta" collection will be updated each transaction and
> StripObjectHeader::buffers will be always kept in memory because of
> the strategy of cache. So this object's buffers will keep in
> increasing all the time. So I think if we avoid cache "meta"
> collection's object will just be fine. Although we don't observe OOM
> for previous release except this mistake commit, I prefer to add codes
> to discard "buffers" each submit transaction time to avoid potential
> unpredicted memory growing.
> 
> Do you have a more clear impl about it? I'm just thinking a better way
> to solve the performance bottleneck for "meta" collections.

I would really like to see if we can eliminate collections from the API 
entirely.  Or, perhaps more importantly, if that would be helpful.  For 
the most part, hobject_t's already sort themselves into collections based 
on the hash.  The exceptions are:

- The 'meta' collection.  Mostly this includes the pg logs and pg info 
objects (which are per-pg and would otherwise need no locking) and the 
osdmap objects.

- collection_move and collection_move_rename.  I think if we move 
everything to collection_move_rename and use temporary objects with 
unique names for everything (I think in-progress recovery objects is 
the main user of collection_move) then this really just turns into a 
rename operation.

- object listing is currently in terms of pg, but could just as easily 
specify a hash range.

- collection attributes can be moved to the pginfo objects.

It sounds like the problem in KeyValueStore is that the pglog/pginfo 
objects are written by transactions in all PGs but the per-collection 
index/cache structures weren't being locked.  If we can find a way to fit 
these into the sorted hash in the right position that is conceptually 
simpler.  But I'm not sure if that simplicity actually helps with the 
implementation, where the data structure locking is the important part.  
Perhaps we need to keep a collection concept simply for that purpose and 
the only real problem is 'meta'?

sage
