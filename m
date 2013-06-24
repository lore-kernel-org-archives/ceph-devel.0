From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rgw: Added an encoder for time_t to fix compilation
Date: Mon, 24 Jun 2013 10:30:53 -0700
Message-ID: <CABBk=J8OpPiBpeykkhUJT9ci4K=__zcBWLFQF-_unv8XgezoCA@mail.gmail.com>
References: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com>
	<CABBk=J8J_tKY-Wy-sWb2=GREauqN0GfaJaHk14jzRVM0fx59Bg@mail.gmail.com>
	<CAA8043j7SpO-93KEgk1JQD=BYV=H8GwQVZYz=2LhkSZgVF+dBA@mail.gmail.com>
	<CAA8043gJKa-t_DWeHE-OeGThNGwdMjb83Ve4ENSxcUU3nSFM6Q@mail.gmail.com>
	<alpine.DEB.2.00.1306241017140.29802@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:58980 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FXRay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 13:30:54 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so9083471veb.34
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 10:30:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306241017140.29802@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: christophe courtaut <christophe.courtaut@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I'd be happier if we could avoid time_t altogether and use utime_t.
The problem is that librados and the objecter interface who require
time_t for stat() and mtime(), so we just mirror that. Is there a
reason why not to use utime_t? That'll allow us to have better time
resolution when the underlying file system allows that.

On Mon, Jun 24, 2013 at 10:19 AM, Sage Weil <sage@inktank.com> wrote:
>> Sorry, wrong patch attached.
>>
>> Here comes the updated version.
>
> This might work, but I'm worried that utime_t is probably typedef'd to a
> unsigned long or something and we may accidentally call into the uint32_t
> or uint64_t method (whichever it is for that platform).  I would prefer
> something like
>
>
> Mything::encode(bufferlist& bl) const
> {
>   ...
>   uint64_t t = time;
>   ::encode(t, bl);
>   ...
> }
>
> and similarly in decode to
>
>   uint64_t t;
>   ::decode(t, bl);
>   time = t;
>
> sage
>
>>
>> Best regards.
>>
>> On Mon, Jun 24, 2013 at 4:36 PM, christophe courtaut
>> <christophe.courtaut@gmail.com> wrote:
>> > Here come a new patch.
>> >
>> > I do not generate an encoder/decoder using WRITE_RAW_ENCODER anymore.
>> >
>> > Instead i added a encoder/decoder for time_t using a __u64.
>> >
>> > On Thu, Jun 20, 2013 at 10:44 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> >> On Thu, Jun 20, 2013 at 6:57 AM, christophe courtaut
>> >> <christophe.courtaut@gmail.com> wrote:
>> >>> On the rgw-wip-geo-2 branch, the encode decode function are called
>> >>> with time_t now,
>> >>> but there is no encode/decode function created for time_t type.
>> >>>
>> >>> http://tracker.ceph.com/issues/5402 refs #5402
>> >>>
>> >>> This patch adds a WRITE_RAW_ENCODER to support this type.
>> >>>
>> >>> --
>> >>> Christophe Courtaut
>> >>
>> >>
>> >> The problem here is that we can't use the generic encoder / decoder as
>> >> time_t may have different size on different architectures. We should
>> >> just have a fixed size encoding for it (probably 64 bit albeit the
>> >> waste).
>> >>
>> >> Thanks,
>> >> Yehuda
>> >
>> >
>> >
>> > --
>> > Christophe Courtaut
>>
>>
>>
>> --
>> Christophe Courtaut
>>
