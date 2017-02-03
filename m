From: Max Yehorov <myehorov@skytap.com>
Subject: Re: Possible bug in krbd (4.4.0)
Date: Fri, 3 Feb 2017 15:20:59 -0800
Message-ID: <CAJDfiskjz2H-D9xmanZ9opw+0pVAK=VmSPtFz1+fbcfPofOpmg@mail.gmail.com>
References: <CAJDfiske056EADPT4g0fRUx=uh7C-F3ZzUh6A1ummfUZ6vMuTg@mail.gmail.com>
 <CAOi1vP9Jvnepv3PxFA1PO_vZnEJ-DRBsax_+U136GSWPzCc1Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36726 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdBCXVc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 18:21:32 -0500
Received: by mail-wm0-f48.google.com with SMTP id c85so52572594wmi.1
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2017 15:21:31 -0800 (PST)
In-Reply-To: <CAOi1vP9Jvnepv3PxFA1PO_vZnEJ-DRBsax_+U136GSWPzCc1Xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

It is certainly annoying. It does not allow to umount for hours.
> Does umount error out or hang forever?
umount errors out. with
umount: target is busy
        (In some cases useful info about processes that
         use the device is found by lsof(8) or fuser(1).)

Maybe this will help?

- lsof, for the rbd device in question, shows it is in use by pid 5926

dio/rbd0  5926  root  cwd   DIR                8,5   4096          2 /
dio/rbd0  5926  root  rtd     DIR                8,5   4096          2 /
dio/rbd0  5926  root  txt     unknown                   /proc/5926/exe

- PID 5926 is dio, it seems like a kernel thread
ps ax | grep 5926
 5926 ?        S<     0:00 [dio/rbd0]

- Also, there is no more dio but that one
ps ax | grep dio
 5926 ?        S<     0:00 [dio/rbd0]


On Sat, Jan 7, 2017 at 8:08 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Jan 4, 2017 at 3:13 AM, Max Yehorov <myehorov@skytap.com> wrote:
>> Hi,
>>
>> I have encountered a weird possible bug. There is an rbd image mapped
>> and mounted on a client machine. It is not possible to umount it. Both
>> lsof and fuser show no mention of neither device nor mountpoint. It is
>> not exported via nfs kernel server, so unlikely it is blocked by
>> kernel.
>>
>> There is an odd pattern in syslog, two osds are constantly loose
>> connections. A wild guess is that umount tries to contact primary osd
>> and fails?
>
> Does umount error out or hang forever?
>
>>
>> After I enabled kernel debug I saw the following:
>>
>> [9586733.605792] libceph:  con_open ffff880748f58030 10.80.16.74:6812
>> [9586733.623876] libceph:  connect 10.80.16.74:6812
>> [9586733.625091] libceph:  connect 10.80.16.74:6812 EINPROGRESS sk_state = 2
>> [9586756.681246] libceph:  con_keepalive ffff881057d082b8
>> [9586767.713067] libceph:  fault ffff880748f59830 state 5 to peer
>> 10.80.16.78:6812
>> [9586767.713593] libceph: osd27 10.80.16.78:6812 socket closed (con state OPEN)
>> [9586767.721145] libceph:  con_close ffff880748f59830 peer 10.80.16.78:6812
>> [9586767.724440] libceph:  con_open ffff880748f59830 10.80.16.78:6812
>> [9586767.742487] libceph:  connect 10.80.16.78:6812
>> [9586767.743696] libceph:  connect 10.80.16.78:6812 EINPROGRESS sk_state = 2
>> [9587346.956812] libceph:  try_read start on ffff881057d082b8 state 5
>> [9587466.968125] libceph:  try_write start ffff881057d082b8 state 5
>> [9587634.021257] libceph:  fault ffff880748f58030 state 5 to peer
>> 10.80.16.74:6812
>> [9587634.021781] libceph: osd19 10.80.16.74:6812 socket closed (con state OPEN)
>> [9587634.029336] libceph:  con_close ffff880748f58030 peer 10.80.16.74:6812
>> [9587634.032628] libceph:  con_open ffff880748f58030 10.80.16.74:6812
>> [9587634.050677] libceph:  connect 10.80.16.74:6812
>> [9587634.051888] libceph:  connect 10.80.16.74:6812 EINPROGRESS sk_state = 2
>> [9587668.124746] libceph:  fault ffff880748f59830 state 5 to peer
>> 10.80.16.78:6812
>
> How many rbd images were mapped on that machine at that time?  This
> looks like two idle mappings reestablishing watch connections - if you
> look closely, you'll notice that those "fault to peer" messages are
> exactly 15 minutes apart.  This behaviour is annoying, but harmless.
>
> If umount hangs, an output of
>
> $ cat /sys/kernel/debug/ceph/<fsid>/osdc
> $ echo w >/proc/sysrq-trigger
> $ echo t >/proc/sysrq-trigger
>
> might have helped.
>
> Thanks,
>
>                 Ilya
