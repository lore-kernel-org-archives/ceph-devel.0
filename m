From: John Spray <jspray@redhat.com>
Subject: Re: config on mons
Date: Mon, 13 Nov 2017 09:57:51 +0000
Message-ID: <CALe9h7dwXEFvArnDg7A+=zCmD6R7DR0_S2yx9hxnhgW2U6dgcA@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal> <CADRKj5TuUyaT=pT3vXDnMEzE_tPYQhQvx7X94SOZuHSydrBQhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:54942 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdKMJ6N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 04:58:13 -0500
Received: by mail-wr0-f180.google.com with SMTP id l22so13857314wrc.11
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 01:58:12 -0800 (PST)
In-Reply-To: <CADRKj5TuUyaT=pT3vXDnMEzE_tPYQhQvx7X94SOZuHSydrBQhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 13, 2017 at 1:43 AM, Yehuda Sadeh-Weinraub
<ysadehwe@redhat.com> wrote:
>> - What about ceph.conf?  My thought here is to mark which options are
>> legal for bootstrap (i.e., used during the initial connection to mon to
>> authenticate and fetch config), and warn on anything other than that in
>> ceph.conf.  But what about after you connect?  Do these options get reset
>> to default?
>
> And also hat about configurables passed in as args? I think that other
> than any local configuration (ceph.conf, args) should still be used to
> override config from mons. We can add warnings and whistles to warn
> when such configuration exists, but should not lose it.

This comes up whenever we talk about the centralized config so I guess
it never quite got put to rest...

The big downside to letting services selectively ignore the mons is
that anyone building a user interface is pretty much screwed if they
want to show the current value of a config setting, unless we make the
MonClient config subscription a two-way thing that enables services to
*set* their own config (from their ceph.conf) in addition to receiving
it.

John

>> - Bootstrapping/upgrade: So far my best idea is to make the client share
>> it's config with the mon on startup, and the first time a given daemon
>> connects the mon will use that to populate it's config database.
>> Thereafter it will be ignored.
>
> Maybe there could be some flag that we could pass in to select th
> client's behavior. By default it'd take the mon config if that exists.
> Other options would be to take local config, or overlay local over
> mon.
>
> Yehuda
>
>>
>> - OSD startup: lots of stuff happens before we authenticate.  I think
>> there will be a new initial step to fetch config, then do all that work,
>> then start up for real.  And a new option to bypass mon configuration
>> to avoid that (and for old school folks who don't want centralized
>> configs... e.g. mon_config = false and everything works as before).
>>
>> Feedback welcome!
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
