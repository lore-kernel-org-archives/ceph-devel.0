From: Casey Bodley <cbodley@redhat.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Mon, 15 Jan 2018 15:48:09 -0500
Message-ID: <c9f8184e-6c5c-fbee-6977-6497f67e578f@redhat.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com>
 <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:38524 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeAOUsM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 15:48:12 -0500
Received: by mail-qk0-f173.google.com with SMTP id j185so18401547qkc.5
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 12:48:12 -0800 (PST)
In-Reply-To: <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 01/15/2018 02:30 PM, Matt Benjamin wrote:
> It's the buffer::raw class that abstracts foreign buffer
> representations now, is it now? A mechanism to allow seastar to
> single-allocate a composite buffer::raw and temporary_buffer<char>
> seems possible to imagine.
>
> Matt

Thanks Matt. I think that's effectively what I did with 
https://github.com/cbodley/ceph/commit/67ae06e488c50a6102c66d34b942ff207493ffd6. 
It allocates a buffer::raw subclass that stores temporary_buffer<char> 
as a member. The raw allocation here is the same one we'd see with any 
other buffer type, so I was mistaken in thinking of this as extra 
overhead. The allocation in the other direction is effectively seastar's 
version of this same abstraction. So I think these conversions are fine 
as they are.

I do still think there are wins in generalizing denc to avoid these 
conversions, but we'll have to explore whether it's worth the extra 
complexity.
