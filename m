From: Rajath Shashidhara <rajath.shashidhara@gmail.com>
Subject: Re: Interest in Implementing Cache layer on top of NVME Driver [GSoC]
Date: Thu, 3 Mar 2016 00:41:08 +0530
Message-ID: <CAFjGuFRXZQiwuyqxxhfp_0==HKc1L4GTPi+fVTN_7aOE-D=3xA@mail.gmail.com>
References: <CAFjGuFTQ3P_GrcTuYBR5jRxXcZu4v1DeEH23NqfER-w=SB69-A@mail.gmail.com>
	<CACJqLyaAz7s6Yp2N0crYnO-c_WcE7kygze0x=4i9oHSiptvJ5g@mail.gmail.com>
	<56D63359.3090304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34837 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbcCBTLK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 14:11:10 -0500
Received: by mail-vk0-f42.google.com with SMTP id e6so211836054vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 11:11:10 -0800 (PST)
In-Reply-To: <56D63359.3090304@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I did some reading on user space drivers and specifically NVME drivers
[1,2]. I understand that user space drivers run in "user mode" as
opposed to the "kernel mode" to save context switch time. But, this
also places several restrictions on the driver, like the
unavailability of buffer cache usually present to optimize read/write
from storage devices in the kernel.

I would like to know more about the following things to understand the
cache requirements :
[1] Are there any assumptions that I should make about locality of access ?
[2] Are multiple threads going to be accessing the cache at the same
time (thread safety) ?
[3] What are the components in Ceph that are going to directly
interact with the cache ? (Reading their code might give me a better
idea about what is expected of me)

When designing a cache there are several parameters/factors that needs
to be addresses - like page replacement policies, page sizes,
prefetching, etc. I guess I will be able to make the right design
choices if I better understand the cache requirements and access
profile.

This is my first exposure to ceph. Please excuse me if I am asking
basic questions.

Please point me to the right resources so that I can better understand
the project. I would also be happy to fix a bug to familiarize myself
with the source code. Any suggestions on bugs that are relevant to the
project will be of great help.

Thank you,
Rajath Shashidhara

[1] http://www.enea.com/Documents/Resources/Whitepapers/Enea-User-Space-Drivers-in-Linux_Whitepaper_2013.pdf
[2] http://www.nvmexpress.org/about/nvm-express-overview/

On Wed, Mar 2, 2016 at 5:57 AM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 03/01/2016 06:01 AM, Haomai Wang wrote:
>>
>> I think it's a initial idea background, but since we also have
>> ObjectCacher in client side, if we can unify this it will be good. But
>> obviously ObjectCacher is complexity now, you may not take care of it
>> at first...
>
>
> I'd suggest ignoring ObjectCacher, since it's got ordering and buffer
> assumptions you probably don't need, plus a single global lock. I'd
> expect a read-focused cache to be pretty different.
>
> Josh
