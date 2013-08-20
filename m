From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Tue, 20 Aug 2013 10:58:05 +0200
Message-ID: <CAN04cT5PbuFUywG6OAovNPmraj-3mHn8=BLpAM2nWrsdtOR9BA@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
	<CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
	<CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
	<CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
	<CAN04cT6vHxCVWMPEZM1Ppqfbbv4Eqao7HwDNsuJgomYbugJ3Gg@mail.gmail.com>
	<CABBk=J_LXDxpv8shUVr9sf6De5wayQ9r1tPJC1rmzwdJfqnQHg@mail.gmail.com>
	<CAN04cT5jGGJThJgj47WZxrG9HB-0DywNY4Hw5kQkObOvWsjw8g@mail.gmail.com>
	<CABBk=J_FYU+5Bf3ORyFJsNx0J1PoEkZWosijZJX6eVk-GwOTBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:56871 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3HTI6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 04:58:07 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so184431oag.40
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 01:58:05 -0700 (PDT)
In-Reply-To: <CABBk=J_FYU+5Bf3ORyFJsNx0J1PoEkZWosijZJX6eVk-GwOTBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 20, 2013 at 2:58 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> Well, practically I'd like to have such work doing baby steps, rather
> than swiping changes. Such changes have higher chances of getting
> completed and eventually merged upstream.  That's why I prefer the
> current model of directly linking the plugins (whether statically or
> dynamically), with (relatively) minor internal adjustments.

What current model of "directly linking plugins" do you refer to exactly?

> Maybe start with thinking about the use cases, and then figure what
> kind of api that would be. As I said, I'm not sure that an internal
> api is the way to go, but rather exposing some lower level
> functionality externally. The big difference is that with the former
> we tie in the internal architecture, while the latter hides the [gory]
> details.

The problem is that right now basically everything is 'lower level
functionality', because a lot of generic stuff depends on S3 stuff,
which in turn depends on generic stuff. Take for example the
following;

class RGWHandler_Usage : public RGWHandler_Auth_S3 { }
class RGWHandler_Auth_S3 : public RGWHandler_ObjStore { }

This basically ties usage statistics collection + authentication
handling + object store all together.

I think this needs to be completely unravelled, but before making all
kinds of use cases (like, usage statistics collection or
authentication in this case) it might be wise to know what the design
decisions were to make the S3 API so very much integrated into
everything else. Or is this just legacy?

Roald
