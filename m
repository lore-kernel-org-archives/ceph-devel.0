From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Wed, 18 Jan 2012 01:19:34 +0400
Message-ID: <CAADCt4+iFA4=1Cr5=HYhcAa9CJvavGjpvbbXy_CjDyUUDjvh2Q@mail.gmail.com>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
 <CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com>
 <Pine.LNX.4.64.1201170843220.15646@cobra.newdream.net> <CAADCt4+zUWEALy3RnX-k33bgWV81R9vXfBuikm7D20w2hLosiQ@mail.gmail.com>
 <CAF3hT9B7FK6eGZFMkajd2snMkkCSRVtp9Oznu4KmzJ=oa45prQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61643 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab2AQVT4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 16:19:56 -0500
Received: by wibhm6 with SMTP id hm6so1742138wib.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 13:19:55 -0800 (PST)
In-Reply-To: <CAF3hT9B7FK6eGZFMkajd2snMkkCSRVtp9Oznu4KmzJ=oa45prQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

2012/1/17 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Tue, Jan 17, 2012 at 11:37 AM, Andrey Stepachev <octo47@gmail.com>=
 wrote:
>> 2012/1/17 Sage Weil <sage@newdream.net>:
>>> On Mon, 16 Jan 2012, Andrey Stepachev wrote:
>>>> Ops. It is really a buffer problem.
>>>> It can be checked with easy with ceph osd tell 4 bench
>>>>
>>>> bench: wrote 1024 MB in blocks of 15625 KB in 17.115538 sec at 612=
64 KB/sec
>>>> bench: wrote 1024 MB in blocks of 122 MB in 12.281531 sec at 85378=
 KB/sec
>>>> bench: wrote 1024 MB in blocks of 244 MB in 13.529501 sec at 77502=
 KB/sec
>>>> bench: wrote 3814 MB in blocks of 488 MB in 30.909198 sec at 123 M=
B/sec
>>>>
>>>> and in last case dstat show 'iozone-like iops'
>>>>
>>>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 0 =C2=A094 =C2=A0 6 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 538M| =C2=A0 0 =C2=A0 238
>>>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 0 =C2=A096 =C2=A0 3 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 525M| =C2=A0 0 =C2=A0 133
>>>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 2 =C2=A095 =C2=A0 3 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 497M| =C2=A0 0 =C2=A0 128
>>>> 18.0:39.0:30.0:27.0| =C2=A00 =C2=A0 3 =C2=A096 =C2=A0 2 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 144M| =C2=A0 0 =C2=A040.0
>>>> 75.0:74.0:72.0:67.0| =C2=A00 =C2=A0 3 =C2=A095 =C2=A0 2 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 103M| =C2=A0 0 =C2=A02698
>>>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A013 =C2=A083 =C2=A0 4 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 484M| =C2=A0 0 =C2=A0 125
>>>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 0 100 =C2=A0 0 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 486M| =C2=A0 0 =C2=A0 124
>>>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 3 =C2=A088 =C2=A0 9 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 476M| =C2=A0 0 =C2=A0 123
>>>>
>>>> Now question arises: how ceph can be tuned to gain such
>>>> performance in normal operations, not in bench?
>>>
>>> This may be related to how your OSD journaling is configured. =C2=A0=
I'm
>>> guessing it's set to a file inside the btrfs volume holding the dat=
a?
>>
>> Yes. After some investigation I found, that it is more related to
>> fact, that FileStore process incoming data in transactions.
>> So we have many relatively small transactions (~1-4Mb).
>> As opposite, in hadoop we have no transactions, we have
>> simple stream of packets, wich a written to a file.
> Ceph has a lot of design goals which mean it's not aimed quite as
> squarely at MapReduce as HDFS is, thus these sorts of differences.

May be in the future it will be possible to make separate operation
like STREAM especially for hadoop-like workload.
But I can't propose some  idea right now how to implement
such solution (in case of existing transactional system).

>
> Can you make sure that your RADOS objects are 64MB in size? They
> should be set to that, but it's possible something in the path got
> broken. Otherwise we may need to set up configuration options for the
> size of things to send over the wire... :/

show_layout shows expected layout.
If I disable buffering in java, and rely only on ceph (and send
by 10MB), I've got such logs:
000~10000000 =3D 10000000
2012-01-17 14:35:41.990987 7f4a6306c700 filestore(/data/osd.1) write
0.17b_head/10000003c90.00000000/head/2c91397b 20000000~10000000
2012-01-17 14:35:41.997599 7f4a6306c700 filestore(/data/osd.1)
queue_flusher ep 5 fd 40 20000000~10000000 qlen 1
2012-01-17 14:35:41.997642 7f4a6306c700 filestore(/data/osd.1) write
0.17b_head/10000003c90.00000000/head/2c91397b 20000000~10000000 =3D
10000000
2012-01-17 14:35:42.192107 7f4a6286b700 filestore(/data/osd.1) write
0.17b_head/10000003c90.00000000/head/2c91397b 30000000~10000000
2012-01-17 14:35:42.197386 7f4a6286b700 filestore(/data/osd.1)
queue_flusher ep 5 fd 39 30000000~10000000 qlen 1
2012-01-17 14:35:42.197415 7f4a6286b700 filestore(/data/osd.1) write
0.17b_head/10000003c90.00000000/head/2c91397b 30000000~10000000 =3D
10000000
2012-01-17 14:35:42.603251 7f4a6306c700 filestore(/data/osd.1) write
0.17b_head/10000003c90.00000000/head/2c91397b 40000000~10000000

Also, it is easy to see, that buffers comes with very close timestamps,
but queued as separate ops. FileStore issues one write for such op.
(in some cases one do_transactions process 2-3 op for one object).
This looks like we can optimize this by collocating op by object.
But lack of knowlege of internals of the ceph don't allow me
to implement such prototype right now.

I could not find how I can influence the ceph to
merge incoming packets in one op.

>
>
>> To achieve good performance we can:
>> a) of course move journal away (but I can't test such
>> configuration, by hardware is limited to one big raid).
>> b) think about possibility of collocation transaction
>> for the same object into one bigger transaction.
>> Even if we move journal away we'll still write data
>> in small pieces (as test shows instead of 10-100s megabytes
>> will write 1-4mb per request).
> Yeah; Ceph likes 4MB writes; that's its default for many many things.
> I'm surprised this is causing trouble for your RAID controller though=
!
> Could you maybe set it up in a different mode and save one disk for j=
ournaling?

I've moved journal to tmpfs (I have plenty of RAM), and no significant
changes.Still high iops, limiting overall throughtput.
96.0:96.0:96.0:96.0|   0   140M|   0  3075
90.0:93.0:91.0:87.0|   0   287M|   0  1434
66.0:74.0:92.0:87.0|4096B  215M|1.00  1861
51.0:53.0:77.0:73.0|   0   194M|   0  2302
41.0:40.0:40.0:41.0|   0   206M|   0  2262
95.0:92.0:94.0:94.0|   0   129M|   0  3581

>
>> I can completely wrong, but what I see in the code, and in
>> logs suggests to me that I'm right.
>
>> (BTW, do you missed my hadoop related patches,
>> or something wrong with them?)
> Sorry for the delay; we had a long weekend and I didn't get to them
> last week. I'm building them right now and will push once I've
> finished (after lunch probably, we've got a thing). :)
Bon app=C3=A9tit! :)

> -Greg



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
