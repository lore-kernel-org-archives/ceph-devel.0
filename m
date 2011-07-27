From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: OSD questions
Date: Wed, 27 Jul 2011 09:05:19 -0700
Message-ID: <CAF3hT9DHLsmWpL0jrrC+bm=Dq4m4+ohu2u2nL_NGhAxWM1TC2A@mail.gmail.com>
References: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41753 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1G0QFT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 12:05:19 -0400
Received: by gyh3 with SMTP id 3so1141331gyh.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 09:05:19 -0700 (PDT)
In-Reply-To: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 27, 2011 at 7:39 AM, huang jun <hjwsm1989@gmail.com> wrote:
> Hello
> I have two questions about OSD.
> 1) From the current READ ops, whether the OSD can provide the
> readahead strategy? that is : the clients send MOSDOp msg =A0to read
> some objects of a file, the msg =A0includes many read ops(we can defi=
ne
> the first Op as to read the object we wan at this time, and other Ops
> is going to do readahead work), these Ops ask OSD to read some object=
s
> ahead and OSD don't =A0reply to those Ops, they only need to reply th=
e
> client when got the wanted object. So, at the next time to read the
> different objects of that file, it can got data from OSDs' cache,that
> will promote read performance. =A0All the readahead work was done
> internal OSD cluster.
Not right now -- all readahead has to be initiated by the client. Note
that in cases where readahead is useful the relative on-disk lookup
time isn't going to be that large since it's using 4MB objects.
I don't think that in general you'd gain anything by trying to manage
the OSD cache from the client anyway!

> 2) ceph use osd journal to keep perfect stability, but that decrease
> the write performance as we see, can we =A0record just metadata of th=
e
> WRITE op in journal write item, but not the whole data buffer,in that
> way we can reponse client quickly. If the OSD crashed, we can replay
> the journal, but at this time we need to request data from CLIENT,
> which increase the complexity.
Trying to request data from the client like this would not work out
well -- how would the client know when it was safe to drop the data
out of memory? What happens if the OSD sends back a success message,
then crashes, and the client shuts down or crashes too?
The doubled writes can be annoying, but it's really the only safe
thing to do. Perhaps we could do something with btrfs and snapshots to
avoid using a journal, but I'd have to look into it some more.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
