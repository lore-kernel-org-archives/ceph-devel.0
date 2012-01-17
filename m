From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Tue, 17 Jan 2012 11:54:02 -0800
Message-ID: <CAF3hT9B7FK6eGZFMkajd2snMkkCSRVtp9Oznu4KmzJ=oa45prQ@mail.gmail.com>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
	<CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com>
	<Pine.LNX.4.64.1201170843220.15646@cobra.newdream.net>
	<CAADCt4+zUWEALy3RnX-k33bgWV81R9vXfBuikm7D20w2hLosiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44246 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2AQTyE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 14:54:04 -0500
Received: by iagf6 with SMTP id f6so4716024iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 11:54:03 -0800 (PST)
In-Reply-To: <CAADCt4+zUWEALy3RnX-k33bgWV81R9vXfBuikm7D20w2hLosiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Jan 17, 2012 at 11:37 AM, Andrey Stepachev <octo47@gmail.com> w=
rote:
> 2012/1/17 Sage Weil <sage@newdream.net>:
>> On Mon, 16 Jan 2012, Andrey Stepachev wrote:
>>> Ops. It is really a buffer problem.
>>> It can be checked with easy with ceph osd tell 4 bench
>>>
>>> bench: wrote 1024 MB in blocks of 15625 KB in 17.115538 sec at 6126=
4 KB/sec
>>> bench: wrote 1024 MB in blocks of 122 MB in 12.281531 sec at 85378 =
KB/sec
>>> bench: wrote 1024 MB in blocks of 244 MB in 13.529501 sec at 77502 =
KB/sec
>>> bench: wrote 3814 MB in blocks of 488 MB in 30.909198 sec at 123 MB=
/sec
>>>
>>> and in last case dstat show 'iozone-like iops'
>>>
>>> =A0100: 100: 100: 100| =A00 =A0 0 =A094 =A0 6 =A0 0 =A0 0| =A0 0 =A0=
 538M| =A0 0 =A0 238
>>> =A0100: 100: 100: 100| =A00 =A0 0 =A096 =A0 3 =A0 0 =A0 0| =A0 0 =A0=
 525M| =A0 0 =A0 133
>>> =A0100: 100: 100: 100| =A00 =A0 2 =A095 =A0 3 =A0 0 =A0 0| =A0 0 =A0=
 497M| =A0 0 =A0 128
>>> 18.0:39.0:30.0:27.0| =A00 =A0 3 =A096 =A0 2 =A0 0 =A0 0| =A0 0 =A0 =
144M| =A0 0 =A040.0
>>> 75.0:74.0:72.0:67.0| =A00 =A0 3 =A095 =A0 2 =A0 0 =A0 0| =A0 0 =A0 =
103M| =A0 0 =A02698
>>> =A0100: 100: 100: 100| =A00 =A013 =A083 =A0 4 =A0 0 =A0 0| =A0 0 =A0=
 484M| =A0 0 =A0 125
>>> =A0100: 100: 100: 100| =A00 =A0 0 100 =A0 0 =A0 0 =A0 0| =A0 0 =A0 =
486M| =A0 0 =A0 124
>>> =A0100: 100: 100: 100| =A00 =A0 3 =A088 =A0 9 =A0 0 =A0 0| =A0 0 =A0=
 476M| =A0 0 =A0 123
>>>
>>> Now question arises: how ceph can be tuned to gain such
>>> performance in normal operations, not in bench?
>>
>> This may be related to how your OSD journaling is configured. =A0I'm
>> guessing it's set to a file inside the btrfs volume holding the data=
?
>
> Yes. After some investigation I found, that it is more related to
> fact, that FileStore process incoming data in transactions.
> So we have many relatively small transactions (~1-4Mb).
> As opposite, in hadoop we have no transactions, we have
> simple stream of packets, wich a written to a file.
Ceph has a lot of design goals which mean it's not aimed quite as
squarely at MapReduce as HDFS is, thus these sorts of differences.

Can you make sure that your RADOS objects are 64MB in size? They
should be set to that, but it's possible something in the path got
broken. Otherwise we may need to set up configuration options for the
size of things to send over the wire... :/


> To achieve good performance we can:
> a) of course move journal away (but I can't test such
> configuration, by hardware is limited to one big raid).
> b) think about possibility of collocation transaction
> for the same object into one bigger transaction.
> Even if we move journal away we'll still write data
> in small pieces (as test shows instead of 10-100s megabytes
> will write 1-4mb per request).
Yeah; Ceph likes 4MB writes; that's its default for many many things.
I'm surprised this is causing trouble for your RAID controller though!
Could you maybe set it up in a different mode and save one disk for jou=
rnaling?

> I can completely wrong, but what I see in the code, and in
> logs suggests to me that I'm right.

> (BTW, do you missed my hadoop related patches,
> or something wrong with them?)
Sorry for the delay; we had a long weekend and I didn't get to them
last week. I'm building them right now and will push once I've
finished (after lunch probably, we've got a thing). :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
