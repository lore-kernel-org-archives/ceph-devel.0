From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Thu, 2 Feb 2017 08:06:59 +0100
Message-ID: <9e856df3-aa13-834d-457c-6592474cb198@corp.ovh.com>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 3.mo301.mail-out.ovh.net ([137.74.110.66]:59094 "EHLO
        3.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdBBHHI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 02:07:08 -0500
In-Reply-To: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/01/2017 04:35 PM, Nathan Cutler wrote:
> Hi Abhishek:
>
> The stable releases and backports team has been working to prepare the Jewel
> 10.2.6 release and so far we have merged a large number of bugfixes and even
> some features that were judged to be worth backporting.
>
> I don't have a full list, yet, because I'm still merging RGW backports and
> there a few more miscellaneous backports still in the queue. The integration
> tests are looking better and better, and I expect these will be merged
> within the next week or two.
>
> Do you think it's time to publish a 10.2.6 point release?

Any chance to have
https://github.com/ceph/ceph/pull/13131
and
https://github.com/ceph/ceph/pull/13214
included in 10.2.6?

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
