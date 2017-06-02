From: John Spray <jspray@redhat.com>
Subject: Re: mgr dashboard and rest api configs
Date: Fri, 2 Jun 2017 14:46:25 +0100
Message-ID: <CALe9h7dqpS_Sv8FCi0JAC+9J6OiE8KwWFPPtdtkxeRca5N6jig@mail.gmail.com>
References: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>
 <CALe9h7fmjF1Yvkvf068nzpvACKfo7qz5PJ5SZdhWsboueg1xFA@mail.gmail.com>
 <alpine.DEB.2.11.1706012208360.3646@piezo.novalocal> <CALe9h7eQL=G5QHLYcEdrq18Um8xL_g43uNzvLaM2S+Rh1RFf5w@mail.gmail.com>
 <alpine.DEB.2.11.1706021335380.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37861 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdFBNqw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 09:46:52 -0400
Received: by mail-wm0-f53.google.com with SMTP id d127so27381782wmf.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jun 2017 06:46:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706021335380.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Ranto, Boris" <branto@redhat.com>

On Fri, Jun 2, 2017 at 2:41 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 2 Jun 2017, John Spray wrote:
>> >> Assuming we roll back the change that prefixed every key with the
>> >> daemon name, modules are free to do their own prefixing for any
>> >> settings that they want to be per-daemon.  To enable it we just need
>> >> to make sure the module has a way of finding out the name of the
>> >> daemon where it's currently running.
>> >
>> > The reason why it's there now is that (almost) every config key we've used
>> > so far need to be able to be mgr-specific.  Do you have an alternative
>> > proposal (besides trying mgr/$id/$module/$option or
>> > mgr.$id/$Module/$option and then mgr/$module/$option)?
>>
>> My proposal is mgr/$module/<whatever the module wants>
>> ...which in practice for TLS certs would be mgr/$module/$id/$option
>>
>> Then, enable the modules to retrieve their current daemon's config by
>> giving them a function that tells them the name of the currently
>> running daemon.
>
> That sounds fine to me.
>
>> One day, it would be nice to have modules consume their config from
>> the new key/val config store on the mon.  Then, they could just have
>> whatever level of cleverness was available for configuration in
>> general for those settings, and the current "get_config" stuff would
>> be exclusively for persistent state as opposed to user-input config.
>
> FWIW my hope here was to adopt a convention here that matched what we were
> going to do for config.  That's why there is the global -> mgr -> mgr.x
> hierarchy thing.  That might be a fool's errand, though, since we
> (will) have a well-defined set of config options, whereas the module
> options are module-defined.
>
> Anyway, I think the suggestion currently is for
>
>     "mgr/dashboard/x/server_addr",
>     "mgr/dashboard/x/server_port",
>     "mgr/dashboard/y/server_addr",
>     "mgr/dashboard/y/server_port",
>     "mgr/restful/keys",
>     "mgr/restful/x/crt",
>     "mgr/restful/x/key",
>     "mgr/restful/x/server_addr",
>     "mgr/restful/x/server_port",
>     "mgr/restful/y/crt",
>     "mgr/restful/y/key",
>     "mgr/restful/y/server_addr",
>     "mgr/restful/y/server_port"
>
> ?
>
> Although I'd probably suggest also changing
>
>     "mgr/restful/keys",
>
> to separate per-key keys, like
>
>     "mgr/restful/keys/$user",
>
> (Also, the 'ceph tell mgr.x create_key $name' thing concerns me a bit
> that it's unclear this is for the restful module.  Should we have modules
> prefix their commands by module name by convention where it makes sense?
> e.g., 'ceph tell mgr.x restful create_key $name'?)

Yes, I think so.  We'll have cases like this where the commands are
obviously module-ish, and other cases where modules want to expose
first class/top-level things, so leaving it up to the module to put
its own name at the start seems like the way to go.

John

>
> sage
