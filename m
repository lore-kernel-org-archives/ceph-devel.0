From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Jewel regression (not released, but still serious)
Date: Wed, 19 Apr 2017 00:08:34 +0200
Message-ID: <06474a19-6a20-fff5-a6b4-99e8165f61d4@suse.cz>
References: <012d38c3-3347-e62e-3fcd-83be48bfe842@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752910AbdDRWIh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 18:08:37 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A604BABCF
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 22:08:35 +0000 (UTC)
In-Reply-To: <012d38c3-3347-e62e-3fcd-83be48bfe842@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Examining the test yaml again, it seems strange that a test called 
"upgrade:hammer-x/f-h-x-offline" should install firefly and then upgrade 
directly to "x" (jewel in this case). . .

Opened http://tracker.ceph.com/issues/19687 and proposed fix at 
https://github.com/ceph/ceph/pull/14626 - reviews welcome.

On 04/18/2017 11:03 PM, Nathan Cutler wrote:
> Somehow, something got merged to jewel recently that caused a regression
> which showed up in 10.2.8 integration testing. Bisect is ongoing at
> http://tracker.ceph.com/issues/19538#note-30
>
> NOTE: no released versions are affected - not even v10.2.7.
>
> Please refrain from merging anything to jewel until the issue is resolved.
