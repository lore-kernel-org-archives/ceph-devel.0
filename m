From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Minor doc nits for Luminous upgrade
Date: Wed, 28 Jun 2017 13:07:33 +1200
Message-ID: <a29ea0cb-a1b8-9c26-ae4c-9ff91ba6a917@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:53720
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751693AbdF1BQy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 21:16:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTP id EBF6B802B9
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 13:07:35 +1200 (NZST)
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([127.0.0.1])
        by localhost (cat-porwal-prod-mail1.servers.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FzPcnAnljihQ for <ceph-devel@vger.kernel.org>;
        Wed, 28 Jun 2017 13:07:33 +1200 (NZST)
Received: from [192.168.1.64] (122-62-60-69.jetstream.xtra.co.nz [122.62.60.69])
        (Authenticated sender: mark.kirkwood@catalyst.net.nz)
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id B765B802C9
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 13:07:33 +1200 (NZST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've just done an upgrade from Jewel to Luminous following 
http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken 
. Generally nice and easy to follow, but there are a couple of 
(fortunately very obvious) instructions that are wrong:

1/ Mon feature list

<# ceph mon feature ls
 ># ceph mon feature list

2/ Osd restart

<# systemctl ceph-osd.target
 ># systemctl restart ceph-osd.target

Otherwise all good.

Cheers


Mark

