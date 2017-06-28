From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Minor doc nits for Luminous upgrade
Date: Thu, 29 Jun 2017 11:51:02 +1200
Message-ID: <a2af6f82-9283-0816-5628-214319c03698@catalyst.net.nz>
References: <a29ea0cb-a1b8-9c26-ae4c-9ff91ba6a917@catalyst.net.nz>
 <CAEw75dMcOjzfZFYWhPpo4yRfpU7ReN6a_gg5a7vKbm61Bn=X9A@mail.gmail.com>
 <8d60d33f-babc-2a56-73f8-8f3547ee08e4@catalyst.net.nz>
 <alpine.DEB.2.11.1706281347180.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:46016
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751518AbdF1XvG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Jun 2017 19:51:06 -0400
In-Reply-To: <alpine.DEB.2.11.1706281347180.3424@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 29/06/17 01:48, Sage Weil wrote:

> The first rc 12.1.0 has 'mon feature list' instead of 'mon feature ls';
> the command was renamed right after the release was tagged to be more
> consistent with other cli commands.  (Can you confirm that 'mon feature
> list' works?)
>
> The command should start working as soon as the monitors are upgraded to
> luminous.
>
>

Thanks Sage - sorry, I was being dense and misunderstood what was going on!

Yes, 'mon feature list' works fine.

Cheers

Mark

