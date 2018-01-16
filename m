From: kefu chai <tchaikov@gmail.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Tue, 16 Jan 2018 19:26:48 +0800
Message-ID: <CAJE9aOPuguVg4hDkV8vL0GNffRJw0zSbH0aLy4Tb2oVopCy8bg@mail.gmail.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <09fac638-bae8-c04a-8ad0-6d6be3d4d335@redhat.com> <CAKOnar=wKu2WdhTeaJ-17BbTnDvM6_2CbsNjKdc0FiMBsHV-Vg@mail.gmail.com>
 <c9f8184e-6c5c-fbee-6977-6497f67e578f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:38264 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeAPL0u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 06:26:50 -0500
Received: by mail-qk0-f169.google.com with SMTP id j185so20397042qkc.5
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 03:26:49 -0800 (PST)
In-Reply-To: <c9f8184e-6c5c-fbee-6977-6497f67e578f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Matt Benjamin <mbenjami@redhat.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, Jan 16, 2018 at 4:48 AM, Casey Bodley <cbodley@redhat.com> wrote:
>
> On 01/15/2018 02:30 PM, Matt Benjamin wrote:
>>
>> It's the buffer::raw class that abstracts foreign buffer
>> representations now, is it now? A mechanism to allow seastar to
>> single-allocate a composite buffer::raw and temporary_buffer<char>
>> seems possible to imagine.
>>
>> Matt
>
>
> Thanks Matt. I think that's effectively what I did with
> https://github.com/cbodley/ceph/commit/67ae06e488c50a6102c66d34b942ff207493ffd6.
> It allocates a buffer::raw subclass that stores temporary_buffer<char> as a
> member. The raw allocation here is the same one we'd see with any other
> buffer type, so I was mistaken in thinking of this as extra overhead. The
> allocation in the other direction is effectively seastar's version of this
> same abstraction. So I think these conversions are fine as they are.
>
> I do still think there are wins in generalizing denc to avoid these
> conversions, but we'll have to explore whether it's worth the extra
> complexity.

i see. is https://github.com/tchaikov/ceph/tree/wip-seastar-msg
something more close to what you are thinking about?

-- 
Regards
Kefu Chai
