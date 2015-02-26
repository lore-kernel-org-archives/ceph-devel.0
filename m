From: Mark Nelson <mnelson@redhat.com>
Subject: Re: FileStore performance: coalescing operations
Date: Thu, 26 Feb 2015 09:06:44 -0600
Message-ID: <54EF3684.3010407@redhat.com>
References: <20150226152807.5b71a93c@doppio> <CACJqLyY7YEKWsrMc+8RTRypSGMtQO=wW1WFbtM57fLWNYHrgJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39687 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbbBZPGw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 10:06:52 -0500
In-Reply-To: <CACJqLyY7YEKWsrMc+8RTRypSGMtQO=wW1WFbtM57fLWNYHrgJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 02/26/2015 09:02 AM, Haomai Wang wrote:
> Hmm, we already obverse this duplicate omap keys set from pglog operations.
>
> And I think we need to resolve it in upper layer, of course,

Can we resolve this higher up easily?  I am struck that it might be 
easier to simply do the coalescing here.  I think this was the approach 
Sam was advocating in the performance meeting?

> coalescing omap operations in FileStore is also useful.
>
> @Somnath Do you do this dedup work in KeyValueStore already?
>
> On Thu, Feb 26, 2015 at 10:28 PM, Andreas Bluemle
> <andreas.bluemle@itxperts.de> wrote:
>> Hi,
>>
>> during the performance weely meeting, I had mentioned
>> my experiences concerning the transaction structure
>> for write requests at the level of the FileStore.
>> Such a transaction not only contains the OP_WRITE
>> operation to the object in the file system, but also
>> a series of OP_OMAP_SETKEYS and OP_SETATTR operations.
>>
>> Find attached a README and source code patch, which
>> describe a prototype for coalescing the OP_OMAP_SETKEYS
>> operations and the performance impact f this change.
>>
>> Regards
>>
>> Andreas Bluemle
>>
>> --
>> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
>> ITXperts GmbH                       http://www.itxperts.de
>> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
>> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>>
>> Company details: http://www.itxperts.de/imprint.htm
>
>
>
