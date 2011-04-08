From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: inject args and g_conf (was: "Where I can find the definition/meanings...")
Date: Thu, 7 Apr 2011 17:58:07 -0700
Message-ID: <BANLkTinxeU0k4SgWRaxmYM-XDeRXdvcU0A@mail.gmail.com>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
	<BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
	<BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
	<BANLkTinZmtbDsGzGmtMgO-fgUta-Eyxr5Q@mail.gmail.com>
	<3671D55061B844738AD8FCAC9B0D54AE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38239 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab1DHA6I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 20:58:08 -0400
Received: by fxm17 with SMTP id 17so2037268fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 17:58:07 -0700 (PDT)
In-Reply-To: <3671D55061B844738AD8FCAC9B0D54AE@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, AnnyRen <annyren6@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 7, 2011 at 5:29 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
>
> On Thursday, April 7, 2011 at 5:21 PM, Colin McCabe wrote:
>> I'm also aware that injectargs changes configuration values that other
>> threads may be reading, without using a lock or an atomic update. So
>> far, this doesn't seem to have created any problems, but it is
>> technically incorrect and a worry. Probably the best way to resolve
>> it is to construct a full copy of the configuration, change what is
>> required, and then do an atomic swap on the g_conf pointer.
>
> I don't think this *can* cause any problems. There are no other writers to g_conf and, while I don't think we have nested checks (ie, branch based on g_conf, then assume g_conf remains static inside branch), even if we did then our single-dispatch mechanism means we're not going to have concurrent updates of that stuff. :)
>

On most architectures, 64-bit stores are not atomic, so if you're
changing, say g_conf.objecter_inflight_op_bytes, there could be a
brief window when someone could read half of the old value and half of
the new value.

I'm pretty sure that 64-bit stores end up being atomic on x86-64, if
they're aligned, which gcc will always make sure of. However, if
you're using x86 or arm, you're out of luck.

Updating std::string structures is not atomic on any platform, to my knowledge.

> I don't think we have nested checks (ie, branch based on g_conf, then
> assume g_conf remains static inside branch),

Sorry, we do! If you really need examples, look in the filestore and
in the logging code.

regards,
Colin
