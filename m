From: Sage Weil <sweil@redhat.com>
Subject: Re: mgr dashboard and rest api configs
Date: Fri, 2 Jun 2017 13:41:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706021335380.3646@piezo.novalocal>
References: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal> <CALe9h7fmjF1Yvkvf068nzpvACKfo7qz5PJ5SZdhWsboueg1xFA@mail.gmail.com> <alpine.DEB.2.11.1706012208360.3646@piezo.novalocal> <CALe9h7eQL=G5QHLYcEdrq18Um8xL_g43uNzvLaM2S+Rh1RFf5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdFBNlz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Jun 2017 09:41:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00BF880C0E
        for <ceph-devel@vger.kernel.org>; Fri,  2 Jun 2017 13:41:55 +0000 (UTC)
In-Reply-To: <CALe9h7eQL=G5QHLYcEdrq18Um8xL_g43uNzvLaM2S+Rh1RFf5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Ranto, Boris" <branto@redhat.com>

On Fri, 2 Jun 2017, John Spray wrote:
> >> Assuming we roll back the change that prefixed every key with the
> >> daemon name, modules are free to do their own prefixing for any
> >> settings that they want to be per-daemon.  To enable it we just need
> >> to make sure the module has a way of finding out the name of the
> >> daemon where it's currently running.
> >
> > The reason why it's there now is that (almost) every config key we've used
> > so far need to be able to be mgr-specific.  Do you have an alternative
> > proposal (besides trying mgr/$id/$module/$option or
> > mgr.$id/$Module/$option and then mgr/$module/$option)?
> 
> My proposal is mgr/$module/<whatever the module wants>
> ...which in practice for TLS certs would be mgr/$module/$id/$option
> 
> Then, enable the modules to retrieve their current daemon's config by
> giving them a function that tells them the name of the currently
> running daemon.

That sounds fine to me.

> One day, it would be nice to have modules consume their config from
> the new key/val config store on the mon.  Then, they could just have
> whatever level of cleverness was available for configuration in
> general for those settings, and the current "get_config" stuff would
> be exclusively for persistent state as opposed to user-input config.

FWIW my hope here was to adopt a convention here that matched what we were 
going to do for config.  That's why there is the global -> mgr -> mgr.x 
hierarchy thing.  That might be a fool's errand, though, since we 
(will) have a well-defined set of config options, whereas the module 
options are module-defined.

Anyway, I think the suggestion currently is for

    "mgr/dashboard/x/server_addr",
    "mgr/dashboard/x/server_port",
    "mgr/dashboard/y/server_addr",
    "mgr/dashboard/y/server_port",
    "mgr/restful/keys",
    "mgr/restful/x/crt",
    "mgr/restful/x/key",
    "mgr/restful/x/server_addr",
    "mgr/restful/x/server_port",
    "mgr/restful/y/crt",
    "mgr/restful/y/key",
    "mgr/restful/y/server_addr",
    "mgr/restful/y/server_port"

?

Although I'd probably suggest also changing

    "mgr/restful/keys",

to separate per-key keys, like

    "mgr/restful/keys/$user",

(Also, the 'ceph tell mgr.x create_key $name' thing concerns me a bit 
that it's unclear this is for the restful module.  Should we have modules 
prefix their commands by module name by convention where it makes sense?  
e.g., 'ceph tell mgr.x restful create_key $name'?)

sage
