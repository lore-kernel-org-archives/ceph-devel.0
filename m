From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: config on mons
Date: Mon, 13 Nov 2017 08:29:25 -0800
Message-ID: <CADRKj5Q5S57kmaqbmLbGE-3c8paO8sTTZ2T5Fff-NMK821dKXQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <CADRKj5TuUyaT=pT3vXDnMEzE_tPYQhQvx7X94SOZuHSydrBQhQ@mail.gmail.com> <CALe9h7dwXEFvArnDg7A+=zCmD6R7DR0_S2yx9hxnhgW2U6dgcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:47078 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbdKMQ31 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 11:29:27 -0500
Received: by mail-ot0-f179.google.com with SMTP id o9so14124001ota.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 08:29:27 -0800 (PST)
In-Reply-To: <CALe9h7dwXEFvArnDg7A+=zCmD6R7DR0_S2yx9hxnhgW2U6dgcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 13, 2017 at 1:57 AM, John Spray <jspray@redhat.com> wrote:
> On Mon, Nov 13, 2017 at 1:43 AM, Yehuda Sadeh-Weinraub
> <ysadehwe@redhat.com> wrote:
>>> - What about ceph.conf?  My thought here is to mark which options are
>>> legal for bootstrap (i.e., used during the initial connection to mon to
>>> authenticate and fetch config), and warn on anything other than that in
>>> ceph.conf.  But what about after you connect?  Do these options get reset
>>> to default?
>>
>> And also hat about configurables passed in as args? I think that other
>> than any local configuration (ceph.conf, args) should still be used to
>> override config from mons. We can add warnings and whistles to warn
>> when such configuration exists, but should not lose it.
>
> This comes up whenever we talk about the centralized config so I guess
> it never quite got put to rest...
>
> The big downside to letting services selectively ignore the mons is
> that anyone building a user interface is pretty much screwed if they
> want to show the current value of a config setting, unless we make the
> MonClient config subscription a two-way thing that enables services to
> *set* their own config (from their ceph.conf) in addition to receiving
> it.

More like have them report it, not necessarily set it. We should have that.
I don't like the idea of not being able to modify it without going to
the monitors. There might be cases where either doing that via the
monitors is not practical, or cumbersome, or you'd just want to try
different values quickly, or running in a test or dev environment,
etc. And given that we need to have that subsystem working anyway, as
we need it for bootstrapping, and not everything that we run even
connects or should connect to the cluster, I think it would also make
logical sense.

Yehuda

>
> John
>
>>> - Bootstrapping/upgrade: So far my best idea is to make the client share
>>> it's config with the mon on startup, and the first time a given daemon
>>> connects the mon will use that to populate it's config database.
>>> Thereafter it will be ignored.
>>
>> Maybe there could be some flag that we could pass in to select th
>> client's behavior. By default it'd take the mon config if that exists.
>> Other options would be to take local config, or overlay local over
>> mon.
>>
>> Yehuda
>>
>>>
>>> - OSD startup: lots of stuff happens before we authenticate.  I think
>>> there will be a new initial step to fetch config, then do all that work,
>>> then start up for real.  And a new option to bypass mon configuration
>>> to avoid that (and for old school folks who don't want centralized
>>> configs... e.g. mon_config = false and everything works as before).
>>>
>>> Feedback welcome!
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
