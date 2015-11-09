From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph encoding optimization
Date: Mon, 9 Nov 2015 07:05:59 -0800
Message-ID: <CAJ4mKGbGSz_G-A=uEDSxSZrREWYu2CnoHMCjVS8tDW_Yd3HKXg@mail.gmail.com>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
	<CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
	<CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com>
	<34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
	<CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com>
	<CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com>
	<alpine.DEB.2.00.1511080627300.27153@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37607 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbKIPGB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 10:06:01 -0500
Received: by wmww144 with SMTP id w144so36198148wmw.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 07:05:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511080627300.27153@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Dan Mick <dmick@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>, =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 4, 2015 at 7:07 AM, Gregory Farnum <gfarnum@redhat.com> wro=
te:
> The problem with this approach is that the encoded versions need to b=
e
> platform-independent =E2=80=94 they are shared over the wire and writ=
ten to
> disks that might get transplanted to different machines. Apart from
> padding bytes, we also need to worry about endianness of the machine,
> etc. *And* we often mutate structures across versions in order to add
> new abilities, relying on the encode-decode process to deal with any
> changes to the system. How could we deal with that if just dumping th=
e
> raw memory?
>
> Now, maybe we could make these changes on some carefully-selected
> structs, I'm not sure. But we'd need a way to pick them out, guarante=
e
> that we aren't breaking interoperability concerns, etc; and it would
> need to be something we can maintain as a group going forward. I'm no=
t
> sure how to satisfy those constraints without burning a little extra
> CPU. :/
> -Greg

So it turns out we've actually had issues with this. Sage merged
(wrote?) some little-endian-only optimizations to the cephx code that
broke big-endian systems by doing a direct memcpy. Apparently our
tests don't find these issues, which makes me even more nervous about
taking that sort of optimization into the tree. :(
-Greg


On Sun, Nov 8, 2015 at 6:28 AM, Sage Weil <sage@newdream.net> wrote:
> On Sat, 7 Nov 2015, Haomai Wang wrote:
>> Hi sage,
>>
>> Could we know about your progress to refactor MSubOP and hobject_t,
>> pg_stat_t decode problem?
>>
>> We could work on this based on your work if any.
>
> See Piotr's last email on this thead... it has Josh's patch attached.
>
> sage
>
>
>>
>>
>> On Thu, Nov 5, 2015 at 1:29 AM, Haomai Wang <haomai@xsky.com> wrote:
>> > On Thu, Nov 5, 2015 at 1:19 AM, Piotr.Dalek@ts.fujitsu.com
>> > <Piotr.Dalek@ts.fujitsu.com> wrote:
>> >>> -----Original Message-----
>> >>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> >>> owner@vger.kernel.org] On Behalf Of ???
>> >>> Sent: Wednesday, November 04, 2015 4:34 PM
>> >>> To: Gregory Farnum
>> >>> Cc: ceph-devel@vger.kernel.org
>> >>> Subject: Re: ceph encoding optimization
>> >>>
>> >>> I agree with pg_stat_t (and friends) is a good first start.
>> >>> The eversion_t and utime_t are also good choice to start because=
 they are
>> >>> used at many places.
>> >>
>> >> On Ceph Hackathon, Josh Durgin made initial steps in right direct=
ion in terms of pg_stat_t encoding and decoding optimization, with the =
endianness-awareness thing left out. Even in that state, performance im=
provements offered by this change were huge enough to make it worthwhil=
e. I'm attaching the patch, but please note that this is prototype and =
based on mid-August state of code, so you might need to take that into =
account when applying the patch.
>> >
>> > Cool, it's exactly we want to see.
>> >
>> >>
>> >>
>> >> With best regards / Pozdrawiam
>> >> Piotr Da?ek
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
