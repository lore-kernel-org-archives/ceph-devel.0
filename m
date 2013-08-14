From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Wed, 14 Aug 2013 10:17:37 -0700
Message-ID: <CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:48732 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758263Ab3HNRRi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 13:17:38 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so7799101vbf.24
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 10:17:37 -0700 (PDT)
In-Reply-To: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 14, 2013 at 5:57 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> Hi all,
>
> For those interested;
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw:_plugin_architecture
>
> I know a plugin architecture is a sensitive subject for a lot of
> people (it is for me at least), but I think it might be worthwhile
> discussing it.
>
> Please comment/flame away :-)
>

I'm all for having a modular architecture. In essence this is
something we've been aiming at although the interfaces are not as
clean and shiny as they should be. OTOH, there's the danger overdoing
it and tying our hands behind our backs, so we need to be careful
about what to get into a plugin/module, and what should stay as it is
now (flexible, albeit monolithic).

Yehuda
