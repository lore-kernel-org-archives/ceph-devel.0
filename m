From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Wed, 18 Jan 2012 16:01:14 -0800
Message-ID: <CAF3hT9A85Apebdg4aHoYusKY_aVQBKbXN_tLATu-UDLptbAdDA@mail.gmail.com>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
	<CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com>
	<Pine.LNX.4.64.1201170843220.15646@cobra.newdream.net>
	<CAADCt4+zUWEALy3RnX-k33bgWV81R9vXfBuikm7D20w2hLosiQ@mail.gmail.com>
	<CAF3hT9B7FK6eGZFMkajd2snMkkCSRVtp9Oznu4KmzJ=oa45prQ@mail.gmail.com>
	<CAADCt4+iFA4=1Cr5=HYhcAa9CJvavGjpvbbXy_CjDyUUDjvh2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64575 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab2ASABO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 19:01:14 -0500
Received: by iagf6 with SMTP id f6so6761034iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 16:01:14 -0800 (PST)
In-Reply-To: <CAADCt4+iFA4=1Cr5=HYhcAa9CJvavGjpvbbXy_CjDyUUDjvh2Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Jan 17, 2012 at 1:19 PM, Andrey Stepachev <octo47@gmail.com> wr=
ote:
> 2012/1/17 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> On Tue, Jan 17, 2012 at 11:37 AM, Andrey Stepachev <octo47@gmail.com=
> wrote:
>>> 2012/1/17 Sage Weil <sage@newdream.net>:
>>>> On Mon, 16 Jan 2012, Andrey Stepachev wrote:
>>>>> Ops. It is really a buffer problem.
>>>>> It can be checked with easy with ceph osd tell 4 bench
>>>>>
>>>>> bench: wrote 1024 MB in blocks of 15625 KB in 17.115538 sec at 61=
264 KB/sec
>>>>> bench: wrote 1024 MB in blocks of 122 MB in 12.281531 sec at 8537=
8 KB/sec
>>>>> bench: wrote 1024 MB in blocks of 244 MB in 13.529501 sec at 7750=
2 KB/sec
>>>>> bench: wrote 3814 MB in blocks of 488 MB in 30.909198 sec at 123 =
MB/sec
>>>>>
>>>>> and in last case dstat show 'iozone-like iops'
>>>>>
>>>>> =A0100: 100: 100: 100| =A00 =A0 0 =A094 =A0 6 =A0 0 =A0 0| =A0 0 =
=A0 538M| =A0 0 =A0 238
>>>>> =A0100: 100: 100: 100| =A00 =A0 0 =A096 =A0 3 =A0 0 =A0 0| =A0 0 =
=A0 525M| =A0 0 =A0 133
>>>>> =A0100: 100: 100: 100| =A00 =A0 2 =A095 =A0 3 =A0 0 =A0 0| =A0 0 =
=A0 497M| =A0 0 =A0 128
>>>>> 18.0:39.0:30.0:27.0| =A00 =A0 3 =A096 =A0 2 =A0 0 =A0 0| =A0 0 =A0=
 144M| =A0 0 =A040.0
>>>>> 75.0:74.0:72.0:67.0| =A00 =A0 3 =A095 =A0 2 =A0 0 =A0 0| =A0 0 =A0=
 103M| =A0 0 =A02698
>>>>> =A0100: 100: 100: 100| =A00 =A013 =A083 =A0 4 =A0 0 =A0 0| =A0 0 =
=A0 484M| =A0 0 =A0 125
>>>>> =A0100: 100: 100: 100| =A00 =A0 0 100 =A0 0 =A0 0 =A0 0| =A0 0 =A0=
 486M| =A0 0 =A0 124
