From: Min Zhou <coderplay@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Wed, 16 Jun 2010 10:32:45 +0800
Message-ID: <AANLkTinaE0QGHc6t86C2ti00TAuUyH0I7FPh1bclLxKz@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
	<AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
	<AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
	<AANLkTik8gRPzwBzzI8rJGp2b-o6dpoFzRcGJZORC81sY@mail.gmail.com>
	<AANLkTinreVMIcxZAUuKWDjYbh2cvLi025d0QWYD8SSJs@mail.gmail.com>
	<AANLkTikUSPzXJ2rWJp1oBaJbGfz2NW_gJalhIA2eNrIz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57116 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab0FPCcq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 22:32:46 -0400
Received: by qyk1 with SMTP id 1so942988qyk.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 19:32:46 -0700 (PDT)
In-Reply-To: <AANLkTikUSPzXJ2rWJp1oBaJbGfz2NW_gJalhIA2eNrIz@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi, Yehuda,




On Wed, Jun 16, 2010 at 5:19 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 1:54 PM, Min Zhou <coderplay@gmail.com> wrote:
>>
>>
>> Still two questions:
>> 1. Why it prompted the need of all osd's root passwords?
> You specified --allhosts in the mkcephfs script command line. The
> script uses ssh to run commands on the remote hosts, so you'd probably
> need to setup your environment so that it doesn't prompt for password
> when you login there (e.g., one way to do it is to create a
> private/public keys pair, put the copy of your public key in the
> remote host under ~/.ssh/authorized_keys).


Actually, my machines were configured to SSH to without being prompted
for a password from any node to another one under the same user
account ceph. Why the system ask me for root passwords?

Btw, it seems there is still somewhat incorrectnesses of my
deployment, see below

$ ceph  -c ceph_conf/ceph.conf  start
10.06.16 05:00:29.182841 439bc940 -- :/10572 >> 192.168.0.2:6789/0
pipe(0x108f2df0 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.06.16 05:00:39.185779 42fbb940 monclient(hunting): continuing hunt
10.06.16 05:00:39.186014 41ab6940 -- :/10572 >> 192.168.0.2:6789/0
pipe(0x108f58b0 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.06.16 05:00:49.188963 42fbb940 monclient(hunting): continuing hunt
10.06.16 05:00:49.189299 443bd940 -- :/10572 >> 192.168.0.3:6789/0
pipe(0x108f5ee0 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.06.16 05:00:59.192191 42fbb940 monclient(hunting): continuing hunt
10.06.16 05:00:59.192630 44dbe940 -- :/10572 >> 192.168.0.3:6789/0
pipe(0x108f7020 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.06.16 05:01:09.195363 42fbb940 monclient(hunting): continuing hunt
10.06.16 05:01:09.195714 457bf940 -- :/10572 >> 192.168.0.3:6789/0
pipe(0x108f65e0 sd=-1 pgs=0 cs=0 l=0).fault first fault
10.06.16 05:01:19.198552 42fbb940 monclient(hunting): continuing hunt


Thanks,
Min


>> 2. Why it still has warning that tell me no keyring specified for each osd.
>
> Probably because there wasn't any keyring specified in your ceph.conf.
> As you don't setup your ceph cluster with authentication it doesn't
> really matter.
>
> Yehuda
>



-- 
My research interests are distributed systems, parallel computing and
bytecode based virtual machine.

My profile:
http://www.linkedin.com/in/coderplay
My blog:
http://coderplay.javaeye.com
