From: Sebastien Han <shan@redhat.com>
Subject: Automate PGs calculation in Ceph?
Date: Thu, 17 Nov 2016 19:14:02 +0100
Message-ID: <CA+HUO7LtJANRqMDC8AsFDp-Fr2u1toafiKX6uCSvjCjC-4MoyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37581 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934096AbcKQSOY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Nov 2016 13:14:24 -0500
Received: by mail-wm0-f54.google.com with SMTP id t79so162157482wmt.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Nov 2016 10:14:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Squid Cybernetic <ceph-devel@vger.kernel.org>

Hey,

I was wondering, since we have PG calc online to decide the right
value for our PGs per pool. The logic seems to be easy and well
understood. Looks like a simple calculation, I don't see anything like
depending on a use case we are changing the value or anything.

Any reason why this logic is not part of Ceph?
Mons know about everything on the cluster and since they manage pool
creations they should be able to take the right decision.

Am I missing something?
Thanks!

-- 
Cheers

––––––
Sébastien Han
Principal Storage Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roquépine - 75008 Paris
