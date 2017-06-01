From: John Spray <jspray@redhat.com>
Subject: Re: mgr dashboard and rest api configs
Date: Thu, 1 Jun 2017 22:54:19 +0100
Message-ID: <CALe9h7fmjF1Yvkvf068nzpvACKfo7qz5PJ5SZdhWsboueg1xFA@mail.gmail.com>
References: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37038 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAVyl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 17:54:41 -0400
Received: by mail-wm0-f44.google.com with SMTP id d127so5136706wmf.0
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 14:54:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Ranto, Boris" <branto@redhat.com>

On Thu, Jun 1, 2017 at 9:23 PM, Sage Weil <sage@redhat.com> wrote:
> Hi all,
>
> So we now have 2 services in mgr that present http[s] endpoints: the
> dashboard and the new 'restful' API.  Once
> https://github.com/ceph/ceph/pull/15405 is merged these will be set up by
> vstart.sh for each testing:
>
>  $ MGR=2 ../src/vstart.sh -n -l ...
>  ...
>  started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for debug
>  output.
>
>  dashboard urls:  http://127.0.0.1:41542/ http://127.0.0.1:41544/
>  restful urls:    https://127.0.0.1:41543 https://127.0.0.1:41545
>     user/pass:    admin / secret
>  ...

I spent a few minutes there wondering why the authentication wasn't
working until I realise that the "/" rest endpoint gives you that "Use
\"ceph tell mgr create_key <key>\" to create a key pair," prompt even
if you are already authenticated!

> The services are configured via the config-key interface:
>
> gnit:build (wip-rest-test) 04:06 PM $ bin/ceph config-key list
> [
>     "mgr/x/dashboard/server_addr",
>     "mgr/x/dashboard/server_port",
>     "mgr/x/restful/cert",
>     "mgr/x/restful/keys",
>     "mgr/x/restful/pkey_file",
>     "mgr/x/restful/server_addr",
>     "mgr/x/restful/server_port",
>     "mgr/y/dashboard/server_addr",
>     "mgr/y/dashboard/server_port",
>     "mgr/y/restful/cert",
>     "mgr/y/restful/keys",
>     "mgr/y/restful/pkey_file",
>     "mgr/y/restful/server_addr",
>     "mgr/y/restful/server_port"
> ]

Aargh!  All the keys are prefixed with the daemon name!  I missed this
change (dc15cd60) when it went in.

We should undo that.  The idea of the interface for modules is that
they can store things and then retrieve them at any time, including
when they have failed over to another daemon.  Modules are very much
*not* meant to have local state on particular daemons (apart from this
particular special case we're discussing about certificates for things
that do HTTP).

>
> Several comments, questions, as I think there's lots of room for
> improvement here:
>
> - The dashboard is always http; the restful endpoint always https.  Should
> we make either/both of them support either?
>
> - The crt and key for restful can either come from the 'cert' or
> 'pkey' option, a file named by 'cert_file' or 'pkey_file', or read out of
> /etc/ceph.  The ceph-mgr package currently generates an unsigned cert and
> puts it in /etc/ceph for that purpose.  Should we instead make the restful
> service generate its own key and store it on startup if it is not stored
> on disk?  I'm not a big fan of putting this in /etc/ceph.

I would really prefer modules to be self contained with this kind of thing:
 - do their own initial setup, rather than having code in the packaging
 - store their stuff in the get_config/set_config stuff and not on the
local filesystem

iirc the main reason that the restful module wanted to put the cert on
the local filesystem at all was just that it was using a library that
couldn't consume a certificate any way other than a file path?

> - What if you want the crt/key to be shared across mgr daemons?  This
> would make sense if you have a load balancer (or some network indirection
> like that provided by kubernetes) in front of it.  In that case, should we
> allow these options to come from, say, either mgr/$id/$module/$option or
> mgr/*/$module/$option?  Or restructure the namespace so that it's either
> mgr/$module/$option or mgr.$id/$module/$option (more like the config
> sections work where they are [mgr] or [mgr.$id])?  [1]

I think we should avoid going down the path of complex configuration
paths (like having a /mgr/foo/ and /mgr/*/ and a rule about which has
precedence) unless there are cases where it seems absolutely
necessary.

Assuming we roll back the change that prefixed every key with the
daemon name, modules are free to do their own prefixing for any
settings that they want to be per-daemon.  To enable it we just need
to make sure the module has a way of finding out the name of the
daemon where it's currently running.

John

>
> - s/cert/crt/ and s/pkey/key/?
>
> Comments welcome!
> sage
>
>
> [1] How should config options appear in config-key?  The current proposal
> at http://pad.ceph.com/p/ceph-conf-kv-store suggests config/$type/option
> or config/$type.$id/option.  Where do mgr modules fit into this namespace?
>
>    config/mgr/$module/$option
>    config/mgr.x/$module/$option
>
> Or should they maybe not live under the config/ prefix that the "regular"
> ceph options will live under? ?
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
