From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Interesting results
Date: Mon, 2 Jul 2012 08:38:01 -0600
Message-ID: <4FF1B249.8010106@sandia.gov>
References: <4FECDCB0.7080406@sandia.gov>
 <4FF0AB99.4060103@profihost.ag> <4FF1AA80.4070009@sandia.gov>
 <4FF1AB38.8050508@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:49117 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab2GBOi3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 10:38:29 -0400
In-Reply-To: <4FF1AB38.8050508@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/02/2012 08:07 AM, Stefan Priebe - Profihost AG wrote:
> Am 02.07.2012 16:04, schrieb Jim Schutt:
>> On 07/01/2012 01:57 PM, Stefan Priebe wrote:
>>> thanks for sharing. Which btrfs mount options did you use?
>>
>> -o noatime
>>
>> is all I use.
>
> Thanks. Have you ever measured random I/O performance? Or is sequential all you need?

So far I've only been testing sequential, because
I like to find the limits under sequential load first.

--Jim

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


