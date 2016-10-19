From: Sage Weil <sweil@redhat.com>
Subject: Re: Enabling bluestore_sync_transaction
Date: Wed, 19 Oct 2016 02:33:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610190229320.6167@piezo.us.to>
References: <BY2PR02MB3969DEA02369E4890E09208F4D20@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753233AbcJSCdD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Oct 2016 22:33:03 -0400
In-Reply-To: <BY2PR02MB3969DEA02369E4890E09208F4D20@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 19 Oct 2016, Somnath Roy wrote:
> Hi Sage,
> I was trying to benchmark bluestore by enabling bluestore_sync_transaction and it seems the db method in the below code is called wrongly ?
> If we enable bluestore_sync_submit_transaction , shouldn't we be doing db-> submit_transaction_sync() and if we enable only bluestore_sync_transaction shouldn't we be doing db->submit_transaction() ?
> 
> 
> 
>       if (!g_conf->bluestore_sync_transaction) {
> if (g_conf->bluestore_sync_submit_transaction) {
>   _txc_finalize_kv(txc, txc->t);
>   int r = db->submit_transaction(txc->t);
>   assert(r == 0);
> }
>       } else {
> _txc_finalize_kv(txc, txc->t);
> int r = db->submit_transaction_sync(txc->t);
> assert(r == 0);
>       }

This code is pretty broken.  FWIW I did a quick refactor earlier today 
that improves it somewhat, see

	https://github.com/ceph/ceph/pull/11537

and Ma Jianpeng is working on addressing the nid/blobid max issue in this 
PR

	https://github.com/ceph/ceph/pull/11489

(although I think that can be safely ignored for now if you don't restart 
the OSDs).

> We are anyway calling one submit_transaction_sync from _kv_sync_thread().
> 
> Now, if I do that (for bluestore_sync_transaction = true) , I am seeing 
> ~10% performance improvement with min_alloc_size = 16K and seeing much 
> lower cpu usage with _kv_sync_thread. This is also telling us that even 
> if we are not utilizing 100% cpu core for _kv_sync_thread , more work 
> you do from this thread will degrade performance. IMO, 
> bluestore_sync_transaction should be default true if you agree that we 
> should be replacing the *_sync call.

That's great news!  Can you try my PR and see if the result is similar?  
It is still iterating over the txn list in the sync thread but that should 
be very cheap.  If not we can partition the lists.

s
