From: Gregory Farnum <greg@inktank.com>
Subject: Re: CEPH - messenger rebind race
Date: Wed, 7 May 2014 18:57:31 -0700
Message-ID: <CAPYLRzgZ7ssZHJkV-FMbgmsiq8K2QGmqGzv-vySOXggBdx3-uA@mail.gmail.com>
References: <1399452455.72957.YahooMailNeo@web140901.mail.bf1.yahoo.com>
	<alpine.DEB.2.00.1405071725210.24873@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:56226 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaEHB5c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 21:57:32 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so2016405qgd.41
        for <ceph-devel@vger.kernel.org>; Wed, 07 May 2014 18:57:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1405071725210.24873@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Guang Yang <yguang11@yahoo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 7, 2014 at 5:52 PM, Sage Weil <sage@inktank.com> wrote:
> [CCing Greg and ceph-devel]
>
> On Wed, 7 May 2014, Guang Yang wrote:
>> Hi Sage,
>> Sorry to bother you directly, I am debugging / fixing issue
>> http://tracker.ceph.com/issues/8232, during which time I studied the
>> messenger component of CEPH. With more understanding of the messenge=
r
>> component, I started getting confused by the fix of issue 6992
>> (http://tracker.ceph.com/issues/6992) in terms of how it could help =
to solve
>> the problem (though I fully agree we should stop accepter first and =
then
>> clear all PIPEs).
>>
>> Looking at the logs posted along with the issue 6992, the failure ha=
ppened
>> at pipe::writter::connect side (it should be a brand new connect ins=
tead of
>> a re-connect as cs =3D 0, pgs =3D 0) after a rebind, and the failed =
one already
>> has the updated local address, it is confused to me how the connecti=
on could
>> be established? As there is connect_seq check at the remote side whi=
ch is
>> likely to fail for this connection attempt (which is a positive valu=
e),
>> unless there is some race at remote side updating connet_seq and in_=
seq.
>>
>> Am I missing something obviously on this?
>
> Honestly I haven't looked closely at that old log; I would focus on t=
he
> new log.

Likewise, I didn't compare the patch to the bug. The patch was
definitely fixing a race with incoming connections, but it's possible
it's mismatched with the backtrace or something.

>
> Looking at it now (for the first time, sorry), the last line is
>
>     -2> 2014-05-04 06:16:07.957897 7f71063ee700  2 --
> 10.193.207.180:6884/1037605 >> 10.193.207.183:6958/5001307 pipe(0x1cf=
a1400
> sd=3D132 :60749 s=3D1 pgs=3D0 cs=3D0 l=3D0 c=3D0x12b4e160). got newly=
_acked_seq 10 vs
> out_seq 0
>
> If I'm reading it right, that's an outgoing connection with the same
> source as the mark_down_all.  If it existed before the mark_down_all,
> something is really broken because mark_dwon_all should have set it t=
o
> STATE_CLOSED and the connect() function checks the state.  Which make=
s me
> think that it was initiated after.

*smacks forehead*
=46or some reason I've been thinking it was a broken incoming connectio=
n
rather than an outgoing one. But of course it's not, so...

> My guess is that this is a race in OSD.cc.  We do the rebind() stuff,=
 but
> only a bit further down do consume_map() which publishes the map to t=
he
> OSDService with all kind of complicated handoff.  I'm forgetting righ=
t now
> how this is supposed to work, but my guess is that this is the heart =
of
> the problem: some random PG thread is trying to send to an OSD using =
the
> older map and grabs the older OSDMap ref and opens the connection
> *after* we do the rebind() and mark_down_all().
>
> Does this sound plausible?

Well, I don't think it's supposed to happen =E2=80=94 we hold a write o=
n the
map_lock during this time period and update the OSDSuperblock epochs
before dropping it (and then doing consume_map()). But it's not
pre-publishing and it might not even be that complicated a race, but
just something wrong in the main thread. Sadly the msgr_crash.log file
we have right now doesn't have enough info for me to identify the
issue and code inspection doesn't sound like any fun, so a good log
still sounds like the best way to identify the issue.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
