From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Wed, 16 Jun 2010 12:54:02 -0700
Message-ID: <AANLkTinbbQrlrfnURikm6HLR39gHf80KbDEhroAlPhZg@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
	<AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
	<AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
	<AANLkTik8gRPzwBzzI8rJGp2b-o6dpoFzRcGJZORC81sY@mail.gmail.com>
	<AANLkTinreVMIcxZAUuKWDjYbh2cvLi025d0QWYD8SSJs@mail.gmail.com>
	<AANLkTikUSPzXJ2rWJp1oBaJbGfz2NW_gJalhIA2eNrIz@mail.gmail.com>
	<AANLkTinaE0QGHc6t86C2ti00TAuUyH0I7FPh1bclLxKz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35487 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0FPTyE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 15:54:04 -0400
Received: by vws13 with SMTP id 13so3053539vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jun 2010 12:54:03 -0700 (PDT)
In-Reply-To: <AANLkTinaE0QGHc6t86C2ti00TAuUyH0I7FPh1bclLxKz@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Min Zhou <coderplay@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 15, 2010 at 7:32 PM, Min Zhou <coderplay@gmail.com> wrote:
> Hi, Yehuda,
>
>
>
>
> On Wed, Jun 16, 2010 at 5:19 AM, Yehuda Sadeh Weinraub
> <yehudasa@gmail.com> wrote:
>> On Tue, Jun 15, 2010 at 1:54 PM, Min Zhou <coderplay@gmail.com> wrot=
e:
>>>
>>>
>>> Still two questions:
>>> 1. Why it prompted the need of all osd's root passwords?
>> You specified --allhosts in the mkcephfs script command line. The
>> script uses ssh to run commands on the remote hosts, so you'd probab=
ly
>> need to setup your environment so that it doesn't prompt for passwor=
d
>> when you login there (e.g., one way to do it is to create a
>> private/public keys pair, put the copy of your public key in the
>> remote host under ~/.ssh/authorized_keys).
>
>
> Actually, my machines were configured to SSH to without being prompte=
d
> for a password from any node to another one under the same user
> account ceph. Why the system ask me for root passwords?

In order to use btrfs volumes the system needs to access the machines
as root (this is the default behavior). Also note that your 'user'
entry in your ceph.conf is messed up.

>
> Btw, it seems there is still somewhat incorrectnesses of my
> deployment, see below
>
> $ ceph =A0-c ceph_conf/ceph.conf =A0start
> 10.06.16 05:00:29.182841 439bc940 -- :/10572 >> 192.168.0.2:6789/0
> pipe(0x108f2df0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 10.06.16 05:00:39.185779 42fbb940 monclient(hunting): continuing hunt
> 10.06.16 05:00:39.186014 41ab6940 -- :/10572 >> 192.168.0.2:6789/0
> pipe(0x108f58b0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault

This looks like your monitors are down.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
