From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Mon, 19 Aug 2013 14:34:48 +0200
Message-ID: <CAN04cT6vHxCVWMPEZM1Ppqfbbv4Eqao7HwDNsuJgomYbugJ3Gg@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
	<CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
	<CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
	<CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:51908 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3HSMet (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 08:34:49 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so5287588obc.34
        for <ceph-devel@vger.kernel.org>; Mon, 19 Aug 2013 05:34:48 -0700 (PDT)
In-Reply-To: <CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I started out by defining the plugin system a bit more
(http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw:_plugin_architecture).
I'd really appreciate any comments.

On Wed, Aug 14, 2013 at 8:40 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>>  - "AUTH" (Authentication backends): Rados/internal, Keystone
>
> That's probably the best place to start.

I also started working on an "auth" type of plugin for all Keystone
support based on the plugin system currently described in the
blueprint (it's an extremely simple and flexible system and IMHO a
good way to start). Contrary to the "plugin system", the auth plugin
itself will move a lot of code around and will therefore have a much
greater impact. So it's probably better to separate these projects
completely. If we can reach consensus about the way the first version
of the plugin system should look like, I will separate these commits
into different branches so we can merge it one step at a time.

Roald
