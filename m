From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Mon, 4 Mar 2013 18:42:47 +0100
Message-ID: <CAMwB3TjQqYqhmSouFEgaiGwby=_mpk3hOGcrcx=9ho_+h1NdMg@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
	<CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
	<CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
	<alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
	<CAMwB3TjfkX8LJpBiicrcdf3UqZpYApBoEShebceee6KgY+C3kw@mail.gmail.com>
	<CAPYLRzhMBBsgDHSwn84EimJJUb7uGtRx8-ef933Kayhv1UMsvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48231 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab3CDRms convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 12:42:48 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so6529815ieb.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 09:42:48 -0800 (PST)
In-Reply-To: <CAPYLRzhMBBsgDHSwn84EimJJUb7uGtRx8-ef933Kayhv1UMsvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Alone (one of this slow osd in mentioned tripple)

2013-03-04 18:39:27.683035 osd.23 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 15.241943 sec at 68795 KB/sec

in for loop (some slow request appear):

for x in `seq 0 25`; do ceph osd tell $x bench;done
2013-03-04 18:41:08.259454 osd.12 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.658448 sec at 27844 KB/sec
2013-03-04 18:41:07.850213 osd.5 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.402402 sec at 28034 KB/sec
2013-03-04 18:41:07.850231 osd.11 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.201831 sec at 28186 KB/sec
2013-03-04 18:41:08.100186 osd.10 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.540605 sec at 27931 KB/sec
2013-03-04 18:41:08.319766 osd.21 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.532806 sec at 27937 KB/sec
2013-03-04 18:41:08.415835 osd.14 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.772730 sec at 27760 KB/sec
2013-03-04 18:41:08.775264 osd.9 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.195523 sec at 27452 KB/sec
2013-03-04 18:41:08.808824 osd.6 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.338387 sec at 27350 KB/sec
2013-03-04 18:41:08.923809 osd.19 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.177933 sec at 27465 KB/sec
2013-03-04 18:41:08.925848 osd.18 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.201476 sec at 27448 KB/sec
2013-03-04 18:41:08.936961 osd.15 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.273058 sec at 27397 KB/sec
2013-03-04 18:41:08.619022 osd.20 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.713017 sec at 27804 KB/sec
2013-03-04 18:41:08.764705 osd.22 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.954886 sec at 27626 KB/sec
2013-03-04 18:41:08.499156 osd.0 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.035553 sec at 27568 KB/sec
2013-03-04 18:41:07.873457 osd.2 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.489969 sec at 27969 KB/sec
2013-03-04 18:41:08.134530 osd.13 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.513056 sec at 27952 KB/sec
2013-03-04 18:41:08.219142 osd.1 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.856368 sec at 27698 KB/sec
2013-03-04 18:41:08.485806 osd.4 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.060621 sec at 27550 KB/sec
2013-03-04 18:41:08.612236 osd.7 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.122105 sec at 27505 KB/sec
2013-03-04 18:41:08.647494 osd.8 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.134885 sec at 27496 KB/sec
2013-03-04 18:41:08.649267 osd.3 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.961966 sec at 27621 KB/sec
2013-03-04 18:41:08.943610 osd.24 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.091272 sec at 27527 KB/sec
2013-03-04 18:41:08.975838 osd.17 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.270884 sec at 27398 KB/sec
2013-03-04 18:41:09.544561 osd.23 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.715030 sec at 27084 KB/sec
2013-03-04 18:41:08.969981 osd.16 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 38.287596 sec at 27386 KB/sec
2013-03-04 18:41:09.533789 osd.25 [INF] bench: wrote 1024 MB in blocks
of 4096 KB in 37.954333 sec at 27627 KB/sec

I have a little fragmented xfs, but performance is still good.

On Mon, Mar 4, 2013 at 6:25 PM, Gregory Farnum <greg@inktank.com> wrote=
:
> On Mon, Mar 4, 2013 at 9:23 AM, S=C5=82awomir Skowron <szibis@gmail.c=
om> wrote:
>> On Mon, Mar 4, 2013 at 6:02 PM, Sage Weil <sage@inktank.com> wrote:
>>> On Mon, 4 Mar 2013, S?awomir Skowron wrote:
>>>> Ok, thanks for response. But if i have crush map like this in atta=
chment.
>>>>
>>>> All data should be balanced equal, not including hosts with 0.5 we=
ight.
>>>>
>>>> How make data auto balanced ?? when i know that some pq's have too
>>>> much data ?? I have 4800 pg's on RGW only with 78 OSD, it is quite
>>>> enough.
>>>>
>>>> pool 3 '.rgw.buckets' rep size 3 crush_ruleset 0 object_hash rjenk=
ins
>>>> pg_num 4800 pgp_num 4800 last_change 908 owner 0
>>>>
>>>> When will bee possible to expand number of pg's ??
>>>
>>> Soon.  :)
>>>
>>> The bigger question for me is why there is one PG that is getting p=
ounded
>>> while the others are not.  Is there a large skew in the workload to=
ward a
>>> small number of very hot objects?
>>
>> Yes, there are constantly about 100-200 operations in second, all
>> going into RGW backend. But when problems comes, there are more
>> requests, more GET, and PUT, because of reconnect of applications,
>> with short timeouts. But statistically all new PUTs normally goes fo=
r
>> many pg's, this should not overload a single master OSD. Maybe
>> balanced Reads from all replicas could help a little ??.
>>
>>>  I expect it should be obvious if you go
>>> to the loaded osd and do
>>>
>>>  ceph --admin-daemon /var/run/ceph/ceph-osd.NN.asok dump_ops_in_fli=
ght
>>>
>>
>> Yes i did that, but only when cluster going unstable there are such
>> long operations. Normaly there are no ops in queue, only when cluste=
r
>> going to rebalance, remap, or anything else.
>
> Have you checked the baseline disk performance of the OSDs? Perhaps
> it's not that the PG is bad but that the OSDs are slow.



--
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
