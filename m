From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 15:57:02 -0600
Message-ID: <50FF0B2E.6010301@inktank.com>
References: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk> <50FF0197.6020202@inktank.com> <50FF0410.3030308@gmail.com> <50FF098C.8050707@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59362 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3AVV4w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:56:52 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so12419871iea.38
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:56:51 -0800 (PST)
In-Reply-To: <50FF098C.8050707@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>, martin <martin@skytech.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/22/2013 03:50 PM, Stefan Priebe wrote:
> Hi,
> Am 22.01.2013 22:26, schrieb Jeff Mitchell:
>> Mark Nelson wrote:
>>> It may (or may not) help to use a power-of-2 number of PGs. It's
>>> generally a good idea to do this anyway, so if you haven't set up your
>>> production cluster yet, you may want to play around with this. Basically
>>> just take whatever number you were planning on using and round it up (or
>>> down slightly). IE if you were going to use 7,000 PGs, round up to 8192.
>>
>> As I was asking about earlier on IRC, I'm in a situation where the docs
>> did not mention this in the section about calculating PGs so I have a
>> non-power-of-2 -- and since there are some production things running on
>> that pool I can't currently change it.
>
> Oh same thing here - did i miss the doc or can someone point me the
> location.
>
> Is there a chance to change the number of PGs for a pool?
>
> Greets,
> Stefan

Honestly I don't know if it will actually have a significant effect. 
ceph_stable_mod will map things optimally when pg_num is a power of 2, 
but that's only part of how things work.  It may not matter very much 
with high PG counts.

Mark
