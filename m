From: huang jun <hjwsm1989@gmail.com>
Subject: Re: read performance not perfect
Date: Tue, 9 Aug 2011 11:56:45 +0800
Message-ID: <CABAwU-b6dWE_DCHTxkR7HTiTRG6krkW4hmdqYz=s5KsbcapFbA@mail.gmail.com>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
	<Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
	<CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
	<Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64704 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab1HID4q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2011 23:56:46 -0400
Received: by vxi9 with SMTP id 9so2985185vxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2011 20:56:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

hi,sage
we have a test recently,use 5 OSDs on v0.30, OS is linux-2.6.39
the read speed increased to 79MB/s at first read,
and avg ups to 85MB/s~90MB/s, about two times of our former test ,it
promotes read performance very much.
but we don't know whether it lives up to your expectations.

2011/8/4 Sage Weil <sage@newdream.net>:
> Hi,
>
> I've just pushed a wip-readahead branch to ceph-client.git that rewri=
tes
> ceph_readpages (used for readahead) to be fully asynchronous. =A0This=
 should
> let us take full advantage of whatever the readahead window is. =A0I'=
m still
> doing some testing on this end, but things look good so far.
>
> There are two relevant mount options:
>
> =A0rasize=3DNN =A0 =A0- max readahead window size (bytes)
> =A0rsize=3DMM =A0 =A0 - max read size
>
> rsize defaults to 0 (no limit), which means it effectively maxes out =
at
> the stripe size (one object, 4MB by default).
>
> rasize now defaults to 8 MB. =A0This is probably what you'll want to
> experiment with. =A0In practice I think something on the order of 8-1=
2 MB
> will be best, as it will start loading things of disk ~2 objects ahea=
d of
> the current position.
>
> Can you give it a go and see if this helps in your environment?
>
> Thanks!
> sage
>
>
> On Tue, 19 Jul 2011, huang jun wrote:
>> thanks for you reply
>> now we find two points confused us:
>> 1) the kernel client execute sequence read though aio_read function,
>> but from OSD log,
>> =A0 =A0the dispatch_queue length in OSD is always 0, it means OSD ca=
n't
>> got next READ message until client send to it. It seems that
>> async_read changes to sync_read, OSD can't parallely read data, so c=
an
>> not make the most of =A0resources.What are the original purposes whe=
n
>> you design this part? perfect realiablity?
>
> Right. =A0The old ceph_readpages was synhronous, which slowed things =
down in
> a couple of different ways.
>
>> 2) In singleness read circumstance,during OSD read data from it disk=
,
>> the OSD doesn't do anything but to wait it finish.We think it was th=
e
>> result of 1), OSD have nothing to do,so just to wait.
>>
>>
>> 2011/7/19 Sage Weil <sage@newdream.net>:
>> > On Mon, 18 Jul 2011, huang jun wrote:
>> >> hi,all
>> >> We test ceph's read performance last week, and find something wei=
rd
>> >> we use ceph v0.30 on linux 2.6.37
>> >> mount ceph on back-platform consist of 2 osds \1 mon \1 mds
>> >> $mount -t ceph 192.168.1.103:/ /mnt -vv
>> >> $ dd if=3D/dev/zero of=3D/mnt/test bs=3D4M count=3D200
>> >> $ cd .. && umount /mnt
>> >> $mount -t ceph 192.168.1.103:/ /mnt -vv
>> >> $dd if=3Dtest of=3D/dev/zero bs=3D4M
>> >> =A0 200+0 records in
>> >> =A0 200+0 records out
>> >> =A0 838860800 bytes (839 MB) copied, 16.2327 s, 51.7 MB/s
>> >> but if we use rados to test it
>> >> $ rados -m 192.168.1.103:6789 -p data bench 60 write
>> >> $ rados -m 192.168.1.103:6789 -p data bench 60 seq
>> >> =A0 the result is:
>> >> =A0 Total time run: =A0 =A0 =A0 =A024.733935
>> >> =A0 Total reads made: =A0 =A0 438
>> >> =A0 Read size: =A0 =A0 =A0 =A0 =A0 =A04194304
>> >> =A0 Bandwidth (MB/sec): =A0 =A070.834
>> >>
>> >> =A0 Average Latency: =A0 =A0 =A0 0.899429
>> >> =A0 Max latency: =A0 =A0 =A0 =A0 =A0 1.85106
>> >> =A0 Min latency: =A0 =A0 =A0 =A0 =A0 0.128017
>> >> this phenomenon attracts our attention, then we begin to analysis=
 the
>> >> osd debug log.
>> >> we find that :
>> >> 1) the kernel client send READ request, at first it requests 1MB,=
 and
>> >> after that it is 512KB
>> >> 2) from rados test cmd log, OSD recept the READ op with 4MB data =
to handle
>> >> we know the ceph developers pay their attention to read and write
>> >> performance, so i just want to confrim that
>> >> if the communication between the client and OSD spend =A0more tim=
e than
>> >> it should be? can we request =A0bigger size, just like default ob=
ject
>> >> size 4MB, when it occurs to READ operation? or this is related to=
 OS
>> >> management, if so, what can we do to promote the performance?
>> >
>> > I think it's related to the way the Linux VFS is doing readahead, =
and how
>> > the ceph fs code is handling it. =A0It's issue #1122 in the tracke=
r and I
>> > plan to look at it today or tomorrow!
>> >
>> > Thanks-
>> > sage
>> >
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
