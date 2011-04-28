From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: libceph API
Date: Thu, 28 Apr 2011 11:46:59 -0700
Message-ID: <BANLkTi=auEDiyH=VKZ2HSuW9PO2VvMYj+Q@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
	<BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
	<BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
	<20110427192827.GA6405@dreamer>
	<BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
	<Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
	<BANLkTinJpnMj0ryhFF1ucVjkPs5NeZ1taQ@mail.gmail.com>
	<Pine.LNX.4.64.1104281047060.1187@cobra.newdream.net>
	<BANLkTikVT0oSB2kcdXrZN58d_BybLY97BA@mail.gmail.com>
	<BANLkTin5eMEyQb=KWL0T5ah1cQ0N0hDARQ@mail.gmail.com>
	<BANLkTimYqRs_FxtgLAi1Qac7dYcmN_i-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49975 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab1D1SrB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 14:47:01 -0400
Received: by fxm17 with SMTP id 17so2011333fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 11:47:00 -0700 (PDT)
In-Reply-To: <BANLkTimYqRs_FxtgLAi1Qac7dYcmN_i-rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 11:27 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Thu, Apr 28, 2011 at 11:24 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>>>
>>> What do you guys think of changing struct ceph_mount_t to struct
>>> ceph_mount_info_t?
>>>
>> I personally don't like sticking a _t prefix to a struct. It's either
>> a typedef or a struct.
>>
> Ahrm.. *postfix*
>

I'm ok with removing the _t stuff from our library APIs. But it we'd
have to bump up the revision numbers on everything :P

I'm just going to leave this here:

http://ceph.newdream.net/git/?p=ceph-client.git;a=blob;f=Documentation/CodingStyle;h=8bb37237ebd25b19759cc47874c63155406ea28f;hb=HEAD

> 		Chapter 5: Typedefs
>
> Please don't use things like "vps_t".
>
> It's a _mistake_ to use typedef for structures and pointers. When you see a
>
> 	vps_t a;
>
> in the source, what does it mean?
>
> In contrast, if it says
>
> 	struct virtual_container *a;
>
> you can actually tell what "a" is.
>
> Lots of people think that typedefs "help readability". Not so. They are
> useful only for:
> [...]
>

I'll come back once the flamewar has settled down :)

Colin
