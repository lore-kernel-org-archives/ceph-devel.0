From: kefu chai <tchaikov@gmail.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Tue, 16 Jan 2018 00:53:22 +0800
Message-ID: <CAJE9aOPs8KPYQRprJ_iFcTGnkafnSkY_yswc5YennZox7-P1BA@mail.gmail.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33688 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934380AbeAOQxY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 11:53:24 -0500
Received: by mail-qk0-f170.google.com with SMTP id i141so17583947qke.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 08:53:23 -0800 (PST)
In-Reply-To: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

On Mon, Jan 15, 2018 at 11:49 PM, kefu chai <tchaikov@gmail.com> wrote:
> hey Casey,
>
>
> i've been thinking about how to better integrate
> seastar::temporary_buffer and seastar::packet into our denc and
> messenger subsystems based on your wip-seastar-msg branch.
>
> as you pointed out to me that
>
>> the conversions between ceph::buffer::ptr and seastar::temporary_buffer in https://github.com/cbodley/ceph/tree/wip-seastar-msg/ work, but they cost an allocation in both directions (seastar::make_object_deleter() has to allocate for type erasure).
>
> and just like ceph::buffer::ptr, seastar::temporary_buffer also
> manages the life cycle of the underlying memory chunk using refcount.
> it's a waste to do the refcounting for the same mem chunk twice in the
> same application.
>
> if we want to avoid the overhead of duplicated refcounting and
> allocation in the conversion to and from ceph::buffer::ptr, i think,
> we need to allocate the temporary_buffer along with buffer::ptr. in
> other words, to include seastar::temporary_buffer as a member variable
> in ceph::buffer:ptr.
>
> i am preparing a change to prototype this approach. the downside of it is:
>
> - we need to include a placeholder structure in buffer.h for
> seastar::tempoary_buffer<char>. and cast it to
> seastar::tempoary_buffer<char> in buffer.cc . otherwise we need to
> include seastar headers in librados.

- we cannot store the crc map along with the raw class anymore. this
might be a show stopper.
- we can not use zero copy interfaces anymore. but i think it's fine.
as we need to use future/promise based interfaces for IO.

>
> cheers,
>
>
> --
> Regards
> Kefu Chai



-- 
Regards
Kefu Chai
