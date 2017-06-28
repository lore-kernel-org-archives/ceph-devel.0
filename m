From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Minor doc nits for Luminous upgrade
Date: Wed, 28 Jun 2017 19:47:38 +1200
Message-ID: <8d60d33f-babc-2a56-73f8-8f3547ee08e4@catalyst.net.nz>
References: <a29ea0cb-a1b8-9c26-ae4c-9ff91ba6a917@catalyst.net.nz>
 <CAEw75dMcOjzfZFYWhPpo4yRfpU7ReN6a_gg5a7vKbm61Bn=X9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:50364
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751084AbdF1Hrn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Jun 2017 03:47:43 -0400
In-Reply-To: <CAEw75dMcOjzfZFYWhPpo4yRfpU7ReN6a_gg5a7vKbm61Bn=X9A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 28/06/17 16:23, Abhishek L wrote:
> On Wed, Jun 28, 2017 at 3:07 AM, Mark Kirkwood
> <mark.kirkwood@catalyst.net.nz> wrote:
>>
>> 1/ Mon feature list
>>
>> <# ceph mon feature ls
>>> # ceph mon feature list
> While the final feature of release and the next RC will feature the
> `ls` version, this  RC still had the older list version, I've made a
> correction to the blog entry.
>
>
I'm not sure I've been clear with this point, but the 'ls' command does 
not work if you are upgrading from Jewel - surely this is a) a problem 
and b) a very likely upgrade path!

regards

Mark
