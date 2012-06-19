From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 15:14:18 +0200
Message-ID: <4FE07B2A.7080209@profihost.ag>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag> <4FE0782A.1060104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35314 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab2FSNOW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 09:14:22 -0400
In-Reply-To: <4FE0782A.1060104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

Am 19.06.2012 15:01, schrieb Mark Nelson:
> On 06/19/2012 01:32 AM, Stefan Priebe - Profihost AG wrote:
>> Am 19.06.2012 06:41, schrieb Alexandre DERUMIER:
>>> Hi Stephann
>>> recommandations are 30-50 PGS by osd if I remember.
>>>
>> rbd, data and metadata have 2176 PGs with 12 OSD. This is 181,333333333
>> per OSD?!
>>
>> Stefan
>
> That's probably fine, it just means that you will have a better
> pseudo-random distribution of OSD combinations (It does have higher
> cpu/memory overhead though). Figuring out how many PGs you should have
> per OSD depends on a lot of factors including how many OSDs you have,
> how many nodes, CPU, memory, etc. I'm guessing ~180 per OSD won't cause
> problems. On the other hand, with low OSD counts you could probably have
> fewer and be fine too.

But this number 2176 of PGs were set while doing mkcephfs - how is it 
calculated?

Stefan
