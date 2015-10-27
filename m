From: Samuel Just <sjust@redhat.com>
Subject: Re: PG: all requests stuck when acting set < min_size
Date: Tue, 27 Oct 2015 14:05:42 -0700
Message-ID: <CAN=+7FWZ_fm=UjkfmabMsmULLMTSFUqoQvnDCtp5UhYuW1YYDA@mail.gmail.com>
References: <BLU175-W31BC44F9AFEBFB5588D05CDF220@phx.gbl>
	<CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38841 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965521AbbJ0VFn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 17:05:43 -0400
Received: by igbdj2 with SMTP id dj2so88352570igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2015 14:05:42 -0700 (PDT)
In-Reply-To: <CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: GuangYang <yguang11@outlook.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Actually, we really can't accept reads below min_size and still keep
the properties we want it to have.  Suppose we have 3 osds (a, b, and
c) which see writes 0...1000.  min_size is 2.  If a and b are then
powered off only having committed up to 900 (therefore the client
could only have seen up to 900 commit), then c would be able to serve
reads based on updates up to 1000 with a and b stopped (no way to know
a and b only committed to 900).  If c then stops and a and b are
restarted, they would begin serving reads and writes only based on
commits up to 900 even though we would have exposed the writes up to
1000 to the client.
-Sam

On Tue, Oct 27, 2015 at 12:47 PM, Gregory Farnum <gfarnum@redhat.com> w=
rote:
> On Tue, Oct 27, 2015 at 11:47 AM, GuangYang <yguang11@outlook.com> wr=
ote:
>> Hi there,
>> Is there any reason we stuck read only requests as well for a PG whe=
n the acting set size is less than min_size?
>
> A few.
> The most important reason: PGs don't have any concept of a read-only
> mode in the code. They are "active" or not, and an active PG handles
> writes. (The full flags and other things which block writes but allow
> reads are at the OSD level, not the PG level, and are handled when op=
s
> come in before they reach the PG.) Allowing read requests against a P=
G
> to complete even when we aren't taking writes on a per-PG level would
> take some doing.
> Also: it would be weird from several different levels. We'd need to
> keep track of client streams because we wouldn't want to let through =
a
> read that is ordered after a write. How would we handle the memory
> pressure implied by that? While I can imagine it being useful for som=
e
> stuff like RGW reads, in general making data available for read but
> not write is a pretty complicated thing to explain to users =E2=80=94=
 how do
> we expose that in a useful way?
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
