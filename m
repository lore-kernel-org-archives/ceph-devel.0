From: Loic Dachary <loic@dachary.org>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Thu, 2 Feb 2017 09:22:46 +0100
Message-ID: <72d5cc9f-33f5-71f1-2965-2f75a799fb52@dachary.org>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <9e856df3-aa13-834d-457c-6592474cb198@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54549 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdBBIWu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 03:22:50 -0500
In-Reply-To: <9e856df3-aa13-834d-457c-6592474cb198@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 02/02/2017 08:06 AM, Piotr Dałek wrote:
> On 02/01/2017 04:35 PM, Nathan Cutler wrote:
>> Hi Abhishek:
>>
>> The stable releases and backports team has been working to prepare the Jewel
>> 10.2.6 release and so far we have merged a large number of bugfixes and even
>> some features that were judged to be worth backporting.
>>
>> I don't have a full list, yet, because I'm still merging RGW backports and
>> there a few more miscellaneous backports still in the queue. The integration
>> tests are looking better and better, and I expect these will be merged
>> within the next week or two.
>>
>> Do you think it's time to publish a 10.2.6 point release?
> 
> Any chance to have
> https://github.com/ceph/ceph/pull/13131

I'll let Nathan comment on this one.

> and
> https://github.com/ceph/ceph/pull/13214

Since it is a backport of https://github.com/ceph/ceph/pull/13213 which is not yet merged in master, it is unlikely to make it to 10.2.6. Not impossible but things would have to move unusually fast for that to happen ;-)

> included in 10.2.6?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
