From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: queue_transaction interface + unique_ptr
Date: Thu, 3 Dec 2015 00:17:38 +0000
Message-ID: <CO1PR02MB208E42BE84D3D7BF2048668F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0087.outbound.protection.outlook.com ([65.55.169.87]:43956
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755873AbbLCARp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Dec 2015 19:17:45 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sage@newdream.net)" <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage/Sam,
As discussed in today's performance meeting , I am planning to change the queue_transactions() interface to the following.

  int queue_transactions(Sequencer *osr, list<TransactionRef>& tls,
                         Context *onreadable, Context *ondisk=0,
                         Context *onreadable_sync=0,
                         TrackedOpRef op = TrackedOpRef(),
                         ThreadPool::TPHandle *handle = NULL) ;

typedef unique_ptr<Transaction> TransactionRef;


IMO , there is a problem with this approach.

The interface like apply_transaction(), queue_transaction() etc. basically the interfaces taking single transaction pointer and internally forming a list to call the queue_transactions() also needs to be changed to accept TransactionRef which will be *bad*. The reason is while preparing list internally we need to move the uniqueue_ptr and callers won't be aware of that.

Also, now changing every interfaces (and callers) that is taking Transaction* will produce a very big delta (and big testing effort as well). 

So, should we *reconsider* co-existing both  queue_transactions() interfaces and call the new one from the IO path ?

Thanks & Regards
Somnath



