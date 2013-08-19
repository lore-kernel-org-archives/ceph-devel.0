From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: RGW blueprint for plugin architecture
Date: Mon, 19 Aug 2013 22:55:23 +0200
Message-ID: <CAN04cT5jGGJThJgj47WZxrG9HB-0DywNY4Hw5kQkObOvWsjw8g@mail.gmail.com>
References: <CAN04cT4C-odh4_9OZ2xWx90aPWFTvJ_DgZJ-O88-dyXJy=jMGg@mail.gmail.com>
	<CABBk=J-JTFB2Crb0NZfxbMDGMsVY=XhmjZT1D3MwQPaKrDy+Nw@mail.gmail.com>
	<CAN04cT6uOTYx7Mk0sMWBBwzy=Muf40ZkZDUpgYpQ6=9ZE=TvBw@mail.gmail.com>
	<CABBk=J-LASxNT49pQ9oSK-p189FiuCQ0dA540v0MhCzmTf-Uzg@mail.gmail.com>
	<CAN04cT6vHxCVWMPEZM1Ppqfbbv4Eqao7HwDNsuJgomYbugJ3Gg@mail.gmail.com>
	<CABBk=J_LXDxpv8shUVr9sf6De5wayQ9r1tPJC1rmzwdJfqnQHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:52638 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3HSUzY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 16:55:24 -0400
Received: by mail-ob0-f180.google.com with SMTP id up14so4783045obb.11
        for <ceph-devel@vger.kernel.org>; Mon, 19 Aug 2013 13:55:23 -0700 (PDT)
In-Reply-To: <CABBk=J_LXDxpv8shUVr9sf6De5wayQ9r1tPJC1rmzwdJfqnQHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda,

Thanks for the comments.

Yeah, I created the wip-rgw-plugin to get a feeling of how it would
look like. It's probably better to see it as a sandbox, but it already
clearly shows some of the flaws that you point out.

It doesn't need to link into the rgw binary of course, but yes the
dl'd .so still expects the (although unexported) symbols to be there.

I personally am a *big* fan of a clean internal API and dynamically
loadable libraries, especially because I want the librgw to have this
feature in the future. For instance, I'd really like a nginx module
one day which links to librgw but not all of the APIs or all of the
authentication mechanism. The nginx module might want to load/unload
specific plugins when it needs to. Same goes for a python extension.
An import rgw should not always also be an import rgw.s3 etc. I'd
really like these features and mostly I'd really like these features
to be slim and not 50+ MB plus....

I agree it's a lot of work (wouldn't call it noble though), but I
don't see that as an argument to not do it. However, I also agree that
the blueprint/internal API should be extended much more. That's why I
asked for comments to begin with :-)

I'll start thinking about a design for an internal API but I'll
definitely need some help with that. I'm not a fulltime Ceph developer
:-)

Roald




On Mon, Aug 19, 2013 at 10:05 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Mon, Aug 19, 2013 at 5:34 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
>> Hi,
>>
>> I started out by defining the plugin system a bit more
>> (http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw:_plugin_architecture).
>> I'd really appreciate any comments.
>>
>> On Wed, Aug 14, 2013 at 8:40 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>>>>  - "AUTH" (Authentication backends): Rados/internal, Keystone
>>>
>>> That's probably the best place to start.
>>
>> I also started working on an "auth" type of plugin for all Keystone
>> support based on the plugin system currently described in the
>> blueprint (it's an extremely simple and flexible system and IMHO a
>> good way to start). Contrary to the "plugin system", the auth plugin
>> itself will move a lot of code around and will therefore have a much
>> greater impact. So it's probably better to separate these projects
>> completely. If we can reach consensus about the way the first version
>> of the plugin system should look like, I will separate these commits
>> into different branches so we can merge it one step at a time.
>>
>
> I went over the blueprint, and partially through the code
> (wip-rgw-plugin). I'm not completely sure about the plugin <-> core
> interface that you had in mind. At the moment there's no clean
> interface, and it just links directly. For example, the keystone
> plugin needs to call rgw_store_user_info(), the KeystoneClient needs
> to inherit from RGWHTTPClient, etc.
> So on one hand we now move this code into external module, but otoh,
> it still need to link into the monolithic rgw core. Having a clean
> internal api might be a noble idea, but I'm not sure it's very
> practical (which is in line with what's there now).
> Having a linux-kernel like module model makes sense here. The
> modules/plugins will need to be compiled against the specific version
> in order for them to be able to load successfully.
> Also, I'm not sure that we need to bother with dynamic loading.
>
> Yehuda
