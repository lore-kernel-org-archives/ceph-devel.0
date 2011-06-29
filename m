From: huang jun <hjwsm1989@gmail.com>
Subject: Re: mds sync wrlock
Date: Wed, 29 Jun 2011 18:16:09 +0800
Message-ID: <BANLkTim_k-8Wqqx6e6W+R0LdaNvCGPUNng@mail.gmail.com>
References: <BANLkTin9SkuYVnatyXoKCjHiJevCizKwVA@mail.gmail.com>
	<B0DF7127-A5BF-4DAE-A22C-1FD9C284172B@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50464 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab1F2KQL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2011 06:16:11 -0400
Received: by wwe5 with SMTP id 5so1070410wwe.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2011 03:16:10 -0700 (PDT)
In-Reply-To: <B0DF7127-A5BF-4DAE-A22C-1FD9C284172B@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hi,Gregory
now, we test the ceph 0.30, and get the same result.
steps are:
we mount ceph on /mnt/test/
then create dir "/mnt/test/a/b/"
1) in dir "b" , use "seq 3000|xargs -i mkdir {}" to create 3000 dirs
2) and at some time,make a directory "c" in "a"
from the mds debug log:

 2011-06-29 05:44:19.368961 7f7a0b421700 mds0.locker wrlock_start
waiting on (inest lock->sync w=3D1 dirty flushing) on [inode 1000000000=
0
[...2,head] /a/ auth v18 pv20 ap=3D312 f(v0 m2011-06-29 05:44:15.550665
2=3D0+2) n(v0 rc2011-06-29 05:44:15.550665 1934=3D0+1934) (iauth sync r=
=3D1)
(isnap sync r=3D1) (inest lock->sync w=3D1 dirty flushing) (ifile excl
w=3D1) (ixattr excl) (iversion lock) caps=3D{4099=3DpAsLsXsxFsx/-@10},l=
=3D4099
| dirtyscattered lock dirfrag caps dirty authpin 0x14c97e0]

we find:
the dir "a" was locked when we create dirs below dir "b"
in function predirty_journal_parents (in MDCache.cc ), the flag "stop"
was marked true,so we got the message "predirty_journal_parents stop.
marking nestlock on".
 step 1) got a lock of dir "a", it type is  CEPH_LOCK_INEST , it name
is " sync "
and the value of  this lock is "inest lock->sync w=3D1 dirty flushing".

i want to know:
why =A0it got the wrlock of dir "a" when creates dirs below dir "b" ?

thanks!


2011/6/28 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Jun 27, 2011, at 4:53 AM, huang jun wrote:
>
>> hi,all
>> now,we test the directory operation in ceph,and found follow phenome=
nons:
>> we mount ceph on /mnt/test/
>> then create dir "/mnt/test/a/b/"
>> 1) in dir "b" , use "seq 3000|xargs -i mkdir {}" to create 3000 dirs
>> 2) and at some time,make a directory "c" in "a"
>> then step 2) returns very slow,from the debug log,we got :
>> step 2) will block =A0until =A0step 1) =A0finished
>> because =A0step 2) need a sync wrlock of dir "a", but step 1) got th=
e
>> wrlock in predirectory_journal_parents function
>> until it finished works .
>> so i have few questions:
>> =A0a) why step 1) =A0got the wrlock of dir "a" ? I think it should j=
ust
>> hold the wrlock of dir "b",but not dir "a".
>> =A0b) why circularly judge the =A0variable "stop" value =A0of all th=
e
>> parent directory of dir "b" ?
>
> Hmm. Which locks specifically are getting wrlock'ed in dir a? In gene=
ral it shouldn't be taking locks there to make files in dir b, although=
 it can happen in various circumstances for certain of the locks.
>
> Also, what versions are you using of the server code and your client?
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
