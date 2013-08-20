From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Tue, 20 Aug 2013 07:49:58 -0700
Message-ID: <CABBk=J9jmLiAmfsFgKATnbj4h4mXH_ibzohD7i3Z+XiwaZ4Ufw@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
	<CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
	<CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
	<CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
	<CAN04cT6vHxCVWMPEZM1Ppqfbbv4Eqao7HwDNsuJgomYbugJ3Gg@mail.gmail.com>
	<CABBk=J_LXDxpv8shUVr9sf6De5wayQ9r1tPJC1rmzwdJfqnQHg@mail.gmail.com>
	<CAN04cT5jGGJThJgj47WZxrG9HB-0DywNY4Hw5kQkObOvWsjw8g@mail.gmail.com>
	<CABBk=J_FYU+5Bf3ORyFJsNx0J1PoEkZWosijZJX6eVk-GwOTBw@mail.gmail.com>
	<CAN04cT5PbuFUywG6OAovNPmraj-3mHn8=BLpAM2nWrsdtOR9BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:58967 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3HTOt7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 10:49:59 -0400
Received: by mail-ve0-f170.google.com with SMTP id 15so386595vea.29
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 07:49:58 -0700 (PDT)
In-Reply-To: <CAN04cT5PbuFUywG6OAovNPmraj-3mHn8=BLpAM2nWrsdtOR9BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 20, 2013 at 1:58 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> On Tue, Aug 20, 2013 at 2:58 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> Well, practically I'd like to have such work doing baby steps, rather
>> than swiping changes. Such changes have higher chances of getting
>> completed and eventually merged upstream.  That's why I prefer the
>> current model of directly linking the plugins (whether statically or
>> dynamically), with (relatively) minor internal adjustments.
>
> What current model of "directly linking plugins" do you refer to exactly?

I was referring to your work at wip-rgw-plugin, where the plugin code
itself still needs to rely on the rgw utility code.

>
>> Maybe start with thinking about the use cases, and then figure what
>> kind of api that would be. As I said, I'm not sure that an internal
>> api is the way to go, but rather exposing some lower level
>> functionality externally. The big difference is that with the former
>> we tie in the internal architecture, while the latter hides the [gory]
>> details.
>
> The problem is that right now basically everything is 'lower level
> functionality', because a lot of generic stuff depends on S3 stuff,
> which in turn depends on generic stuff. Take for example the
> following;
>
> class RGWHandler_Usage : public RGWHandler_Auth_S3 { }
> class RGWHandler_Auth_S3 : public RGWHandler_ObjStore { }
>
> This basically ties usage statistics collection + authentication
> handling + object store all together.

That's not quite a hard dependency. At the moment it's like that, as
we made a decision to use the S3 auth for the admin utilities.
Switching to a different auth system (atm) would require defining a
new auth class and inheriting from it instead. It's not very flexible,
but it's not very intrusive.
I'd certainly be interested in removing this inheritance relationship
and switch to a different pipeline model.

>
> I think this needs to be completely unravelled, but before making all
> kinds of use cases (like, usage statistics collection or
> authentication in this case) it might be wise to know what the design
> decisions were to make the S3 API so very much integrated into
> everything else. Or is this just legacy?
>

As I said, I don't see it as such. We do use it all over the place,
but the same way you could just switch these to use
RGWHandler_Auth_Swift and it should work (give or take a few tweaks).

Yehuda
