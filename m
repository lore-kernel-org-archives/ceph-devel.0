From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: BlueStore Transaction + collection
Date: Fri, 15 Jul 2016 16:26:17 +0300
Message-ID: <72b5e465-8f28-5dfc-93e7-faec310264ed@mirantis.com>
References: <BL2PR02MB2115BF3FDC6BE2CC21A1DF51F4330@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32944 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbcGON0T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jul 2016 09:26:19 -0400
Received: by mail-lf0-f49.google.com with SMTP id b199so88448354lfe.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jul 2016 06:26:18 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115BF3FDC6BE2CC21A1DF51F4330@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Somnath,

I suppose there is mandatory 'primary' collection and there might exist 
several 'auxiliary' ones within the transaction. Hence all operations 
act on the same primary collection and can optionally reference 
additional collections(s), e.g. split_collection op. Two independent 
operations on different transactions aren't allowed.
Disclaimer: Everything is IMHO based on brief code analysis.

Igor

On 15.07.2016 3:19, Somnath Roy wrote:
> Hi Sage/Sam,
> I am seeing we are using vector of collections within _txc_add_transaction() (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L5206). I always thought all ops within a transaction will be having same collection id.
> What is the scenario (or use case) where we may have ops with different collection ids within a transaction.
> Also, I saw in BlueStore we are storing the first_collection (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.h#L893)  among these op->cid.
> I couldn't understand the reason as only place we are using that to trim the collection cache during _txc_finish -> _osr_reap_done(). If there is multiple collections within a txc op , why only first one is used.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

