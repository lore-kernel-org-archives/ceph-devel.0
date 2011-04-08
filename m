From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Where I can find the definition/meanings of options parameter in /src/common/config.cc
Date: Thu, 7 Apr 2011 17:21:57 -0700
Message-ID: <BANLkTinZmtbDsGzGmtMgO-fgUta-Eyxr5Q@mail.gmail.com>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
	<BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
	<BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50591 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1DHAV7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 20:21:59 -0400
Received: by fxm17 with SMTP id 17so2025673fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 17:21:57 -0700 (PDT)
In-Reply-To: <BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: AnnyRen <annyren6@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 7, 2011 at 10:09 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Thu, Apr 7, 2011 at 9:33 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
>> Hi AnnyRen,
> ...
>> Also, after using injectargs to change a setting related to logging,
>> you must send the process a SIGHUP to get it to re-read its logging
>> settings.
>
> I assume this is a relatively new requirement? Usually you'd send HUP
> signal to re-read the conf file. When using injectargs, one would
> assume that the new configuration was already updated. Moreover,
> sending HUP signal to all your osds/mds/mons is awfully inconvenient.
> Maybe we can just send the HUP signal in the appropriate handlers?

Hi Yehuda.

It's been this way for a long time, since 2009 at least. The problem
is that there is no notification mechanism for when a configuration
value changes. So we'll continue writing to the same logfile until
someone informs us to re-read g_conf.logfile (or other logging
configuration settings).

There are a few other configuration settings that can't be changed by
injectargs, because some component or other caches their value, and
doesn't know to re-read it when the configuration changes.

We could create a notification mechanism, so that a callback gets
invoked when certain configuration settings change. However, so far,
it hasn't been a priority given the other stuff on the roadmap. The
main configuration settings that tend to get changed at runtime are
logging settings, and certain debug and performance tuning knobs. And
those all do work currently.

I'm also aware that injectargs changes configuration values that other
threads may be reading, without using a lock or an atomic update. So
far, this doesn't seem to have created any problems, but it is
technically incorrect and a worry.  Probably the best way to resolve
it is to construct a full copy of the configuration, change what is
required, and then do an atomic swap on the g_conf pointer.

I guess I'll file a bug/feature request and we can decide where it
fits on the roadmap (probably post 1.0)

Colin
