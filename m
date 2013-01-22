From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 22:50:04 +0100
Message-ID: <50FF098C.8050707@profihost.ag>
References: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk> <50FF0197.6020202@inktank.com> <50FF0410.3030308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:46596 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3AVVuG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:50:06 -0500
In-Reply-To: <50FF0410.3030308@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, martin <martin@skytech.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
Am 22.01.2013 22:26, schrieb Jeff Mitchell:
> Mark Nelson wrote:
>> It may (or may not) help to use a power-of-2 number of PGs. It's
>> generally a good idea to do this anyway, so if you haven't set up your
>> production cluster yet, you may want to play around with this. Basically
>> just take whatever number you were planning on using and round it up (or
>> down slightly). IE if you were going to use 7,000 PGs, round up to 8192.
>
> As I was asking about earlier on IRC, I'm in a situation where the docs
> did not mention this in the section about calculating PGs so I have a
> non-power-of-2 -- and since there are some production things running on
> that pool I can't currently change it.

Oh same thing here - did i miss the doc or can someone point me the 
location.

Is there a chance to change the number of PGs for a pool?

Greets,
Stefan
