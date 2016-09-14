From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: wip-denc
Date: Wed, 14 Sep 2016 10:12:27 +0100
Message-ID: <6cb3ef53-fcac-0d7c-4220-cef16510484d@suse.de>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55475 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbcINJMa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 05:12:30 -0400
In-Reply-To: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 09/13/2016 10:17 PM, Sage Weil wrote:
> Hi everyone,
>
> Okay, I have a new wip-denc branch working and ready for some review:
>
> 	https://github.com/ceph/ceph/pull/11027
>
> Highlights:
>
> - This includes appender/iterator changes to buffer* to speed up
> encoding and decoding (fewer bounds checks, simpler structures).
>
> - Accordingly, classes/types using the new-style have different arguments
> types for encode/decode.  There is also a new bound_encode() method that
> is used to calculate how big of a buffer to preallocate.
>
> - Most of the important helpers for doing types have new versions that
> work with the new framework (e.g., the ENCODE_START macro has a
> new DENC_START counterpart).
>
> - There is also a mechanism that lets you define the bound_encode,
> encode, and decode methods all in one go using some template magic.  This
> only works for pretty simple types, but it is handy.  It looks like so:
>
>   struct foo_t {
>     uint32_t a, b;
>     ...
>     DENC(foo_t, v, p) {
>       DENC_START(1, 1, p);
>       denc(v.a, p);
>       denc(v.b, p);
>       ...
>       DENC_FINISH(p);
>     }
>   };
>   WRITE_CLASS_DENC(foo_t)

This looks really neat!

I do have a question though:

   How do we handle conditional decoding depending on version?

AFAICT, we basically use the same function (`_denc_friend()`) to do all 
encoding/decoding operations, delegating to `denc()` the responsibility 
of figuring out what operation needs to be done according to parameters 
(i.e., decoding if parameter is a buffer::ptr::iterator; some form of 
encoding otherwise).

Even with `DENC_START` populating `struct_v` and `struct_compat`, just 
like the traditional encoding.h scheme, I'm still trying to wrap my head 
around how this would ideally be handled.

So say we drop a field 'a' from `struct bar_t`, and add a field 'b' on 
version X+1. We still want to encode 'a' on-the-wire for backward 
compatibility with version X, alongside with shiny new 'b' for version 
 >= X+1.

Encoding can be trivially handled, as we do now, by simply populating 
whatever 'a' was with whatever we want. Decoding 'b' is also trivial, as 
we only have to decode it.

Whereas in version X we would simply have

   DENC(bar_t, v, p) {
    ...
    denc(v.a, p);
    ...
   }

on version X+1 we would have to make sure to encode the values 
corresponding to 'a' but not decode anything to `v.a`, as it would not 
exist.

I can see how we could, possibly, get there by using the specific 
encoding or decoding methods, depending on version, but that would 
eventually escalate and lead to a mess in `DENC()`.

Any thoughts on this?

   -Joao
