From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 16:56:21 -0500
Message-ID: <50FF0B05.5090502@gmail.com>
References: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk> <50FF0197.6020202@inktank.com> <50FF0410.3030308@gmail.com> <50FF098C.8050707@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:55733 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab3AVV40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:56:26 -0500
Received: by mail-vb0-f42.google.com with SMTP id ff1so4670568vbb.15
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:56:25 -0800 (PST)
In-Reply-To: <50FF098C.8050707@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, martin <martin@skytech.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Stefan Priebe wrote:
> Hi,
> Am 22.01.2013 22:26, schrieb Jeff Mitchell:
>> Mark Nelson wrote:
>>> It may (or may not) help to use a power-of-2 number of PGs. It's
>>> generally a good idea to do this anyway, so if you haven't set up your
>>> production cluster yet, you may want to play around with this. 
>>> Basically
>>> just take whatever number you were planning on using and round it up 
>>> (or
>>> down slightly). IE if you were going to use 7,000 PGs, round up to 
>>> 8192.
>>
>> As I was asking about earlier on IRC, I'm in a situation where the docs
>> did not mention this in the section about calculating PGs so I have a
>> non-power-of-2 -- and since there are some production things running on
>> that pool I can't currently change it.
>
> Oh same thing here - did i miss the doc or can someone point me the 
> location.

Here you go: http://ceph.com/docs/master/rados/operations/placement-groups/

(Notice the lack of any power-of-2 mention  :-)  )

--Jeff
