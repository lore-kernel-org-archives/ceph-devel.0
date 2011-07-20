From: huang jun <hjwsm1989@gmail.com>
Subject: Re: read performance not perfect
Date: Wed, 20 Jul 2011 08:21:33 +0800
Message-ID: <CABAwU-a8Z7jrVw5b_UE+5ECkoHydywaxyzyZS-Gfz8uTX-bUaw@mail.gmail.com>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
	<Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38812 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab1GTAVe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 20:21:34 -0400
Received: by wwe5 with SMTP id 5so4675486wwe.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 17:21:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thanks for you reply
now we find two points confused us:
1) the kernel client execute sequence read though aio_read function,
but from OSD log,
  the dispatch_queue length in OSD is always 0, it means OSD can't
got next READ message until client send to it. It seems that
async_read changes to sync_read, OSD can't parallely read data, so can
not make the most of  resources.What are the original purposes when
you design this part? perfect realiablity?
2) In singleness read circumstance,during OSD read data from it disk,
the OSD doesn't do anything but to wait it finish.We think it was the
result of 1), OSD have nothing to do,so just to wait.

2011/7/19 Sage Weil <sage@newdream.net>:
> On Mon, 18 Jul 2011, huang jun wrote:
>> hi,all
>> We test ceph's read performance last week, and find something weird
>> we use ceph v0.30 on linux 2.6.37
>> mount ceph on back-platform consist of 2 osds \1 mon \1 mds
>> $mount -t ceph 192.168.1.103:/ /mnt -vv
>> $ dd if=3D/dev/zero of=3D/mnt/test bs=3D4M count=3D200
>> $ cd .. && umount /mnt
>> $mount -t ceph 192.168.1.103:/ /mnt -vv
>> $dd if=3Dtest of=3D/dev/zero bs=3D4M
>> =A0 200+0 records in
>> =A0 200+0 records out
>> =A0 838860800 bytes (839 MB) copied, 16.2327 s, 51.7 MB/s
>> but if we use rados to test it
>> $ rados -m 192.168.1.103:6789 -p data bench 60 write
>> $ rados -m 192.168.1.103:6789 -p data bench 60 seq
>> =A0 the result is:
>> =A0 Total time run: =A0 =A0 =A0 =A024.733935
>> =A0 Total reads made: =A0 =A0 438
>> =A0 Read size: =A0 =A0 =A0 =A0 =A0 =A04194304
>> =A0 Bandwidth (MB/sec): =A0 =A070.834
>>
>> =A0 Average Latency: =A0 =A0 =A0 0.899429
>> =A0 Max latency: =A0 =A0 =A0 =A0 =A0 1.85106
>> =A0 Min latency: =A0 =A0 =A0 =A0 =A0 0.128017
>> this phenomenon attracts our attention, then we begin to analysis th=
e
>> osd debug log.
>> we find that :
>> 1) the kernel client send READ request, at first it requests 1MB, an=
d
>> after that it is 512KB
>> 2) from rados test cmd log, OSD recept the READ op with 4MB data to =
handle
>> we know the ceph developers pay their attention to read and write
>> performance, so i just want to confrim that
>> if the communication between the client and OSD spend =A0more time t=
han
>> it should be? can we request =A0bigger size, just like default objec=
t
>> size 4MB, when it occurs to READ operation? or this is related to OS
>> management, if so, what can we do to promote the performance?
>
> I think it's related to the way the Linux VFS is doing readahead, and=
 how
> the ceph fs code is handling it. =A0It's issue #1122 in the tracker a=
nd I
> plan to look at it today or tomorrow!
>
> Thanks-
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
