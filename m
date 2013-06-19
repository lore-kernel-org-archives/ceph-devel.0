From: James Harper <james.harper@bendigoit.com.au>
Subject: dynamically move busy pg's to fast storage
Date: Wed, 19 Jun 2013 10:46:08 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B5C218596@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:53575 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933830Ab3FSKqL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 06:46:11 -0400
Received: from [2001:388:e000:712:a5ca:4fd3:14f:ad5d] (helo=BITCOM1.int.sbss.com.au)
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1UpFty-0004HG-A9
	for ceph-devel@vger.kernel.org; Wed, 19 Jun 2013 20:46:10 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Suppose you had two classes of OSD, one fast (eg SSD's or 15K SAS drives) and the other slow (eg 7200RPM SATA drives). The fast storage is expensive so you might not have so much of it. Rather than try and map whole volumes to the best class of storage (eg fast for databases, slow for user files), it would be nice if ceph could monitor activity and move busy pg's to the fast OSD's, and move idle pg's to the slower OSD's.

What I had in mind initially was a daemon external to ceph that would monitor the statistics to determine what pg's were currently being hit hard, and make decisions about placement, moving pg's around to maximise performance. As a minimum such a daemon would need access to the following information:
. read and write count for each pg (to determine io rate)
. class of each osd (fast/slow/etc). Ideally this would be defined as part of the osd definition but an external config file would suffice for a proof of concept.
. an api to actually manually place pg's and not have ceph make its own decisions and move them back (this may the sticking point...)
. a way to make sure that moving pg's didn't break the desired redundancy (tricky?)

A pg with a high write rate would need the primary pg and all replica's on fast storage. A pg with low write but high read rate could have the primary on fast storage and the replica's on slow storage.

From reading the docs it seems ceph doesn't do this already. There is a reweight-by-utilization command which may give some of the same benefit.

Obviously there is a cost to moving pg's around, but it should be fairly easy to balance the cost of moving vs the benefit of having the busy pg's on a fast osd. None of the decisions to move pg's would need to be made particularly quickly, and the rate at which move requests were initiated would be limited to minimise impact.

Is something like this possible? Or useful? (I think it would be if you want to maximise the use of your expensive SSD's) Is a pg a small enough unit for this or too coarse?

Thanks

James

