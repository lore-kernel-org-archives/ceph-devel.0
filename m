From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 13:41:17 -0800
Message-ID: <CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com>
References: <50C8F7AC.9070600@profihost.ag>
	<CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com>
	<50C8F939.6080400@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62078 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab2LLVlS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:41:18 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so2942830iea.8
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 13:41:17 -0800 (PST)
In-Reply-To: <50C8F939.6080400@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah; 61 is not a valid UUID and you can't specify anything else on that line.

On Wed, Dec 12, 2012 at 1:38 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> HI Greg,
>
> sorry just a copy & paste error.
>
> [cloud1-ceph1: ~]# ceph osd create 61
> (22) Invalid argument
>
>
>> Read those two lines again. Very slowly. :)
>>
>> The correct syntax is
>> ceph osd create <uuid>
>>
>> The uuid is optional, but you don't specify IDs; it gives you an ID back.
>
>
> Stefan
