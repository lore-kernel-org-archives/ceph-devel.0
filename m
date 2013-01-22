From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 16:26:40 -0500
Message-ID: <50FF0410.3030308@gmail.com>
References: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk> <50FF0197.6020202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:58828 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab3AVV0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:26:45 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so6593301vbb.37
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:26:45 -0800 (PST)
In-Reply-To: <50FF0197.6020202@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: martin <martin@skytech.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Mark Nelson wrote:
> It may (or may not) help to use a power-of-2 number of PGs. It's
> generally a good idea to do this anyway, so if you haven't set up your
> production cluster yet, you may want to play around with this. Basically
> just take whatever number you were planning on using and round it up (or
> down slightly). IE if you were going to use 7,000 PGs, round up to 8192.

As I was asking about earlier on IRC, I'm in a situation where the docs 
did not mention this in the section about calculating PGs so I have a 
non-power-of-2 -- and since there are some production things running on 
that pool I can't currently change it.

If indeed that makes a difference, here's one vote for a resilvering 
mechanism   :-)

Alternately, if I stand up a second pool, is there any easy way to 
(offline) migrate an RBD from one to the other? (Knowing that this means 
I'd have to update state with anything using it, after.) The only thing 
I know of right now is to make a second RBD, map both to a client, and dd.

Thanks,
Jeff
