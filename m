From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 15:08:04 -0700
Message-ID: <CAORUGqCuTnHUxCuH9MT0RrZKO8QBiGj2Ev3NcBQmaCB+hgiYsQ@mail.gmail.com>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
 <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net> <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
 <Pine.LNX.4.64.1203261310240.19530@cobra.newdream.net> <CAORUGqAbHhZJ-=-HXwBZjboUGVKJBP9nBHD4ZKufs7-OeCqKnw@mail.gmail.com>
 <Pine.LNX.4.64.1203261408230.19530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54909 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab2CZWI0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 18:08:26 -0400
Received: by gghe5 with SMTP id e5so4265437ggh.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 15:08:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203261408230.19530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 26, 2012 at 14:55, Sage Weil <sage@newdream.net> wrote:
>> Why do you need to know where osd.42 was last seen just to be able t=
o
>> authoritatively claim osd.42 is 1) down 2) at a new location.
>
> Not "where" but "which". =C2=A0If a ceph-osd stops, and gets restarte=
d (on same
> host, different host, whatever) I want to make sure the _old_ instanc=
e is
> marked down (if not already down) in the map and any new instance is =
not.
> We can't ignore the possibility of a race, as all kinds of things can=
 make
> the notification path go faster or slower than a replacement ceph-osd
> might. =C2=A0addr is just one possible unique identifier to achieve t=
hat; we
> could also use the up_from epoch or anything else unique to the insta=
nce.
> The problem is it is unknown until the process has been alive for a w=
hile,
> so a wrapper can't see it easily.
>
> Well, the addr is (ip, port, nonce) where nonce is actually the pid, =
so if
> we can tell what ip ceph-osd will bind to that might work...

Okay so if I understand correctly, you're worried that this:

- osd.42 pid 123 dies
- small utility sends "osd.42 is dead"
- osd.42 pid 234 starts up

is observed as this:

- osd.42 pid 123 dies
- osd.42 pid 234 starts up
- small utility sends "osd.42 is dead"

?

I'd expect the last two to happen in separate rounds of paxos, or
something, and thus not be reorderable (the client won't reorder them;
it runs the notifier first to completion, only then starts the new
daemon instance).. but if they can be reordered like that, then it
seems like a valid concern. Perhaps the small utility "osd.42 is dead"
should be just a hint, "osd.42 might be dead, please check and flag it
down asap if it doesn't respond"?

>> > execv() in the signal handler, OTOH, is easy. =C2=A0Is it that off=
ensive?
>> >
>> > The other nice thing about that is that the failure notification c=
an be
>> > informative for free: "osd.42 stopped: got SIGTERM", "osd.42 stopp=
ed:
>> > failed assert at foo.cc:1234", etc.
>>
>> I'm worried about all the things that want us to exit(3). Code
>> coverage, valgrind, what not.
>>
>> If you're thinking of shipping the crash reason to monitors, I think
>> you're once again trying to replace a bunch of a sysadmin's toolkit
>> with Ceph-internal features. Ones that they can't use with all the
>> non-Ceph things they run on their storage cluster anyway, like stats=
d,
>> sshd, etc. I feel confident in saying Ceph will lose that race, in
>> stability, functionality and familiarity to target audience.
>
> I see your point, but I don't know what in the sysadmin's toolkit wou=
ld
> actually do this (now or in the future). =C2=A0For an external agent/=
wrapper to
> work it would need to:
>
> =C2=A01- start ceph-osd
> =C2=A02- query it for it's cookie/nonce (or infer what it will be)
> =C2=A03- wait for the process to stop/crash
> =C2=A04- send a notification (using ceph specific tool)
>
> Assuming for a moment that we do want a mon notification if ceph-osd,=
 say,
> fails an assert, what would you expect the process to look like?

Oh, that was "If you're thinking of shipping the crash reason to
monitors, ...". As in, if you're thinking of making "ceph -s" or
something say "osd.42 stopped: Crashed due to SIGSEGV". That part
people have tools for, and it's in no way ceph specific.

I did not mean that part of the message to apply to the failure
discovery optimization.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
