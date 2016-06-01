From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] Message sequence overflow
Date: Wed, 1 Jun 2016 12:20:53 +0200
Message-ID: <CAOi1vP_FXC1VgduxJif0TzmDfOyX9KSbNcwgvdi64FOjNE6pnQ@mail.gmail.com>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33805 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcFAKUy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 06:20:54 -0400
Received: by mail-vk0-f68.google.com with SMTP id a6so2385845vkg.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 03:20:54 -0700 (PDT)
In-Reply-To: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, James Webb <jamesw@unity3d.com>, Sage Weil <sage@redhat.com>

> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw@unity3d.com> wrote=
:
>> Dear ceph-users...
>>
>> My team runs an internal buildfarm using ceph as a backend storage p=
latform. We=E2=80=99ve recently upgraded to Jewel and are having reliab=
ility issues that we need some help with.
>>
>> Our infrastructure is the following:
>> - We use CEPH/CEPHFS (10.2.1)
>> - We have 3 mons and 6 storage servers with a total of 36 OSDs (~416=
0 PGs).
>> - We use enterprise SSDs for everything including journals
>> - We have one main mds and one standby mds.
>> - We are using ceph kernel client to mount cephfs.
>> - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
>> - We are using a kernel NFS to serve NFS clients from a ceph mount (=
~ 32 nfs threads. 0 swappiness)
>> - These are physical machines with 8 cores & 32GB memory
>>
>> On a regular basis, we lose all IO via ceph FS. We=E2=80=99re still =
trying to isolate the issue but it surfaces as an issue between MDS and=
 ceph client.
>> We can=E2=80=99t tell if our our NFS server is overwhelming the MDS =
or if this is some unrelated issue. Tuning NFS server has not solved ou=
r issues.
>> So far our only recovery has been to fail the MDS and then restart o=
ur NFS. Any help or advice will be appreciated on the CEPH side of thin=
gs.
>> I=E2=80=99m pretty sure we=E2=80=99re running with default tuning of=
 CEPH MDS configuration parameters.
>>
>>
>> Here are the relevant log entries.
>>
>> From my primary MDS server, I start seeing these entries start to pi=
le up:
>>
>> 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluster) log =
[WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 100=
00004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877480=
 seconds ago\
>> 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluster) log =
[WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 100=
00005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877382=
 seconds ago\
>> 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluster) log =
[WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 100=
00000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877356=
 seconds ago
>>
>> From my NFS server, I see these entries from dmesg also start piling=
 up:
>> [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq=
 0 expected 4294967296
>> [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq=
 1 expected 4294967296
>> [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq=
 2 expected 4294967296
>>
>
> 4294967296 is 0x100000000, this looks like sequence  overflow.
>
> In src/msg/Message.h:
>
> class Message {
> ...
>   unsigned get_seq() const { return header.seq; }
>   void set_seq(unsigned s) { header.seq =3D s; }
> ...
> }
>
> in src/msg/simple/Pipe.cc
>
> class Pipe {
> ...
>   __u32 get_out_seq() { return out_seq; }
> ...
> }
>
> Is this bug or intentional ?

Hrm, I think this a bug^Woversight.  Sage's commit 9731226228dd
("convert more types in ceph_fs.h to __le* notation") from early 2008
changed ceph_msg_header's seq from __u32 to __le64 and also changed
dout()s in the kernel from %d to %lld, so the 32 -> 64 switch seems
like it was intentional.  Message::get/set_seq() remained unsigned...

The question is which do we fix now - changing the kernel client to
wrap at 32 would be less of a hassle and easier in terms of backporting=
,
but the problem is really in the userspace messenger.  Sage?

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
