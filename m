From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: qemu-rbd : savevm monitor command don't save vmstate, is it normal ?
Date: Wed, 29 Aug 2012 15:40:08 +0200 (CEST)
Message-ID: <3aa58a4b-8f7f-48ac-8ab7-510924be9e2a@mailpro>
References: <k1ksi5$q2p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41890 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab2H2Nko (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 09:40:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id EBC8718026266
	for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 15:40:13 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlpHF8K+0TIB for <ceph-devel@vger.kernel.org>;
	Wed, 29 Aug 2012 15:40:08 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id B197B180933C9
	for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 15:40:08 +0200 (CEST)
In-Reply-To: <k1ksi5$q2p$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, 

I'm trying to take a full vm state snapshot with savevm monitor command  (qemu 0.12rc1 + rbd 0.48.1)

it seem that vmstate is not saved in the snapshot. (I also don't notice any vm hang during snapshot)
Snapshot of disk is correctly made.



using loadvm monitor command, rollback correctly to disk snapshot but vm hang.


starting qemu with -loadvm snapshotname give
kvm: Error -22 while loading VM state


Is it normal ? Not implemented ?


Regards,

Alexandre
