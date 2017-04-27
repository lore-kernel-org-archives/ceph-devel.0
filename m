From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Performance Measurement
Date: Thu, 27 Apr 2017 15:11:43 +0200
Message-ID: <95a3c7e5-6f56-4254-895d-a89b3f0360f2@corp.ovh.com>
References: <alpine.LSU.2.20.1704270603070.1886@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo301.mail-out.ovh.net ([137.74.110.69]:51284 "EHLO
        6.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939216AbdD0NMC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Apr 2017 09:12:02 -0400
In-Reply-To: <alpine.LSU.2.20.1704270603070.1886@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>, Squid Cybernetic <ceph-devel@vger.kernel.org>

On 04/27/2017 03:05 PM, Jesse Williamson wrote:
>
> Hi folks,
>
> Are there well-known benchmark suites that come with or are usually used
> with Ceph? A magical load generator powered by unicorns and fuzzy bunnies?
> If such magic exists, where would I find it?

CBT - https://github.com/ceph/cbt
FIO (RBD engine)
"rados bench" (CLI command)

-- 
Piotr Dalek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
