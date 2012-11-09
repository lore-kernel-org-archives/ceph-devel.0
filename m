From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: cephx auth issue
Date: Fri, 9 Nov 2012 13:19:38 -0500
Message-ID: <CACkq2mrrMoubHPBK0tZT7BBFc5F6J=1or62o1zX_5XPGo0xaPw@mail.gmail.com>
References: <CACkq2mp21AdjQCpEzynbVht81Y-xzD0UXT16zt_EBEcy3ND92Q@mail.gmail.com>
 <20121109180802.GD19901@garage.reed.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54438 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab2KIST7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 13:19:59 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so4067207vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 10:19:58 -0800 (PST)
In-Reply-To: <20121109180802.GD19901@garage.reed.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ben Poliakoff <benp@reed.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ben,

That did it!  Thank you so much, I owe you one.

 - Travis

On Fri, Nov 9, 2012 at 1:08 PM, Ben Poliakoff <benp@reed.edu> wrote:
> * Travis Rhoden <trhoden@gmail.com> [20121109 09:55]:
>> I'm not sure what I've done wrong here:
>>
>> Things are okay as client.admin:
>>
>> # rbd -p images --id admin ls
>> test
>>
>> But not as client.images:
>>
>> # rbd -p images --id images ls
>> error: (1) Operation not permitted
>>
>> The privs/caps seem okay in ceph auth:
>>
>> # ceph auth list
>> <snip>
>> client.admin
>>       key: <snip>
>>       caps: [mds] allow
>>       caps: [mon] allow *
>>       caps: [osd] allow *
>> client.images
>>       key: <snip>
>>       caps: [mon] allow r
>>       caps: [osd] allow rwx pool=images
>> client.volumes
>>       key: <snip>
>>       caps: [mon] allow r
>>       caps: [osd] allow rwx pool=volumes, allow rx pool=images
>>
>
> I had a very similar problem after I upgraded my test cluster from
> argonaut to 0.53.  For me it was a "caps" parsing issue involving the
> '=' character (which has been fixed in 0.54.  A nice person on IRC
> helped me out.  Updating the caps from something like this:
>
>>       caps: [osd] allow rwx pool=volumes, allow rx pool=images
>
> To this:
>
>         caps: [osd] allow rwx pool volumes, allow rx pool images
>
> ...fixed the issue for me.
>
> Apparently in 0.54 parsing of '=' in a caps line will work properly
> again.
>
> Ben
>
> --
> ________________________________________________________________________
> pub   4096R/318B6A97 2009-05-11 Ben Poliakoff <benp@reed.edu>
>  Primary key fingerprint: 3F23 EBC8 B73E 92B7 0A67  705A 8219 DCF0 318B 6A97
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iQIVAwUBUJ1GfYIZ3PAxi2qXAQhiehAAjAoLcof0hhngUfB7qZy24xOczIVOkysm
> Hm6XnavM9rYKwoW2wBv76dJ2JFLC1JVcG4ujjIi6XAHYb9SpwcuNeHynAKgNxl2k
> kk4Qf1vXRQ5lvPxxOJKNgT+liC8lw7mB2U3wlIO3njng1c/9T8Qx96ocmGXU0TB6
> 6jeboQOo6mdGxHzWPZTq2BjesS8rhajgpKgNvgwll5qaHcXNudg0LZ79raW5fj6g
> O8YpCmHcyqIM4hRHqeeBl56lfLmpjFybQqp32sfPdo78TLUZuBEhYJbtgKfpnnid
> WcS4FafTiU2UB51XWwwbLTG+YQibpCDXfiEoeidyxh2is66mhdzan99xy4E+DqWs
> 4A/GVeHiQO7fPXTSlUyeB8CyE6OEsKyszDMoh+LpEPnLBHDZO66PB96IHVPnvdPh
> pPhQJ3X5sIxKk295pnIpqaoT/ICvjh1ebEV0KrLQ9D4pTRoZT+TECdpHP7QhofzW
> 0IxP8quC2Jk0x1+HsutDjw5v9VvP1b4rbYvxTVuvoTQUIwWliFoBCmRG9sftkZqT
> tvXyxBoLLJq0GXYmor0SF1sdpl/TAmfLAE7oYUIYzWpfFlH7REVFBTNcUY3wwaqW
> oNa0IO9ZIZc+lZhr010TV+lTbndWg20EmJ4YZasZ9q7u1WOxNC8USfcu8PtxxMz5
> 8R6GccASMvc=
> =+vPS
> -----END PGP SIGNATURE-----
>
