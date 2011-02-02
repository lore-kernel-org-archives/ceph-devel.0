From: Neville Burnell <neville.burnell@gmail.com>
Subject: Fwd: Simple test system not working
Date: Wed, 2 Feb 2011 13:53:36 +1100
Message-ID: <AANLkTimbVpmXzosp2z8aNeMv4WWk+ONoCubpD482Gva8@mail.gmail.com>
References: <loom.20110201T072445-567@post.gmane.org> <4D4890C3.3060408@hq.newdream.net>
 <loom.20110202T021600-867@post.gmane.org> <AANLkTinHREewy2QUt8cC33YzaTdS56VENBV6m2-kUuoM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34727 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1BBCx5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 21:53:57 -0500
Received: by qyj19 with SMTP id 19so5540942qyj.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 18:53:57 -0800 (PST)
In-Reply-To: <AANLkTinHREewy2QUt8cC33YzaTdS56VENBV6m2-kUuoM@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

G'Day Chris!

Just a guess, but maybe ceph is performing a dns lookup for b3 which
is returning 127.0.0.1, and talking to 127.0.0.1 requires the loopback
adapter?

Kind Regards

Nev

On 2 February 2011 13:39, Chris Dunlop <chris@onthe.net.au> wrote:
>
> Samuel Just <samuelj <at> hq.newdream.net> writes:
> > From the logs, it looks like the osd and mds are failing to bind to
> > an address. =A0Perhaps b3 is not a valid host name?
>
> Thanks!
>
> That wasn't it (b3 is valid), but you started me looking at the
> networking side of things again (for the nth time) and this time
> around I noticed there was no loopback interface on the box. That in
> itself was odd, although it didn't immediately spring to mind that th=
e
> lack of a loopback would stop ceph working. But I added a loopback
> anyway on the basis of "avoid oddness" and that got it all going. I
> still don't know why a loopback is required for ceph, but apparently
> it is!
>
> FYI, with it working, the osd and mds are still bound to the wildcard
> address rather than to a specific address (as they were before the
> loopback was installed). =A0Without loopback:
>
> # lsof -n -i | egrep 'COMMAND|cmon|cmds|cosd'
> COMMAND =A0 =A0PID =A0 =A0USER =A0 FD =A0 TYPE DEVICE SIZE NODE NAME
> cmon =A0 =A0 =A03321 =A0 =A0root =A0 =A05u =A0IPv4 =A0 8451 =A0 =A0 =A0=
 TCP 10.200.63.129:6789 (LISTEN)
> cmds =A0 =A0 =A03357 =A0 =A0root =A0 =A04u =A0IPv4 =A0 8465 =A0 =A0 =A0=
 TCP *:6800 (LISTEN)
> cmds =A0 =A0 =A03357 =A0 =A0root =A0 =A05u =A0IPv4 =A010044 =A0 =A0 =A0=
 TCP
> 10.200.63.129:59480->10.200.63.129:6789 (SYN_SENT)
> cosd =A0 =A0 =A03466 =A0 =A0root =A0 =A03u =A0IPv4 =A0 8548 =A0 =A0 =A0=
 TCP *:6801 (LISTEN)
> cosd =A0 =A0 =A03466 =A0 =A0root =A0 =A05u =A0IPv4 =A0 8549 =A0 =A0 =A0=
 TCP *:6802 (LISTEN)
> cosd =A0 =A0 =A03466 =A0 =A0root =A0 =A06u =A0IPv4 =A0 8550 =A0 =A0 =A0=
 TCP *:6803 (LISTEN)
> cosd =A0 =A0 =A03466 =A0 =A0root =A0 13u =A0IPv4 =A010046 =A0 =A0 =A0=
 TCP
> 10.200.63.129:59481->10.200.63.129:6789 (SYN_SENT)
>
> Note that the DEVICE number for the SYN_SENT connections keeps
> changing in this situation.
>
> With the loopback:
>
> # lsof -n -i | egrep 'COMMAND|cmon|cmds|cosd'
> COMMAND =A0 =A0PID =A0 =A0USER =A0 FD =A0 TYPE DEVICE SIZE NODE NAME
> cmon =A0 =A0 =A06633 =A0 =A0root =A0 =A05u =A0IPv4 =A013277 =A0 =A0 =A0=
 TCP 10.200.63.129:6789 (LISTEN)
> cmon =A0 =A0 =A06633 =A0 =A0root =A0 =A06u =A0IPv4 =A014353 =A0 =A0 =A0=
 TCP
> 10.200.63.129:6789->10.200.63.129:32884 (ESTABLISHED)
> cmon =A0 =A0 =A06633 =A0 =A0root =A0 =A07u =A0IPv4 =A013367 =A0 =A0 =A0=
 TCP
> 10.200.63.129:6789->10.200.63.129:32883 (ESTABLISHED)
> cmds =A0 =A0 =A06669 =A0 =A0root =A0 =A04u =A0IPv4 =A013294 =A0 =A0 =A0=
 TCP *:6800 (LISTEN)
> cmds =A0 =A0 =A06669 =A0 =A0root =A0 =A05u =A0IPv4 =A013366 =A0 =A0 =A0=
 TCP
> 10.200.63.129:32883->10.200.63.129:6789 (ESTABLISHED)
> cmds =A0 =A0 =A06669 =A0 =A0root =A0 10u =A0IPv4 =A013456 =A0 =A0 =A0=
 TCP
> 10.200.63.129:41828->10.200.63.129:6801 (ESTABLISHED)
> cosd =A0 =A0 =A06741 =A0 =A0root =A0 =A03u =A0IPv4 =A014350 =A0 =A0 =A0=
 TCP *:6801 (LISTEN)
> cosd =A0 =A0 =A06741 =A0 =A0root =A0 =A05u =A0IPv4 =A014351 =A0 =A0 =A0=
 TCP *:6802 (LISTEN)
> cosd =A0 =A0 =A06741 =A0 =A0root =A0 =A06u =A0IPv4 =A014352 =A0 =A0 =A0=
 TCP *:6803 (LISTEN)
> cosd =A0 =A0 =A06741 =A0 =A0root =A0 13u =A0IPv4 =A013401 =A0 =A0 =A0=
 TCP
> 10.200.63.129:32884->10.200.63.129:6789 (ESTABLISHED)
> cosd =A0 =A0 =A06741 =A0 =A0root =A0 14u =A0IPv4 =A014467 =A0 =A0 =A0=
 TCP
> 10.200.63.129:6801->10.200.63.129:41828 (ESTABLISHED)
>
>
>
>
> Cheers,
>
> Chris.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
