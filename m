From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd create error with 0.26
Date: Wed, 11 May 2011 17:56:45 -0700
Message-ID: <4DCB304D.30301@dreamhost.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>	<BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>	<BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com> <BANLkTikiCLGiEgNzkuaj0cnrxo9+Mw_x8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43599 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1ELA4p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 20:56:45 -0400
In-Reply-To: <BANLkTikiCLGiEgNzkuaj0cnrxo9+Mw_x8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/10/2011 06:54 PM, Simon Tian wrote:
> If helpless, I will got more trace info.
> BTW, where could I get the debug packages?

Unfortunately, the backtrace isn't very useful without debugging 
symbols, and I don't see any Fedora packages that include them.

You can create a package with debugging symbols using the srpm by adding 
this to the ceph.spec file:

RPM_OPT_FLAGS="$RPM_OPT_FLAGS -g"
export RPM_OPT_FLAGS

It looks like the most recent srpm is here:

http://download.fedora.redhat.com/pub/fedora/linux/development/rawhide/source/SRPMS/ceph-0.26-2.fc16.src.rpm

It might be better to build 0.27 from source, in case this is a bug that 
was already fixed.

-Josh

> 2011/5/10 Yehuda Sadeh Weinraub<yehudasa@gmail.com>:
>> On Tue, May 10, 2011 at 7:15 AM, Simon Tian<aixt2006@gmail.com>  wrote:
>>> Hi,
>>>
>>>     As you said, one of the osds crashed:
>>> ================= log ========================
>>> 2011-05-10 21:46:38.990311 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
>>> n=1 ec=2 les=6 5/5/4) [2,3] r=0 mlcod 0'0 active+clean]
>>> oi.user_version=8'2 is_modify=0
>>> 2011-05-10 21:46:38.990386 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
>>> n=1 ec=2 les=6 5/5/4) [2,3] r=0 mlcod 0'0 active+clean]
>>> oi.user_version=8'2 is_modify=1
>>> *** Caught signal (Segmentation fault) **
>>>   in thread 0x45382940
>>> =========================================
>>>
>>> I tried again, this time, i done "rbd create foo --size 1024"
>>> successfully, but when I run the code of testlibrbd.c, one of the osds
>>> crash again:
>>> ================= log ========================
>>> 2011-05-10 22:08:20.008871 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>>> n=1 ec=9 les=9 9/9/9) [3,0] r=0 mlcod 9'3 active+clean
>>> snaptrimq=[1~1]] dump_watchers testimg.rbd/head testimg.rbd/head(9'4
>>> client4107.0:14 wrlock_by=unknown0.0:0)
>>> 2011-05-10 22:08:20.008903 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>>> n=1 ec=9 les=9 9/9/9) [3,0] r=0 mlcod 9'3 active+clean
>>> snaptrimq=[1~1]]  * obc->watcher: client4107 session=0xc80990
>>> 2011-05-10 22:08:20.008925 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>>> n=1 ec=9 les=9 9/9/9) [3,0] r=0 mlcod 9'3 active+clean
>>> snaptrimq=[1~1]]  * oi->watcher: client4107 cookie=2
>>> 2011-05-10 22:08:20.009232 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>>> n=1 ec=9 les=9 9/9/9) [3,0] r=0 mlcod 9'3 active+clean]
>>> oi.user_version=10'5 is_modify=1
>>> 2011-05-10 22:08:20.009267 4b914940 expires 2011-05-10 23:08:19.890032
>>> now 2011-05-10 22:08:20.009260
>>> 2011-05-10 22:08:20.009284 napshots_list
>>> 2011-05-10 22:08:20.009307 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>>> n=1 ec=9 les=9 9/9/9) [3,0] r=0 mlcod 9'3 active+clean]
>>> oi.user_version=10'5 is_modify=0
>>> 2011-05-10 22:08:20.009375 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>>> n=1 ec=9 les=9 9/9/9) [3,0] r=0 mlcod 9'3 active+clean]
>>> oi.user_version=10'5 is_modify=1
>>> *** Caught signal (Segmentation fault) **
>>>   in thread 0x4eb1c940
>>> =========================================
>>>
>> Can you by any chance get backtrace for that crash (gdb cosd core;
>> bt)? You might need to have the debug packages installed.
>> Also, note that you're not running the latest version so you might be
>> hitting something that was already fixed (not that I remember anything
>> specific, but it might be worth a try).
>>
>> Thanks,
>> Yehuda
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

