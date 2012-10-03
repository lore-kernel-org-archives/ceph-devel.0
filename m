From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds cache size configuration option being ignored
Date: Wed, 3 Oct 2012 16:56:25 -0700
Message-ID: <CAPYLRziwU3jHVAsv780bhQ0+Bz2oXNv0FipSPaTr_apz5WxyMA@mail.gmail.com>
References: <CANLRBox7q8eJkJ8rKoyqrjdPLq7kjjqiMJx9MAdaSgCTtcmnog@mail.gmail.com>
	<CAPYLRzjhdsEqqfOV=pP2rZnegZRsjfaFr4LGFJooDkXqrA71Aw@mail.gmail.com>
	<CANLRBoxTasZcvo7s33ynoFmitk-ZZX10eYX-=k0db3bgcQOaAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58246 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788Ab2JCX4Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 19:56:25 -0400
Received: by iagy32 with SMTP id y32so1308000iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 16:56:25 -0700 (PDT)
In-Reply-To: <CANLRBoxTasZcvo7s33ynoFmitk-ZZX10eYX-=k0db3bgcQOaAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 3, 2012 at 4:23 PM, Tren Blackburn <tren@eotnetworks.com> w=
rote:
> On Wed, Oct 3, 2012 at 4:15 PM, Gregory Farnum <greg@inktank.com> wro=
te:
>> On Wed, Oct 3, 2012 at 3:22 PM, Tren Blackburn <tren@eotnetworks.com=
> wrote:
>>> Hi List;
>>>
>>> I was advised to use the "mds cache size" option to limit the memor=
y
>>> that the mds process will take. I have it set to "32768". However i=
t
>>> the ceph-mds process is now at 50GB and still growing.
>>>
>>> fern ceph # ps wwaux | grep ceph-mds
>>> root       895  4.3 26.6 53269304 52725820 ?   Ssl  Sep28 312:29
>>> /usr/bin/ceph-mds -i fern --pid-file /var/run/ceph/mds.fern.pid -c
>>> /etc/ceph/ceph.conf
>>>
>>> Have I specified the limit incorrectly? How far will it go?
>>
>> Oof. That looks correct; it sounds like we have a leak or some other
>> kind of bug. I believe you're on Gentoo; did you build with tcmalloc=
?
>> If so, can you run "ceph -w" in one window and then "ceph mds tell 0
>> heap stats" and send back the output?
>> If you didn't build with tcmalloc, can you do so and try again? We
>> have noticed fragmentation issues with the default memory allocator,
>> which is why we switched (though I can't imagine it'd balloon that f=
ar
>> =97 but tcmalloc will give us some better options to diagnose it). S=
orry
>> I didn't mention this before!
>
> Hey Greg! Good recall, I am on Gentoo, and I did build with tcmalloc.

Search is a wonderful thing. ;)

> Here is the information you requested:
>
> 2012-10-03 16:20:43.979673 mds.0 [INF] mds.ferntcmalloc heap
> stats:------------------------------------------------
> 2012-10-03 16:20:43.979676 mds.0 [INF] MALLOC:    53796808560 (51304.=
6
> MiB) Bytes in use by application
> 2012-10-03 16:20:43.979679 mds.0 [INF] MALLOC: +       753664 (    0.=
7
> MiB) Bytes in page heap freelist
> 2012-10-03 16:20:43.979681 mds.0 [INF] MALLOC: +     93299048 (   89.=
0
> MiB) Bytes in central cache freelist
> 2012-10-03 16:20:43.979683 mds.0 [INF] MALLOC: +      6110720 (    5.=
8
> MiB) Bytes in transfer cache freelist
> 2012-10-03 16:20:43.979685 mds.0 [INF] MALLOC: +     84547880 (   80.=
6
> MiB) Bytes in thread cache freelists
> 2012-10-03 16:20:43.979686 mds.0 [INF] MALLOC: +     84606976 (   80.=
7
> MiB) Bytes in malloc metadata
> 2012-10-03 16:20:43.979688 mds.0 [INF] MALLOC:   ------------
> 2012-10-03 16:20:43.979690 mds.0 [INF] MALLOC: =3D  54066126848 (5156=
1.5
> MiB) Actual memory used (physical + swap)
> 2012-10-03 16:20:43.979691 mds.0 [INF] MALLOC: +            0 (    0.=
0
> MiB) Bytes released to OS (aka unmapped)
> 2012-10-03 16:20:43.979693 mds.0 [INF] MALLOC:   ------------
> 2012-10-03 16:20:43.979694 mds.0 [INF] MALLOC: =3D  54066126848 (5156=
1.5
> MiB) Virtual address space used
> 2012-10-03 16:20:43.979700 mds.0 [INF] MALLOC:
> 2012-10-03 16:20:43.979702 mds.0 [INF] MALLOC:         609757
>     Spans in use
> 2012-10-03 16:20:43.979703 mds.0 [INF] MALLOC:            395
>     Thread heaps in use
> 2012-10-03 16:20:43.979705 mds.0 [INF] MALLOC:           8192
>     Tcmalloc page size
> 2012-10-03 16:20:43.979710 mds.0 [INF]

So tcmalloc thinks the MDS is actually using >50GB of RAM. ie, we have =
a leak.

Sage suggests we check out the perfcounters (specifically, how many
log segments are open). "ceph --admin-daemon </path/to/socket>
perfcounters_dump" I believe the default path is
/var/run/ceph/ceph-mds.a.asok.

If this doesn't provide us a clue, I'm afraid we're going to have to
start keeping track of heap usage with tcmalloc or run the daemon
through massif...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
