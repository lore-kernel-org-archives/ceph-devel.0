From: Li Wang <liwang@ubuntukylin.com>
Subject: About the blueprint OSD: Transactions
Date: Tue, 03 Mar 2015 17:32:43 +0800
Message-ID: <54F57FBB.6060309@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:57977 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbbCCJla (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 04:41:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, pmcgarry@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,
   We are pretty interested in the multi-object transaction support,
we think it is potencially very useful. we have read your implementation
description, and summarize it as below, please check if our
understanding is correct,

1 client select a master, and sends full txn to master
2 master holds txn in memory, sends PREPAREs to slaves
3 slaves persist PREPARE on the side, send PREPARE_ACK,
   in the case there is a compare-then-write operation,
   and compartion fail, slave will send PREPARE_FAIL instead
4 master collects all PREPARE_ACKs and applies the txn
   and marks txn COMMITTING, in the case a PREPARE_FAIL received,
   master send slaves ROLL_BACK, and the slaves will discard
   the prepared txn
5 once persisted, master send COMMITs to slaves
6 master replies to client COMMITED, to enable client to proceed
   to do other operations except reading the commited data
7 slaves get COMMIT and apply, reply with COMMIT_ACK
8 master collect COMMIT_ACK and reply to client FINISHED, to enable
   client read the data
9 master closes out txn record

We think it manifiests to implement a transaction itself, however,
it did not take into account the cases that concurrent multiple 
transactions,
how to enforce the order and atomicity among the distributed transactions,
how to do locking and dead locking avoidance, it seems there are
some further desgining jobs to do.

We are wondering if you can move this blueprint discussion into a
UTC+8 friendly time, so that we can involve in

Cheers,
Li Wang

