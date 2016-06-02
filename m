From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: Encryption for data at rest support
Date: Thu, 2 Jun 2016 22:22:50 +0530
Message-ID: <CANA9Uk65Zb5ezWuW2J4aC0mwb_XjgNa=R9mS7OXLWjAVxCoSgg@mail.gmail.com>
References: <CANA9Uk6d+MTomL+7rQzRVUHHLWpE_WyEVL5BzpNRLrn-Xe8zJw@mail.gmail.com>
	<5750271E.10102@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34082 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161355AbcFBQwv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 12:52:51 -0400
Received: by mail-oi0-f48.google.com with SMTP id e72so86753404oib.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 09:52:51 -0700 (PDT)
In-Reply-To: <5750271E.10102@canonical.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chris holcombe <chris.holcombe@canonical.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Thank you Chris for the details.

Thanks
Swami

On Thu, Jun 2, 2016 at 6:01 PM, chris holcombe
<chris.holcombe@canonical.com> wrote:
> Hi Swami,
>
> Yes ceph supports encryption at rest using dmcrypt.  The docs are here:
> http://docs.ceph.com/docs/jewel/rados/deployment/ceph-deploy-osd/
>
> My team has integrated this functionality into the ceph-osd charm also
> if you'd like to try that out: https://jujucharms.com/ceph-osd/xenial/2
> When combined with the ceph-mon charm you're up and running fast :)
>
> -Chris
>
> On 06/02/2016 03:57 AM, M Ranga Swami Reddy wrote:
>> Hello,
>>
>> Can you please share if the ceph supports the "data at rest" functionality?
>> If yes, how can I achieve this? Please share any docs available.
>>
>> Thanks
>> Swami
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
