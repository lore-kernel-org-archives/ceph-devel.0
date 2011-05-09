From: Simon Tian <aixt2006@gmail.com>
Subject: Re: replication write speed
Date: Mon, 9 May 2011 11:04:29 +0800
Message-ID: <BANLkTinznnde+t8sLSMT3rMmN6tyQ5Z-Bw@mail.gmail.com>
References: <BANLkTimPZ0rNe2-edtahK4RHRMQZH52qBw@mail.gmail.com>
	<BANLkTi=gkJcs9yxXVAMo9nrvz2J1yGhQ4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33241 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1EIDEb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 May 2011 23:04:31 -0400
Received: by wya21 with SMTP id 21so3561827wya.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 May 2011 20:04:29 -0700 (PDT)
In-Reply-To: <BANLkTi=gkJcs9yxXVAMo9nrvz2J1yGhQ4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

2011/5/9 Gregory Farnum <gregf@hq.newdream.net>:
> On Sun, May 8, 2011 at 7:43 PM, Simon Tian <aixt2006@gmail.com> wrote=
:
>> Hi folks,
>>
>> =C2=A0 =C2=A0 =C2=A0I am testing the replication performance of ceph=
-0.26 with
>> libceph, write 1G data in with ceph_write() and read it out with
>> ceph_read(),
>>
>> rep_size =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2
>> =C2=A0 =C2=A03 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A04
>> write=EF=BC=9A =C2=A078.8 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 39.38 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02=
7.7 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20.90 MB/s
>> read=EF=BC=9A =C2=A0 85.3 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 85.33 MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07=
8.77MB/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 78.77MB/s
>>
>> I think if the replication strategy is splay or primary copy, not th=
e
>> chain, as the thesis said, =C2=A0 writing speed for 3, 4 or even mor=
e
>> replication will be a little worse than =C2=A02 replication, should =
be near
>> with 39.38 MB/s.
>> But the write performance =C2=A0I got is affect so much by size of r=
eplication.
>>
>> What is the replication strategy in ceph-0.26, not splay? =C2=A0If s=
play,
>> why not near with 39.38 MB/s?
>>
>> There is 5 OSDs in 2 hosts, 2 in one and 3 int the other.
>
> The replication strategy has been fixed at primary copy for several
> years now. At expected replication levels (2-3) there just isn't a bi=
g
> difference between the strategies, and limiting it to primary-copy
> replication makes a lot of the bookkeeping for data safety much easie=
r
> to handle.

As you know, I am a fresh to ceph, haha

=46or primary copy, I think when the replication size is 3, 4, or even
more, the writing speed should also near with 2 replication. Because
the 2nd, 3rd, 4th, ... replication are written parallelly.  The speed
I got for 3, 4 replication is not near with the speed of 2, in fact,
like linear reduce.

Thx very much!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
