From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: mon disk access pattern
Date: Fri, 15 Jun 2012 06:34:36 -0500
Message-ID: <4FDB1DCC.6090701@inktank.com>
References: <4FDACD90.2080807@profihost.ag> <4FDB05A7.3080202@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62336 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2FOLej (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 07:34:39 -0400
Received: by yenl2 with SMTP id l2so1749017yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 04:34:39 -0700 (PDT)
In-Reply-To: <4FDB05A7.3080202@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/15/2012 04:51 AM, Wido den Hollander wrote:
> Hi,
>
> On 15-06-12 07:52, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> i read somewhere that the mon has "special" disk access patterns - even
>> though it does not write much data.
>
> "special"? Where did you read that? The monitor has about 1 ~ 2GB of
> storage.
>
> So if your monitor has something like 4GB ~ 8GB of RAM, your kernel
> should cache almost all your monitor data.
>

I think at some point someone mentioned to me that the mon can cause a 
lot of syncs, so running them on the OSDs without syncfs might be 
detrimental.  For the majority of our internal performance testing I've 
kept them off the OSDs just to be sure.

