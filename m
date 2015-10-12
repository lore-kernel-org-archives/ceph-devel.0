From: David Casier <david.casier@aevoo.fr>
Subject: Fwd: [newstore (again)] how disable double write WAL
Date: Mon, 12 Oct 2015 14:50:09 +0200
Message-ID: <561BAC81.5030506@aevoo.fr>
References: <561BABB5.2090209@aevoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 62-210-192-203.rev.poneytelecom.eu ([62.210.192.203]:42452 "EHLO
	aevoo.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbbJLMv2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Oct 2015 08:51:28 -0400
Received: from [172.18.56.197] (LCaen-656-1-144-187.w217-128.abo.wanadoo.fr [217.128.26.187])
	by aevoo.fr (Postfix) with ESMTPSA id E942740212
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 14:51:26 +0200 (CEST)
In-Reply-To: <561BABB5.2090209@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello everybody,
fragment is stored in rocksdb before being written to "/fragments" ?
I separed "/db" and "/fragments" but during the bench, everything is 
writing to "/db"
I changed options "newstore_sync_*" without success.

Is there any way to write all metadata in "/db" and all data in 
"/fragments" ?

-- 


