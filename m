From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 14:00:02 -0700
Message-ID: <CAORUGqAbHhZJ-=-HXwBZjboUGVKJBP9nBHD4ZKufs7-OeCqKnw@mail.gmail.com>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
 <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net> <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
 <Pine.LNX.4.64.1203261310240.19530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49520 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2CZVAX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 17:00:23 -0400
Received: by pbcun15 with SMTP id un15so6415774pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 14:00:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203261310240.19530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 26, 2012 at 13:16, Sage Weil <sage@newdream.net> wrote:
>> Perhaps a separate executable that sends "osd.42 is now definitely
>> down" will be good enough? Hopefully you don't have two osd.42's
>> around, anyway. And if you want that, instead of execing ceph-osd, y=
ou
>> do a fork & exec, wait in the parent, then exec that thing that mark=
s
>> it down. For upstart (and often for others too), there's a "after th=
e
>> service exits" hook where we could also plug that in, if we wanted t=
o.
>
> ...except that the way to reliably mark down a particular osd.42 requ=
ires
> data that's private to the ceph-osd instance, and unknown until it st=
arts
> up and joins the cluster. =C2=A0That makes it awkward to implement an=
y kind of
> wrapper because you have to pass it a cookie using some side-channel.

Why do you need to know where osd.42 was last seen just to be able to
authoritatively claim osd.42 is 1) down 2) at a new location.

Think about power supply failure and hotswapping the disk to a new serv=
er.

> execv() in the signal handler, OTOH, is easy. =C2=A0Is it that offens=
ive?
>
> The other nice thing about that is that the failure notification can =
be
> informative for free: "osd.42 stopped: got SIGTERM", "osd.42 stopped:
> failed assert at foo.cc:1234", etc.

I'm worried about all the things that want us to exit(3). Code
coverage, valgrind, what not.

If you're thinking of shipping the crash reason to monitors, I think
you're once again trying to replace a bunch of a sysadmin's toolkit
with Ceph-internal features. Ones that they can't use with all the
non-Ceph things they run on their storage cluster anyway, like statsd,
sshd, etc. I feel confident in saying Ceph will lose that race, in
stability, functionality and familiarity to target audience.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
