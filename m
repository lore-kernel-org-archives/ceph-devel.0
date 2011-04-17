From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: inject args and g_conf (was: "Where I can find the definition/meanings...")
Date: Sat, 16 Apr 2011 22:12:34 -0300
Message-ID: <BANLkTintgp1qKP0cHkf4oKZCuNPt7ORAKg@mail.gmail.com>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
	<BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
	<BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
	<BANLkTinZmtbDsGzGmtMgO-fgUta-Eyxr5Q@mail.gmail.com>
	<3671D55061B844738AD8FCAC9B0D54AE@gmail.com>
	<BANLkTinxeU0k4SgWRaxmYM-XDeRXdvcU0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43659 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab1DQBMf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Apr 2011 21:12:35 -0400
Received: by fxm17 with SMTP id 17so2426956fxm.19
        for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2011 18:12:34 -0700 (PDT)
In-Reply-To: <BANLkTinxeU0k4SgWRaxmYM-XDeRXdvcU0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, AnnyRen <annyren6@gmail.com>, ceph-devel@vger.kernel.org

I found an even better example of how data races can create huge problems.

The "wild branch" problem, courtesy of Hans Boehm.

You have some global variable unsigned u;

then you have code like this:
if (u < 3) {
  switch (u) {
    case 0:
    case 1:
    case 2:
      printf("foo");
      break
  }
}

In this case, if there is a thread concurrently writing the value
"1000" to u, we may get inside the u < 3 block, but then have a value
of u that is not less than 3. Now switch statements are usually
implemented by jump tables. The jump table will have only 3 entries,
because the compiler knows there is no possibility of ever having u >=
3 in a well-formed program. There will be no logic to handle the
default case, because there can't be any... in a well-formed program.

As a consequence, if the assignment to u happens at the right time,
the PC (program counter) may take a "wild branch" to an unknown
location.
Try debugging that.

Colin


On Thu, Apr 7, 2011 at 9:58 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> On Thu, Apr 7, 2011 at 5:29 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>>
>> On Thursday, April 7, 2011 at 5:21 PM, Colin McCabe wrote:
>>> I'm also aware that injectargs changes configuration values that other
>>> threads may be reading, without using a lock or an atomic update. So
>>> far, this doesn't seem to have created any problems, but it is
>>> technically incorrect and a worry. Probably the best way to resolve
>>> it is to construct a full copy of the configuration, change what is
>>> required, and then do an atomic swap on the g_conf pointer.
>>
>> I don't think this *can* cause any problems. There are no other writers to g_conf and, while I don't think we have nested checks (ie, branch based on g_conf, then assume g_conf remains static inside branch), even if we did then our single-dispatch mechanism means we're not going to have concurrent updates of that stuff. :)
>>
>
> On most architectures, 64-bit stores are not atomic, so if you're
> changing, say g_conf.objecter_inflight_op_bytes, there could be a
> brief window when someone could read half of the old value and half of
> the new value.
>
> I'm pretty sure that 64-bit stores end up being atomic on x86-64, if
> they're aligned, which gcc will always make sure of. However, if
> you're using x86 or arm, you're out of luck.
>
> Updating std::string structures is not atomic on any platform, to my knowledge.
>
>> I don't think we have nested checks (ie, branch based on g_conf, then
>> assume g_conf remains static inside branch),
>
> Sorry, we do! If you really need examples, look in the filestore and
> in the logging code.
>
> regards,
> Colin
>
