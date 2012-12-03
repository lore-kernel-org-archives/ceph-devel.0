From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: wip-filestore
Date: Mon, 03 Dec 2012 13:36:32 -0600
Message-ID: <50BCFF40.6040308@inktank.com>
References: <alpine.DEB.2.00.1212030336290.6180@cobra.newdream.net> <CA+4uBUZ2YsoCjwc6dJCC2RKTLEvOn0Qvnbq0X7Y7fCwJ8AVprA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35307 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2LCTgd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:36:33 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4802104ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 11:36:33 -0800 (PST)
In-Reply-To: <CA+4uBUZ2YsoCjwc6dJCC2RKTLEvOn0Qvnbq0X7Y7fCwJ8AVprA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Are we thinking about including this in 0.56?

Mark

On 12/03/2012 01:31 PM, Samuel Just wrote:
> I rejected it only because I didn't manage to measure a performance
> increase.  The wip-filestore patches look fine though.
> -Sam
>
> On Mon, Dec 3, 2012 at 3:38 AM, Sage Weil <sage@inktank.com> wrote:
>> While playing with recovery on the plane I saw big latency spikes caused
>> by draining the filestore op queue.  This patch makes it only wait for
>> dequeued ops (current handed to threads) and not anything else.  Passed
>> the rados suite without problems, and some basic testing on my laptop with
>> lots of filestore op threads.
>>
>> I remember you had a patch doing something similar a while back and
>> rejected it... but I forget what the issue was?
>>
>> sage
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

