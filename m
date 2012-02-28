From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Recommended number of pools, one Q. ever wanted to ask
Date: Tue, 28 Feb 2012 10:42:23 +0100
Message-ID: <4F4CA17F.4070007@widodh.nl>
References: <4F4C9FE9.7000808@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:38030 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab2B1JmZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 04:42:25 -0500
In-Reply-To: <4F4C9FE9.7000808@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 02/28/2012 10:35 AM, Oliver Francke wrote:
> Hi *,
>
> well, there was once a comment on our layout in means of "too many pools".
> Our setup is to have a pool per customer, to simplify the view on used
> storage
> capacity.
> So, if we have - in a couple of months, we hope - more then some hundred
> customers, this setup was not recommended, cause the whole system is not
> designed for handling that. ( Sage)
>
> What does "not recommended" mean? Is it, that per OSD the used memory
> will be
> too high?

Yes. Every new pool you create will consume some memory on the OSD. So 
if you start creating a lot of pools, you will also start consuming more 
and more memory.

I haven't followed this lately, but that is the current information I have.

The number of objects in a pool is also not a problem, you can have 
millions without any issues. It's the number of pools which will haunt 
you later on.

Wido

> Is this a general performance issue?
>
> Well, if we read "pool", this gave us the basic idea/concept to put all
> per-customers
> data into it.
>
> Please sched some light in 8-)
>
> Kind regards,
>
> Oliver.
>

