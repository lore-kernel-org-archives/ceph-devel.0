From: chen kael <chenji.bupt@gmail.com>
Subject: Re: Re: BlueStore deep-dive over bluejeans
Date: Tue, 12 Apr 2016 16:33:44 +0800
Message-ID: <CAA-rZjb-m=nwVVfNwxbJcj6Spr5JQnJ+xhx5_EGVrYX4F2Wo3A@mail.gmail.com>
References: <alpine.DEB.2.11.1602241447430.7555@cpach.fuggernut.com>
	<alpine.DEB.2.11.1602291600100.1904@cpach.fuggernut.com>
	<alpine.DEB.2.11.1603011014570.1904@cpach.fuggernut.com>
	<alpine.DEB.2.11.1603020834020.1904@cpach.fuggernut.com>
	<alpine.DEB.2.11.1603020854510.1904@cpach.fuggernut.com>
	<56D7B8DB.5060203@redhat.com>
	<alpine.DEB.2.11.1603030819500.1904@cpach.fuggernut.com>
	<CABAwU-ZMQcB=9QuRjRwqdLiPDhFk68b8vXzSEwJ1UvYO=pDK-Q@mail.gmail.com>
	<20160306184642014525100@chinanetcenter.com>
	<alpine.DEB.2.11.1603061132030.25897@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38053 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbcDLIdq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 04:33:46 -0400
Received: by mail-wm0-f51.google.com with SMTP id u206so17706708wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 01:33:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603061132030.25897@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?B?6ZmI6Z2Z?= <chj@chinanetcenter.com>, huang jun <hjwsm1989@gmail.com>, Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,sage
I have a question, does small files smaller than min_alloc_size will
be store in RocksDB for ever? And  I am not quite clear about the
differences between overlay write which is set off by default and WAL
write.

2016-03-07 0:34 GMT+08:00 Sage Weil <sage@newdream.net>:
> Hi,
>
> On Sun, 6 Mar 2016, =E9=99=88=E9=9D=99 wrote:
>> Hi Sage,
>>
>> So BlueStore will rely on RocksDB a lot, which just remind me of som=
e
>> experience regarding to LevelDB recovery and compaction some time ag=
o.
>>
>> We tried Ceph RGW 0.80, which had no Bucket Index Sharding feature. =
SSD
>> managed by FileStore is used for Bucket Index Pool.
>> After we put tens of millions of files into a bucket, LevelDB of the=
 OSD
>> holding the corresponding bucket index object grew very big.
>> The OSD once crashed unexpectly. When we try to start the OSD again,=
 it took
>> hours to fully get up.
>> We used pstack to observed what it was doing and noticed the OSD is =
busy in
>> recovering and compacting its LevelDB.
>> The recovering and compaction consumed a lot CPU and memory as well.
>>
>> BlueStore seems to rely more on RocksDB, which is a variant of Level=
DB.
>> Then when the number of objects in BlueStore is large, will it take =
even
>> more time for the OSD to start up (for recoverying and compaction) i=
f it was
>> not shut down cleanly previously?
>
> In general, rocksdb/leveldb shouldn't need to compact on startup.  I'=
m not
> sure what caused that in your situation.  We've seen a few leveldb bu=
gs in
> the past that prevented compaction from happening when it should; per=
haps
> it was one of those.
>
> We did do some testing with rocksdb where we inflated the size to he =
db to
> be very large and it performed pretty well.  We didn't try clearing l=
arge
> swaths of the keyspace to test the compaction side of things, though.
>
> sage
>
>>
>>
>> Thanks,
>> Jeegn
>>
>>       From: huang jun
>> Date: 2016-03-05 18:41
>> To: Sage Weil
>> CC: Dan Mick; ceph-devel
>> Subject: Re: BlueStore deep-dive over bluejeans
>> where to get the ppt in the video?
>>
>> 2016-03-03 21:19 GMT+08:00 Sage Weil <sage@newdream.net>:
>> > On Wed, 2 Mar 2016, Dan Mick wrote:
>> >>
>> >> >     https://bluejeans.com/s/9dck/
>> >>
>> >> Can you set this to allow download?  I can't get it to play in th=
e
>> >> bluejeans interface, but downloadable files usually work for me
>> >
>> > Fixed!
>> >
>> > sage
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> thanks
>> huangjun
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
