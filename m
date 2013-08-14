From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Wed, 14 Aug 2013 11:40:30 -0700
Message-ID: <CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
	<CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
	<CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:40570 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782Ab3HNSka (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 14:40:30 -0400
Received: by mail-vc0-f178.google.com with SMTP id ha12so5536888vcb.9
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 11:40:30 -0700 (PDT)
In-Reply-To: <CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 14, 2013 at 11:24 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> I most definitely agree, that's why I think a lightweight and
> extensible solution would be best. No big interface description but
> just a simple loader function with parameters depending on the type of
> 'plugin'. If we need another type of plugin, we can add that later on
> (of course, we have to be extra careful not to make a mess of things
> and end up having to define another plugin type for every single
> plugin). That way we can end up having the best of both ways; modular
> and flexible.
>
> What do you think would be the best way to start? Probably to define
> types of plugins? I can think of two types of plugins right now:
>
>  - "API" (REST APIs): S3, Swift, (GS?) etc

I think that for this to actually work out we'd need to provide a
stable internal api, which I think that at this point would be quite a
big task.

>  - "AUTH" (Authentication backends): Rados/internal, Keystone

That's probably the best place to start.

>
> Implementing these will mostly require moving some code around. That
> would be doable IMHO. If we have at least the basic plugin framework
> up&running, people can start writing their stuff in plugins (instead
> of keeping a bunch of patches laying around like I do because they
> make no sense in the current monolithic code base).
>
> I think we can do this without tying our hands behind our backs. And
> as longs as we keep it to simply moving existing code into plugins
> instead of adding new code until we have a plugin system with which we
> can live with, we can always go back without breaking functionality.
>
> Roald
>
> On Wed, Aug 14, 2013 at 7:17 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> On Wed, Aug 14, 2013 at 5:57 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
>>> Hi all,
>>>
>>> For those interested;
>>> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw:_plugin_architecture
>>>
>>> I know a plugin architecture is a sensitive subject for a lot of
>>> people (it is for me at least), but I think it might be worthwhile
>>> discussing it.
>>>
>>> Please comment/flame away :-)
>>>
>>
>> I'm all for having a modular architecture. In essence this is
>> something we've been aiming at although the interfaces are not as
>> clean and shiny as they should be. OTOH, there's the danger overdoing
>> it and tying our hands behind our backs, so we need to be careful
>> about what to get into a plugin/module, and what should stay as it is
>> now (flexible, albeit monolithic).
>>
>> Yehuda
