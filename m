From: Somnath Roy <its.somenath@gmail.com>
Subject: Regarding op_t, local_t
Date: Wed, 18 Nov 2015 16:59:49 -0800
Message-ID: <CAH0kLp-PZZD5ze7sXGds5NmyRDvffRaG03KdHUZBr3i=prZ7SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34814 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbbKSA7u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 19:59:50 -0500
Received: by igvg19 with SMTP id g19so1370916igv.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 16:59:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sage,
I saw we are now having single transaction in submit_transaction. But,
in the replication path we are still having two transaction, can't we
merge it to one there ?

Thanks & Regards
Somnath
