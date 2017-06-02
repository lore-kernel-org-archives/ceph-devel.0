From: John Spray <jspray@redhat.com>
Subject: Re: mgr dashboard and rest api configs
Date: Fri, 2 Jun 2017 09:36:00 +0100
Message-ID: <CALe9h7eQL=G5QHLYcEdrq18Um8xL_g43uNzvLaM2S+Rh1RFf5w@mail.gmail.com>
References: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>
 <CALe9h7fmjF1Yvkvf068nzpvACKfo7qz5PJ5SZdhWsboueg1xFA@mail.gmail.com> <alpine.DEB.2.11.1706012208360.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35193 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdFBIgW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 04:36:22 -0400
Received: by mail-wm0-f54.google.com with SMTP id b84so16975322wmh.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jun 2017 01:36:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706012208360.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Ranto, Boris" <branto@redhat.com>

On Thu, Jun 1, 2017 at 11:16 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 1 Jun 2017, John Spray wrote:
>> On Thu, Jun 1, 2017 at 9:23 PM, Sage Weil <sage@redhat.com> wrote:
>> > Hi all,
>> >
>> > So we now have 2 services in mgr that present http[s] endpoints: the
>> > dashboard and the new 'restful' API.  Once
>> > https://github.com/ceph/ceph/pull/15405 is merged these will be set up by
>> > vstart.sh for each testing:
>> >
>> >  $ MGR=2 ../src/vstart.sh -n -l ...
>> >  ...
>> >  started.  stop.sh to stop.  see out/* (e.g. 'tail -f out/????') for debug
>> >  output.
>> >
>> >  dashboard urls:  http://127.0.0.1:41542/ http://127.0.0.1:41544/
>> >  restful urls:    https://127.0.0.1:41543 https://127.0.0.1:41545
>> >     user/pass:    admin / secret
>> >  ...
>>
>> I spent a few minutes there wondering why the authentication wasn't
>> working until I realise that the "/" rest endpoint gives you that "Use
>> \"ceph tell mgr create_key <key>\" to create a key pair," prompt even
>> if you are already authenticated!
>>
>> > The services are configured via the config-key interface:
>> >
>> > gnit:build (wip-rest-test) 04:06 PM $ bin/ceph config-key list
>> > [
>> >     "mgr/x/dashboard/server_addr",
>> >     "mgr/x/dashboard/server_port",
>> >     "mgr/x/restful/cert",
>> >     "mgr/x/restful/keys",
>> >     "mgr/x/restful/pkey_file",
>> >     "mgr/x/restful/server_addr",
>> >     "mgr/x/restful/server_port",
>> >     "mgr/y/dashboard/server_addr",
>> >     "mgr/y/dashboard/server_port",
>> >     "mgr/y/restful/cert",
>> >     "mgr/y/restful/keys",
>> >     "mgr/y/restful/pkey_file",
>> >     "mgr/y/restful/server_addr",
>> >     "mgr/y/restful/server_port"
>> > ]
>>
>> Aargh!  All the keys are prefixed with the daemon name!  I missed this
>> change (dc15cd60) when it went in.
>>
>> We should undo that.  The idea of the interface for modules is that
>> they can store things and then retrieve them at any time, including
>> when they have failed over to another daemon.  Modules are very much
>> *not* meant to have local state on particular daemons (apart from this
>> particular special case we're discussing about certificates for things
>> that do HTTP).
>
> Okay, but I think all of these options (except 'keys') fall into that
> special case.  We can make get_config() look at mgr/$id/$module/$option
> and, if it doesn't exist, then look at mgr/$module/$option... or make a
> special variant of get_config() for the possibly-mgr-localized options?

Having that get_config variant would be a totally reasonable helper
function on the python side, but I don't think it's essential enough
to make it a first class part of the module interface, as it's just a
string prefix to the key.

>> > Several comments, questions, as I think there's lots of room for
>> > improvement here:
>> >
>> > - The dashboard is always http; the restful endpoint always https.  Should
>> > we make either/both of them support either?
>> >
>> > - The crt and key for restful can either come from the 'cert' or
>> > 'pkey' option, a file named by 'cert_file' or 'pkey_file', or read out of
>> > /etc/ceph.  The ceph-mgr package currently generates an unsigned cert and
>> > puts it in /etc/ceph for that purpose.  Should we instead make the restful
>> > service generate its own key and store it on startup if it is not stored
>> > on disk?  I'm not a big fan of putting this in /etc/ceph.
>>
>> I would really prefer modules to be self contained with this kind of thing:
>>  - do their own initial setup, rather than having code in the packaging
>>  - store their stuff in the get_config/set_config stuff and not on the
>> local filesystem
>>
>> iirc the main reason that the restful module wanted to put the cert on
>> the local filesystem at all was just that it was using a library that
>> couldn't consume a certificate any way other than a file path?
>
> That part I fixed with NamedTemporaryFile in
>         https://github.com/liewegas/ceph/commit/c169c8fd461bf94459cd98b658d2a2d8bf42bca6
>
> Was there also a python module dependency problem?  If not, it seems much
> more natural for the module to create the crt/key pair the first time it
> stats if it's not present...
>
>> > - What if you want the crt/key to be shared across mgr daemons?  This
>> > would make sense if you have a load balancer (or some network indirection
>> > like that provided by kubernetes) in front of it.  In that case, should we
>> > allow these options to come from, say, either mgr/$id/$module/$option or
>> > mgr/*/$module/$option?  Or restructure the namespace so that it's either
>> > mgr/$module/$option or mgr.$id/$module/$option (more like the config
>> > sections work where they are [mgr] or [mgr.$id])?  [1]
>>
>> I think we should avoid going down the path of complex configuration
>> paths (like having a /mgr/foo/ and /mgr/*/ and a rule about which has
>> precedence) unless there are cases where it seems absolutely
>> necessary.
>
> Like this one?

What I meant to say was: I think we should avoid doing this *as part
of the way the module config options work in general* -- without us
having this conversation at all, individual modules can still have
multiple paths for something and apply their own rules for which
option they prefer to respect when they have two ways of setting it.

>> Assuming we roll back the change that prefixed every key with the
>> daemon name, modules are free to do their own prefixing for any
>> settings that they want to be per-daemon.  To enable it we just need
>> to make sure the module has a way of finding out the name of the
>> daemon where it's currently running.
>
> The reason why it's there now is that (almost) every config key we've used
> so far need to be able to be mgr-specific.  Do you have an alternative
> proposal (besides trying mgr/$id/$module/$option or
> mgr.$id/$Module/$option and then mgr/$module/$option)?

My proposal is mgr/$module/<whatever the module wants>
...which in practice for TLS certs would be mgr/$module/$id/$option

Then, enable the modules to retrieve their current daemon's config by
giving them a function that tells them the name of the currently
running daemon.

One day, it would be nice to have modules consume their config from
the new key/val config store on the mon.  Then, they could just have
whatever level of cleverness was available for configuration in
general for those settings, and the current "get_config" stuff would
be exclusively for persistent state as opposed to user-input config.

John