>>>>> =A0100: 100: 100: 100| =A00 =A0 3 =A088 =A0 9 =A0 0 =A0 0| =A0 0 =
=A0 476M| =A0 0 =A0 123
>>>>>
>>>>> Now question arises: how ceph can be tuned to gain such
>>>>> performance in normal operations, not in bench?
>>>>
>>>> This may be related to how your OSD journaling is configured. =A0I=
'm
>>>> guessing it's set to a file inside the btrfs volume holding the da=
ta?
>>>
>>> Yes. After some investigation I found, that it is more related to
>>> fact, that FileStore process incoming data in transactions.
>>> So we have many relatively small transactions (~1-4Mb).
>>> As opposite, in hadoop we have no transactions, we have
>>> simple stream of packets, wich a written to a file.
>> Ceph has a lot of design goals which mean it's not aimed quite as
>> squarely at MapReduce as HDFS is, thus these sorts of differences.
>
> May be in the future it will be possible to make separate operation
> like STREAM especially for hadoop-like workload.
> But I can't propose some =A0idea right now how to implement
> such solution (in case of existing transactional system).
>
>>
>> Can you make sure that your RADOS objects are 64MB in size? They
>> should be set to that, but it's possible something in the path got
>> broken. Otherwise we may need to set up configuration options for th=
e
>> size of things to send over the wire... :/
>
> show_layout shows expected layout.
> If I disable buffering in java, and rely only on ceph (and send
> by 10MB), I've got such logs:
> 000~10000000 =3D 10000000
> 2012-01-17 14:35:41.990987 7f4a6306c700 filestore(/data/osd.1) write
> 0.17b_head/10000003c90.00000000/head/2c91397b 20000000~10000000
> 2012-01-17 14:35:41.997599 7f4a6306c700 filestore(/data/osd.1)
> queue_flusher ep 5 fd 40 20000000~10000000 qlen 1
> 2012-01-17 14:35:41.997642 7f4a6306c700 filestore(/data/osd.1) write
> 0.17b_head/10000003c90.00000000/head/2c91397b 20000000~10000000 =3D
> 10000000
> 2012-01-17 14:35:42.192107 7f4a6286b700 filestore(/data/osd.1) write
> 0.17b_head/10000003c90.00000000/head/2c91397b 30000000~10000000
> 2012-01-17 14:35:42.197386 7f4a6286b700 filestore(/data/osd.1)
> queue_flusher ep 5 fd 39 30000000~10000000 qlen 1
> 2012-01-17 14:35:42.197415 7f4a6286b700 filestore(/data/osd.1) write
> 0.17b_head/10000003c90.00000000/head/2c91397b 30000000~10000000 =3D
> 10000000
> 2012-01-17 14:35:42.603251 7f4a6306c700 filestore(/data/osd.1) write
> 0.17b_head/10000003c90.00000000/head/2c91397b 40000000~10000000
>
> Also, it is easy to see, that buffers comes with very close timestamp=
s,
> but queued as separate ops. FileStore issues one write for such op.
> (in some cases one do_transactions process 2-3 op for one object).
> This looks like we can optimize this by collocating op by object.
> But lack of knowlege of internals of the ceph don't allow me
> to implement such prototype right now.
>
> I could not find how I can influence the ceph to
> merge incoming packets in one op.

Merging ops like that in Ceph will be difficult (with its consistency
semantics), though probably not impossible. But I think it's a big
hammer for this particular problem, at least before we've tried some
other things. :)

=46or instance, there are a number of config options you can try tuning=
=2E
journal_max_write_bytes: controls how much data will get sent into the
OSD journal in a single op. It defaults to 10<<20 (slightly <10MB);
you might try turning it up.
client_oc_target_dirty: if the amount of dirty data on the client is
larger than this, it will try and send some pages out pretty much
right away. It defaults to 1024*1024*8 (ie, 8MB). This is one that I'd
really recommend you try turning up =97=A0also, the associated
client_oc_max_dirty, which defaults to 1024*1024*100.

You can pass these in either as command-line arguments
(--journal_max_write_bytes =3D n) or put them in the config files
("journal max write bytes =3D n"). Try changing them to a few different
values and see if that makes things better? :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
