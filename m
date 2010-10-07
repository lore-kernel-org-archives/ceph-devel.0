From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Thu, 07 Oct 2010 16:04:05 -0500
Message-ID: <4CAE35C5.2010809@codemonkey.ws>
References: <20100802194631.GA4923@chb-desktop>	<alpine.LNX.2.00.1008030033550.2664@linmac>	<20100803201407.GD1475@chb-desktop>	<4CADD567.9010606@codemonkey.ws>	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>	<4CAE13BA.70707@codemonkey.ws>	<AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>	<4CAE24C5.8030007@codemonkey.ws> <AANLkTimW98qPTYZ=Bct7k7XqaOXswC51QdQOW6fLsWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40613 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0JGVEI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 17:04:08 -0400
In-Reply-To: <AANLkTimW98qPTYZ=Bct7k7XqaOXswC51QdQOW6fLsWkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

On 10/07/2010 03:47 PM, Yehuda Sadeh Weinraub wrote:
>> How is that possible?  Are the callbacks delivered in the context of a
>> different thread?  If so, don't you need locking?
>>      
> Not sure I'm completely following you. The callbacks are delivered in
> the context of a different thread, but won't run concurrently.

Concurrently to what?  How do you prevent them from running concurrently 
with qemu?

If you saw lock ups, I bet that's what it was from.

Regards,

Anthony Liguori

>   Do you
> see any specific concurrency issue? We can add some mutex protection
> around at the aio callback, so that if librados turns multithreaded at
> this point we're covered.
>
>
> Thanks,
> Yehuda
>
>    

