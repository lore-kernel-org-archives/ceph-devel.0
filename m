From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Luminous 12.1.1 upgrade mgr woes
Date: Tue, 18 Jul 2017 21:07:11 +1200
Message-ID: <7d69fde3-6a64-578e-85d4-acbf96ea4ab4@catalyst.net.nz>
References: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:60784
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751322AbdGRJHN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Jul 2017 05:07:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTP id A635C803B7
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 21:07:12 +1200 (NZST)
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([127.0.0.1])
        by localhost (cat-porwal-prod-mail1.servers.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B7OAglN7p3NG for <ceph-devel@vger.kernel.org>;
        Tue, 18 Jul 2017 21:07:11 +1200 (NZST)
Received: from [IPv6:2406:e001:e5d:1:511b:9c7f:8a75:3670] (unknown [IPv6:2406:e001:e5d:1:511b:9c7f:8a75:3670])
        (Authenticated sender: mark.kirkwood@catalyst.net.nz)
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id 87457803B5
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 21:07:11 +1200 (NZST)
In-Reply-To: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 18/07/17 21:03, Mark Kirkwood wrote:

> So it all worked ok *except* for the the mgr deploy, this hang at the 
> key/caps modification stage (see attached). 

Hmm - sorry, managed to leave off the important bit of the log:
[ceph1][WARNIN] No data was received after 300 seconds, disconnecting...

