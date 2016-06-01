From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] Message sequence overflow
Date: Wed, 1 Jun 2016 15:26:57 +0200
Message-ID: <CAOi1vP9jOvgnopaFoSxR09oOFAuNmCXrcz9KsW50rqjD7n2gxA@mail.gmail.com>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
	<alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35181 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890AbcFAN06 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 09:26:58 -0400
Received: by mail-vk0-f65.google.com with SMTP id f62so3173312vkc.2
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 06:26:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, James Webb <jamesw@unity3d.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Wed, Jun 1, 2016 at 2:49 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 1 Jun 2016, Yan, Zheng wrote:
>> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw@unity3d.com> wrot=
e:
>> > Dear ceph-users...
>> >
>> > My team runs an internal buildfarm using ceph as a backend storage=
 platform. We=E2=80=99ve recently upgraded to Jewel and are having reli=
ability issues that we need some help with.
>> >
>> > Our infrastructure is the following:
>> > - We use CEPH/CEPHFS (10.2.1)
>> > - We have 3 mons and 6 storage servers with a total of 36 OSDs (~4=
160 PGs).
>> > - We use enterprise SSDs for everything including journals
>> > - We have one main mds and one standby mds.
>> > - We are using ceph kernel client to mount cephfs.
>> > - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
>> > - We are using a kernel NFS to serve NFS clients from a ceph mount=
 (~ 32 nfs threads. 0 swappiness)
>> > - These are physical machines with 8 cores & 32GB memory
>> >
>> > On a regular basis, we lose all IO via ceph FS. We=E2=80=99re stil=
l trying to isolate the issue but it surfaces as an issue between MDS a=
nd ceph client.
>> > We can=E2=80=99t tell if our our NFS server is overwhelming the MD=
S or if this is some unrelated issue. Tuning NFS server has not solved =
our issues.
>> > So far our only recovery has been to fail the MDS and then restart=
 our NFS. Any help or advice will be appreciated on the CEPH side of th=
ings.
>> > I=E2=80=99m pretty sure we=E2=80=99re running with default tuning =
of CEPH MDS configuration parameters.
>> >
>> >
>> > Here are the relevant log entries.
>> >
>> > From my primary MDS server, I start seeing these entries start to =
pile up:
>> >
>> > 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluster) lo=
g [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 1=
0000004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.8774=
80 seconds ago\
>> > 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluster) lo=
g [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 1=
0000005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.8773=
82 seconds ago\
>> > 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluster) lo=
g [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 1=
0000000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.8773=
56 seconds ago
>> >
>> > From my NFS server, I see these entries from dmesg also start pili=
ng up:
>> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 s=
eq 0 expected 4294967296
>> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 s=
eq 1 expected 4294967296
>> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 s=
eq 2 expected 4294967296
>> >
>>
>> 4294967296 is 0x100000000, this looks like sequence  overflow.
>>
>> In src/msg/Message.h:
>>
>> class Message {
>> ...
>>   unsigned get_seq() const { return header.seq; }
>>   void set_seq(unsigned s) { header.seq =3D s; }
>> ...
>> }
>>
>> in src/msg/simple/Pipe.cc
>>
>> class Pipe {
>> ...
>>   __u32 get_out_seq() { return out_seq; }
>> ...
>> }
>>
>> Is this bug or intentional ?
>
> That's a bug.  The seq values are intended to be 32 bits.
>
> (We should also be using the ceph_cmp_seq (IIRC) helper for any inequ=
ality
> checks, which does a sloppy comparison so that a 31-bit signed differ=
ence
> is used to determine > or <.  It sounds like in this case we're just
> failing an equality check, though.)

ceph_seq_cmp().  I'll patch the kernel client then (if Zheng doesn't
get to it first).

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
