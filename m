From: Sage Weil <sweil@redhat.com>
Subject: Re: wip-denc
Date: Wed, 14 Sep 2016 13:27:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609141323200.19761@piezo.us.to>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to> <6cb3ef53-fcac-0d7c-4220-cef16510484d@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762096AbcINN1R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 09:27:17 -0400
In-Reply-To: <6cb3ef53-fcac-0d7c-4220-cef16510484d@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: ceph-devel@vger.kernel.org

On Wed, 14 Sep 2016, Joao Eduardo Luis wrote:
> On 09/13/2016 10:17 PM, Sage Weil wrote:
> > Hi everyone,
> > 
> > Okay, I have a new wip-denc branch working and ready for some review:
> > 
> > 	https://github.com/ceph/ceph/pull/11027
> > 
> > Highlights:
> > 
> > - This includes appender/iterator changes to buffer* to speed up
> > encoding and decoding (fewer bounds checks, simpler structures).
> > 
> > - Accordingly, classes/types using the new-style have different arguments
> > types for encode/decode.  There is also a new bound_encode() method that
> > is used to calculate how big of a buffer to preallocate.
> > 
> > - Most of the important helpers for doing types have new versions that
> > work with the new framework (e.g., the ENCODE_START macro has a
> > new DENC_START counterpart).
> > 
> > - There is also a mechanism that lets you define the bound_encode,
> > encode, and decode methods all in one go using some template magic.  This
> > only works for pretty simple types, but it is handy.  It looks like so:
> > 
> >   struct foo_t {
> >     uint32_t a, b;
> >     ...
> >     DENC(foo_t, v, p) {
> >       DENC_START(1, 1, p);
> >       denc(v.a, p);
> >       denc(v.b, p);
> >       ...
> >       DENC_FINISH(p);
> >     }
> >   };
> >   WRITE_CLASS_DENC(foo_t)
> 
> This looks really neat!
> 
> I do have a question though:
> 
>   How do we handle conditional decoding depending on version?
> 
> AFAICT, we basically use the same function (`_denc_friend()`) to do all
> encoding/decoding operations, delegating to `denc()` the responsibility of
> figuring out what operation needs to be done according to parameters (i.e.,
> decoding if parameter is a buffer::ptr::iterator; some form of encoding
> otherwise).
> 
> Even with `DENC_START` populating `struct_v` and `struct_compat`, just like
> the traditional encoding.h scheme, I'm still trying to wrap my head around how
> this would ideally be handled.
> 
> So say we drop a field 'a' from `struct bar_t`, and add a field 'b' on version
> X+1. We still want to encode 'a' on-the-wire for backward compatibility with
> version X, alongside with shiny new 'b' for version >= X+1.
> 
> Encoding can be trivially handled, as we do now, by simply populating whatever
> 'a' was with whatever we want. Decoding 'b' is also trivial, as we only have
> to decode it.
> 
> Whereas in version X we would simply have
> 
>   DENC(bar_t, v, p) {
>    ...
>    denc(v.a, p);
>    ...
>   }
> 
> on version X+1 we would have to make sure to encode the values corresponding
> to 'a' but not decode anything to `v.a`, as it would not exist.

   struct foo_t {
     uint32_t a, b;
     ...
     DENC(foo_t, v, p) {
       DENC_START(1, 1, p);
       denc(v.a, p);
       denc(v.b, p);
       if (struct_v >= 2) {
         denc(v.new_thing, p);
       }
       DENC_FINISH(p);
     }
   };
   WRITE_CLASS_DENC(foo_t)

should do it, although I haven't tested.  May need to tweak the 
_denc_start to ensure that struct_v is populated for the bound_encode and 
encode cases.  (It should get optimized away by the compiler since 
struct_v is being assigned a compile-time constant, the 'v' macro param.)

What doesn't work is cases where the decode path has a more complicated 
conditional or compat value (that isn't the class constructor's default).  
In those cases you just need to define the 3 methods separately!

sage
