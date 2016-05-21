From: Junwang Zhao <zhjwpku@gmail.com>
Subject: Re: [wip-addr-features] make sure I am doing the right thing
Date: Sat, 21 May 2016 15:30:48 +0800
Message-ID: <CAEG8a3JJ027cdbv14NFaxCVqj+sHqb7DYB3HE_nSjHtQerU2Rg@mail.gmail.com>
References: <CAEG8a3LQuro2zXu90im0aQ58XxdGLDQvLxnjkJ+Rd8C6k70QVw@mail.gmail.com>
	<alpine.DEB.2.11.1605160446150.30956@cpach.fuggernut.com>
	<alpine.DEB.2.11.1605161228390.30956@cpach.fuggernut.com>
	<CAEG8a3KPFfuFfM2TDyY11A0XD=fvGEmm=TP2Y_ZvZfWYTREAzw@mail.gmail.com>
	<alpine.DEB.2.11.1605181637080.30956@cpach.fuggernut.com>
	<CAEG8a3KCYaCUAmdw8i=-BZKHVN4DJ4gK3RAzSf5q9cA2xXEr=Q@mail.gmail.com>
	<alpine.DEB.2.11.1605190806040.980@cpach.fuggernut.com>
	<CAEG8a3KhoaGXRQ43ywHUvzWujNqx2B2V_ZdHzzdyUGEFRqirGw@mail.gmail.com>
	<alpine.DEB.2.11.1605200610410.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34526 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbcEUHat (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 May 2016 03:30:49 -0400
Received: by mail-vk0-f48.google.com with SMTP id c189so169503142vkb.1
        for <ceph-devel@vger.kernel.org>; Sat, 21 May 2016 00:30:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605200610410.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 20, 2016 at 6:21 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 20 May 2016, Junwang Zhao wrote:
>> On Thu, May 19, 2016 at 8:08 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Thu, 19 May 2016, Junwang Zhao wrote:
>> >> Hi Sage, Haomai,
>> >> Please check [1] and give some feedback, I am not sure about
>> >> 52436ded943b8f567adb584c50b789431b788a85
>> >>
>> >> [1] https://github.com/zhjwpku/ceph/commits/wip-addr-work
>> >
>> > Great! I made several suggestions, and I have a question for everyone:
>> > what should we do if we have a "new" addr (say, for the v2 msgr protocol)
>> > and we need to encode it for a client that doesn't have the ADDR2 feature?
>> > Right now we are still stuffing the sockaddr_storage in their with
>> > whatever sockaddr data we have, but it is indistinguishable from a legacy
>> > address.  Perhaps it sould encode as blank?  (e.g., entity_addr_t())? Or
>> > blank, except with a magic nonce (0xffffffff maybe) so that you can tell
>> > that it is non-blank but not terribly useful/usable?
>>
>> I don't quite get this, can you explain this more specific? I now
>> consider the first encoded __u32 as the distinguish flag for the client
>> to identify legacy or not, a little bit confused :(
>
> Yeah, it is.  Look forward a bit to where we have a new, incompatible wire
> protocol, and TYPE_MSGR2 = 2 (to go with TYPE_LEGACY = 1).  How should we
> encode a msgr2 addr for a client that doesn't have the new ADDR2 feature?
> Currently, we'll set the legacy __u32 type = 0, and then encode same nonce
> and sockaddr, but that makes the msgr2 addr appear to be legacy addr to
> the legacy client.
>
> Instead, I'm suggesting that if type != TYPE_LEGACY and the target doesn't
> have the ADDR2 feature, we encode type = 0, nonce = -1 (or some other
> poison placeholder), and an empty sockaddr.  That way the legacy code will
> see an addr that is not blank and also looks unusable (blank sockaddr,
> weird nonce).
>

Thanks, understand now :)

>> BTW, i have add entity_addrvec_t[1], you may want to have a look.
>>
>> [1] https://github.com/zhjwpku/ceph/commits/wip-addr-work
>
> A few comments, but looks good!

Updated, I add a entity_addr_t::decode_legacy_addr_after_marker()
helper to eliminate the duplication, have a look when you got some time.

>
> I will work on getting the discussion for the msgr2 protocol going next
> week, as we'll be needing that sooner rather than later.
>
Look forward to that!

Thanks!

> Thanks!
> sage
