From: Michael Sevilla <mikesevilla3@gmail.com>
Subject: Re: MDS has inconsistent performance
Date: Fri, 16 Jan 2015 10:34:03 -0800
Message-ID: <CAD=PzH+N91wHudqOZawwQ9XoX-GQZdX7Sqin7hJfnwBbjE0Pmw@mail.gmail.com>
References: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
	<CAC6JEv9fXSm+xEcFPiJ90kQNKjoWdFZCs02ZHKD4kJGd4_2Q8w@mail.gmail.com>
	<CAD=PzHLahg1TPu3-zjFk6hO4cXeYg+-TjdR5cw0XNSoVA+_Ebw@mail.gmail.com>
	<CAC6JEv_1Gx3pnmutej7UmABC+eyB+VvoBo6X1OZhHFu+==6fjA@mail.gmail.com>
	<CAD=PzHJFT4QUeer7A-EawAQ=AskEu44pLPqHo4BLpk11zA1UQw@mail.gmail.com>
	<CAC6JEv826RqkkTCt3224LLv_BdS9394yucXf7_qaKwsYHmC-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47084 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbbAPSeF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 13:34:05 -0500
Received: by mail-lb0-f173.google.com with SMTP id b6so7054789lbj.4
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 10:34:03 -0800 (PST)
In-Reply-To: <CAC6JEv826RqkkTCt3224LLv_BdS9394yucXf7_qaKwsYHmC-+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>

On Thu, Jan 15, 2015 at 10:37 PM, Gregory Farnum <greg@gregs42.com> wro=
te:
> On Thu, Jan 15, 2015 at 2:44 PM, Michael Sevilla <mikesevilla3@gmail.=
com> wrote:
>> Let me know if this works and/or you need anything else:
>>
>> https://www.dropbox.com/s/fq47w6jebnyluu0/lookup-logs.tar.gz?dl=3D0
>>
>> Beware - the clients were on debug=3D10. Also, I tried this with the
>> kernel client and it is more consistent; it does the 2 lookups per
>> create on 1 client every single time.
>
> Mmmm, there are no mds logs of note here. :(
>

Meaning you couldn't find mds.issdm-15.log? Or that that log didn't
show anything interesting...

> I did look enough to see that:
> 1) The MDS is for some reason revoking caps on the file create
> prompting the switch to double-lookups, which it was not before. The
> client doesn't really have any visibility into why that would be the
> case; the best guess I can come up with is that maybe the MDS split u=
p
> the directory into multiple frags at this point =E2=80=94 do you have=
 that
> enabled?

Nope, unless any of these make a difference:
$ ceph --admin-daemon... config show | grep frag
  "mds_bal_frag": "false",
  "mds_bal_fragment_interval": "5",
  "mds_thrash_fragments": "0",
  "mds_debug_frag": "false",

> 2) The only way we set the I_COMPLETE flag is when we create an empty
> directory, or when we do a complete listdir on one. That makes it
> pretty difficult to get the flag back (and so do the optimal create
> path) once you lose it. :( I'd love a better way to do so, but we'll
> have to look at what's involved in a bit of depth.

No need - with that reasoning it looks more like this is part of the
design rather than a bug. I'll just have to accept the fact that the
system is very complicated and clients touching stuff at certain times
can make things less predictable... I just wanted to make sure I
wasn't doing anything wrong. :)  I'll stick with the kernel client
(it's almost twice as fast, anyways!)

> I'm not sure why the kernel client is so much more cautious, but I
> think there were a number of troubles with the directory listing
> orders and things which were harder to solve there =E2=80=93 I don't =
remember
> if we introduced the I_DIR_ORDERED flag in it or not. Zheng can talk
> more about that. What kernel client version are you using?
>
> And for a vanity data point, what kind of hardware is your MDS runnin=
g on? :)

Really, really old hardware from 2006: 2 dual-core CPUs, 8GB RAM,
connected with 1Gbit. Kernel 3.4. We actually just installed beefier
nodes so I'll keep you posted if we get other cool results.

Thanks for all your help, Greg!


> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
