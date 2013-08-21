From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Tue, 20 Aug 2013 19:47:56 -0700
Message-ID: <CABBk=J8c+DbbcHFnsQfdsxS3R93qbC=cGGDHRiu7bw6cAWa_zQ@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
	<CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
	<CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
	<CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
	<CAN04cT6vHxCVWMPEZM1Ppqfbbv4Eqao7HwDNsuJgomYbugJ3Gg@mail.gmail.com>
	<CABBk=J_LXDxpv8shUVr9sf6De5wayQ9r1tPJC1rmzwdJfqnQHg@mail.gmail.com>
	<CAN04cT5jGGJThJgj47WZxrG9HB-0DywNY4Hw5kQkObOvWsjw8g@mail.gmail.com>
	<CABBk=J_FYU+5Bf3ORyFJsNx0J1PoEkZWosijZJX6eVk-GwOTBw@mail.gmail.com>
	<CAN04cT5PbuFUywG6OAovNPmraj-3mHn8=BLpAM2nWrsdtOR9BA@mail.gmail.com>
	<CABBk=J9jmLiAmfsFgKATnbj4h4mXH_ibzohD7i3Z+XiwaZ4Ufw@mail.gmail.com>
	<CAN04cT6aep1=neS8OMBUnr3Y7iMHy5njqbcD4VPChw-j2q2hpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:57432 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab3HUCr5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 22:47:57 -0400
Received: by mail-ve0-f173.google.com with SMTP id cy12so990428veb.32
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 19:47:56 -0700 (PDT)
In-Reply-To: <CAN04cT6aep1=neS8OMBUnr3Y7iMHy5njqbcD4VPChw-j2q2hpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 20, 2013 at 9:03 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> On Tue, Aug 20, 2013 at 4:49 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> I was referring to your work at wip-rgw-plugin, where the plugin code
>> itself still needs to rely on the rgw utility code.
>
> Right. So we can agree on ditching the dynamic loading thing and clean
> internal API (for now), but at least start separating code into
> "plugins" like this?
>
>> That's not quite a hard dependency. At the moment it's like that, as
>> we made a decision to use the S3 auth for the admin utilities.
>> Switching to a different auth system (atm) would require defining a
>> new auth class and inheriting from it instead. It's not very flexible,
>> but it's not very intrusive.
>> I'd certainly be interested in removing this inheritance relationship
>> and switch to a different pipeline model.
>
> I don't know if you looked at it in detail, but for the wip-rgw-plugin
> work I created a RGWAuthManager / RGWAuthPipeline relation to
> seggregate authentication specific stuff from the REST handlers. Is
> that in general a model you like to see discussed in more detail? If
> so, it would probably be wise to start a separate blueprint for it.

I didn't look closely at all the details, but yeah, something along
those lines. But it'll need to be clearly defined.

>
>> As I said, I don't see it as such. We do use it all over the place,
>> but the same way you could just switch these to use
>> RGWHandler_Auth_Swift and it should work (give or take a few tweaks).
>
> IMHO, REST handlers should leave
> authentication/authorization/accounting specific tasks to a separate
> component (like the aforementioned pipelining system, and maybe
> integrate that with current RGWUser related code), although this will
> likely never be purely abstracted (at least for authentication). This
> just makes the whole system more modular (albeit it just a bit).

Can't think of examples off the top of my head right now, but the
devil's always in the details. Hopefully wrt the auth system there
aren't many hidden issues.
>
> But for now I propose to implement a small "plugin" system where
> plugins are still linked into the rgw core (but code wise as much
> separated as possible), and keep the auth stuff for later.
>
Sounds good.

Yehuda
