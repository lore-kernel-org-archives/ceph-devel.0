From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS has inconsistent performance
Date: Fri, 16 Jan 2015 10:43:17 -0800
Message-ID: <CAC6JEv_n2Sp8o+0_AjKdBsNAmVWtv6pqegCyS3cNjNGSNfpwTQ@mail.gmail.com>
References: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
	<CAC6JEv9fXSm+xEcFPiJ90kQNKjoWdFZCs02ZHKD4kJGd4_2Q8w@mail.gmail.com>
	<CAD=PzHLahg1TPu3-zjFk6hO4cXeYg+-TjdR5cw0XNSoVA+_Ebw@mail.gmail.com>
	<CAC6JEv_1Gx3pnmutej7UmABC+eyB+VvoBo6X1OZhHFu+==6fjA@mail.gmail.com>
	<CAD=PzHJFT4QUeer7A-EawAQ=AskEu44pLPqHo4BLpk11zA1UQw@mail.gmail.com>
	<CAC6JEv826RqkkTCt3224LLv_BdS9394yucXf7_qaKwsYHmC-+A@mail.gmail.com>
	<CAD=PzH+N91wHudqOZawwQ9XoX-GQZdX7Sqin7hJfnwBbjE0Pmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:51131 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbAPSnT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 13:43:19 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so4757501iga.0
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 10:43:18 -0800 (PST)
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com. [209.85.223.172])
        by mx.google.com with ESMTPSA id ku2sm1820401igb.11.2015.01.16.10.43.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 10:43:17 -0800 (PST)
Received: by mail-ie0-f172.google.com with SMTP id tr6so22181096ieb.3
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 10:43:17 -0800 (PST)
In-Reply-To: <CAD=PzH+N91wHudqOZawwQ9XoX-GQZdX7Sqin7hJfnwBbjE0Pmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>

On Fri, Jan 16, 2015 at 10:34 AM, Michael Sevilla
<mikesevilla3@gmail.com> wrote:
> On Thu, Jan 15, 2015 at 10:37 PM, Gregory Farnum <greg@gregs42.com> w=
rote:
>> On Thu, Jan 15, 2015 at 2:44 PM, Michael Sevilla <mikesevilla3@gmail=
=2Ecom> wrote:
>>> Let me know if this works and/or you need anything else:
>>>
>>> https://www.dropbox.com/s/fq47w6jebnyluu0/lookup-logs.tar.gz?dl=3D0
>>>
>>> Beware - the clients were on debug=3D10. Also, I tried this with th=
e
>>> kernel client and it is more consistent; it does the 2 lookups per
>>> create on 1 client every single time.
>>
>> Mmmm, there are no mds logs of note here. :(
>>
>
> Meaning you couldn't find mds.issdm-15.log? Or that that log didn't
> show anything interesting...

It's not interesting. Caps are not logged at a very high level so I
think we'd actually want debug 20 on the mds, the messenger, and the
client subsystems.

>
>> I did look enough to see that:
>> 1) The MDS is for some reason revoking caps on the file create
>> prompting the switch to double-lookups, which it was not before. The
>> client doesn't really have any visibility into why that would be the
>> case; the best guess I can come up with is that maybe the MDS split =
up
>> the directory into multiple frags at this point =E2=80=94 do you hav=
e that
>> enabled?
>
> Nope, unless any of these make a difference:
> $ ceph --admin-daemon... config show | grep frag
>   "mds_bal_frag": "false",
>   "mds_bal_fragment_interval": "5",
>   "mds_thrash_fragments": "0",
>   "mds_debug_frag": "false",
>
>> 2) The only way we set the I_COMPLETE flag is when we create an empt=
y
>> directory, or when we do a complete listdir on one. That makes it
>> pretty difficult to get the flag back (and so do the optimal create
>> path) once you lose it. :( I'd love a better way to do so, but we'll
>> have to look at what's involved in a bit of depth.
>
> No need - with that reasoning it looks more like this is part of the
> design rather than a bug. I'll just have to accept the fact that the
> system is very complicated and clients touching stuff at certain time=
s
> can make things less predictable... I just wanted to make sure I
> wasn't doing anything wrong. :)  I'll stick with the kernel client
> (it's almost twice as fast, anyways!)

Well, sort of =E2=80=94 an isolated client with their own directory is
something we definitely want to have exclusive caps, but our
heuristics aren't sophisticated enough yet.

>
>> I'm not sure why the kernel client is so much more cautious, but I
>> think there were a number of troubles with the directory listing
>> orders and things which were harder to solve there =E2=80=93 I don't=
 remember
>> if we introduced the I_DIR_ORDERED flag in it or not. Zheng can talk
>> more about that. What kernel client version are you using?
>>
>> And for a vanity data point, what kind of hardware is your MDS runni=
ng on? :)
>
> Really, really old hardware from 2006: 2 dual-core CPUs, 8GB RAM,
> connected with 1Gbit. Kernel 3.4. We actually just installed beefier
> nodes so I'll keep you posted if we get other cool results.

Awesome! That's much faster than previously, although Zheng did some
work recently to split the journaling code into a separate thread
which I guess must have made a big difference.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
