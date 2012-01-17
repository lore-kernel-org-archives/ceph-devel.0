From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Slow ceph io. High iops. Compared to hadoop.
Date: Tue, 17 Jan 2012 23:37:09 +0400
Message-ID: <CAADCt4+zUWEALy3RnX-k33bgWV81R9vXfBuikm7D20w2hLosiQ@mail.gmail.com>
References: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
 <CAADCt4KQUnN9Mmc+LEmMs_ryYp1Jveega7XHt9mJdjJ6-AHg1w@mail.gmail.com> <Pine.LNX.4.64.1201170843220.15646@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48285 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab2AQThb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 14:37:31 -0500
Received: by werb14 with SMTP id b14so1406914wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 11:37:30 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201170843220.15646@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2012/1/17 Sage Weil <sage@newdream.net>:
> On Mon, 16 Jan 2012, Andrey Stepachev wrote:
>> Ops. It is really a buffer problem.
>> It can be checked with easy with ceph osd tell 4 bench
>>
>> bench: wrote 1024 MB in blocks of 15625 KB in 17.115538 sec at 61264=
 KB/sec
>> bench: wrote 1024 MB in blocks of 122 MB in 12.281531 sec at 85378 K=
B/sec
>> bench: wrote 1024 MB in blocks of 244 MB in 13.529501 sec at 77502 K=
B/sec
>> bench: wrote 3814 MB in blocks of 488 MB in 30.909198 sec at 123 MB/=
sec
>>
>> and in last case dstat show 'iozone-like iops'
>>
>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 0 =C2=A094 =C2=A0 6 =C2=A0 =
0 =C2=A0 0| =C2=A0 0 =C2=A0 538M| =C2=A0 0 =C2=A0 238
>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 0 =C2=A096 =C2=A0 3 =C2=A0 =
0 =C2=A0 0| =C2=A0 0 =C2=A0 525M| =C2=A0 0 =C2=A0 133
>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 2 =C2=A095 =C2=A0 3 =C2=A0 =
0 =C2=A0 0| =C2=A0 0 =C2=A0 497M| =C2=A0 0 =C2=A0 128
>> 18.0:39.0:30.0:27.0| =C2=A00 =C2=A0 3 =C2=A096 =C2=A0 2 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 144M| =C2=A0 0 =C2=A040.0
>> 75.0:74.0:72.0:67.0| =C2=A00 =C2=A0 3 =C2=A095 =C2=A0 2 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 103M| =C2=A0 0 =C2=A02698
>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A013 =C2=A083 =C2=A0 4 =C2=A0 =
0 =C2=A0 0| =C2=A0 0 =C2=A0 484M| =C2=A0 0 =C2=A0 125
>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 0 100 =C2=A0 0 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 486M| =C2=A0 0 =C2=A0 124
>> =C2=A0100: 100: 100: 100| =C2=A00 =C2=A0 3 =C2=A088 =C2=A0 9 =C2=A0 =
0 =C2=A0 0| =C2=A0 0 =C2=A0 476M| =C2=A0 0 =C2=A0 123
>>
>> Now question arises: how ceph can be tuned to gain such
>> performance in normal operations, not in bench?
>
> This may be related to how your OSD journaling is configured. =C2=A0I=
'm
> guessing it's set to a file inside the btrfs volume holding the data?

Yes. After some investigation I found, that it is more related to
fact, that FileStore process incoming data in transactions.
So we have many relatively small transactions (~1-4Mb).
As opposite, in hadoop we have no transactions, we have
simple stream of packets, wich a written to a file.

To achieve good performance we can:
a) of course move journal away (but I can't test such
configuration, by hardware is limited to one big raid).
b) think about possibility of collocation transaction
for the same object into one bigger transaction.
Even if we move journal away we'll still write data
in small pieces (as test shows instead of 10-100s megabytes
will write 1-4mb per request).

I can completely wrong, but what I see in the code, and in
logs suggests to me that I'm right.

(BTW, do you missed my hadoop related patches,
or something wrong with them?)

>
> sage
>
>>
>> 2012/1/16 Andrey Stepachev <octo47@gmail.com>:
>> > Hi all.
>> >
>> > Last week I've investigate the status for hadoop on ceph.
>> > I create some patches to remove some bugs and crashes.
>> > Looks like it works. Even hbase works on top.
>> >
>> > For reference all sources and patches are here
>> >
>> > https://github.com/octo47/hadoop-common/tree/branch-1.0-ceph
>> > https://github.com/octo47/ceph/tree/v0.40-hadoop
>> >
>> > After YCSB and TestDSFIO work without crashes i start investigate
>> > performance.
>> >
>> > I have 5node cluster with 4 sata disks. btrfs. 24core on each.
>> > raid. iozone shows up to 520MB/s.
>> >
>> > Performance differs in 2-3 times. After some tests i see strange t=
hing.
>> > hadoop uses disk very close to iozone: small amount and iops and h=
igh
>> > throughtput (same as iozone).
>> > ceph uses very inefficient: huge amount of iops, up to 3 times les=
s
>> > throughtput (i think because of high amount of iops).
>> >
>> > hadoop dstat output:
>> > sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total=
-
>> > util:util:util:util|usr sys idl wai hiq siq| read =C2=A0writ| read=
 =C2=A0writ
>> > =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 5 =C2=A083 =C2=A011 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 529M| =C2=A0 0 =C2=A0 247
>> > =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 0 =C2=A083 =C2=A016 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 542M| =C2=A0 0 =C2=A0 168
>> > =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 0 =C2=A081 =C2=A018 =C2=A0=
 0 =C2=A0 0| =C2=A028k =C2=A0518M|6.00 =C2=A0 149
>> > =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 4 =C2=A077 =C2=A017 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 533M| =C2=A0 0 =C2=A0 243
>> > =C2=A0100: 100: 100: 100| =C2=A01 =C2=A0 3 =C2=A083 =C2=A013 =C2=A0=
 0 =C2=A0 0| =C2=A0 0 =C2=A0 523M| =C2=A0 0 =C2=A0 264
>> >
>> > ceph dstat output:
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> > sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total=
-
>> > util:util:util:util|usr sys idl wai hiq siq| read =C2=A0writ| read=
 =C2=A0writ
>> > 68.0:70.0:79.0:76.0| =C2=A01 =C2=A0 2 =C2=A093 =C2=A0 4 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 195M| =C2=A0 0 =C2=A01723
>> > 86.0:85.0:93.0:91.0| =C2=A01 =C2=A0 2 =C2=A091 =C2=A0 5 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 226M| =C2=A0 0 =C2=A01816
>> > 85.0:85.0:85.0:84.0| =C2=A01 =C2=A0 3 =C2=A092 =C2=A0 4 =C2=A0 0 =C2=
=A0 0| =C2=A0 0 =C2=A0 235M| =C2=A0 0 =C2=A02316
>> >
>> >
>> > So, my question is: can someone point me:
>> > a) can it be because of inefficient buffer size on osd part
>> > (i tried to increase CephOutputStream buffer to 256kb, not helps)
>> > b) what other problems can be and what options can i tune
>> > to find out what is going on.
>> >
>> > PS: i can't use iozone on kernel mounted fs. something
>> > hang in kernel, only reboot helps.
>> > in /var/log/messages i see attached kern.log.
>> >
>> >
>> >
>> > --
>> > Andrey.
>>
>>
>>
>> --
>> Andrey.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
