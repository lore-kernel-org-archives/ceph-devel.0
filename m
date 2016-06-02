From: Alex Elder <elder@ieee.org>
Subject: Re: Message sequence overflow
Date: Wed, 1 Jun 2016 22:07:14 -0500
Message-ID: <574FA2E2.20605@ieee.org>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
 <alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
 <CAAM7YA=xU+Ovxf-QU6ruRKGhWS88-d0UaX1AbcR9oCLbEi9_jg@mail.gmail.com>
 <alpine.DEB.2.11.1606011019090.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35553 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcFBDH2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 23:07:28 -0400
Received: by mail-io0-f169.google.com with SMTP id o189so24573336ioe.2
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 20:07:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606011019090.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, James Webb <jamesw@unity3d.com>

On 06/01/2016 09:22 AM, Sage Weil wrote:
> On Wed, 1 Jun 2016, Yan, Zheng wrote:
>> On Wed, Jun 1, 2016 at 8:49 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Wed, 1 Jun 2016, Yan, Zheng wrote:
>>>> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw@unity3d.com> wr=
ote:
>>>>> Dear ceph-users...
>>>>>
>>>>> My team runs an internal buildfarm using ceph as a backend storag=
e platform. We=E2=80=99ve recently upgraded to Jewel and are having rel=
iability issues that we need some help with.
>>>>>
>>>>> Our infrastructure is the following:
>>>>> - We use CEPH/CEPHFS (10.2.1)
>>>>> - We have 3 mons and 6 storage servers with a total of 36 OSDs (~=
4160 PGs).
>>>>> - We use enterprise SSDs for everything including journals
>>>>> - We have one main mds and one standby mds.
>>>>> - We are using ceph kernel client to mount cephfs.
>>>>> - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
>>>>> - We are using a kernel NFS to serve NFS clients from a ceph moun=
t (~ 32 nfs threads. 0 swappiness)
>>>>> - These are physical machines with 8 cores & 32GB memory
>>>>>
>>>>> On a regular basis, we lose all IO via ceph FS. We=E2=80=99re sti=
ll trying to isolate the issue but it surfaces as an issue between MDS =
and ceph client.
>>>>> We can=E2=80=99t tell if our our NFS server is overwhelming the M=
DS or if this is some unrelated issue. Tuning NFS server has not solved=
 our issues.
>>>>> So far our only recovery has been to fail the MDS and then restar=
t our NFS. Any help or advice will be appreciated on the CEPH side of t=
hings.
>>>>> I=E2=80=99m pretty sure we=E2=80=99re running with default tuning=
 of CEPH MDS configuration parameters.
>>>>>
>>>>>
>>>>> Here are the relevant log entries.
>>>>>
>>>>> From my primary MDS server, I start seeing these entries start to=
 pile up:
>>>>>
>>>>> 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluster) l=
og [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino =
10000004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877=
480 seconds ago\
>>>>> 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluster) l=
og [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino =
10000005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877=
382 seconds ago\
>>>>> 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluster) l=
og [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino =
10000000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877=
356 seconds ago
>>>>>
>>>>> From my NFS server, I see these entries from dmesg also start pil=
ing up:
>>>>> [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 =
seq 0 expected 4294967296
>>>>> [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 =
seq 1 expected 4294967296
>>>>> [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 =
seq 2 expected 4294967296
>>>>>
>>>>
>>>> 4294967296 is 0x100000000, this looks like sequence  overflow.
>>>>
>>>> In src/msg/Message.h:
>>>>
>>>> class Message {
>>>> ...
>>>>   unsigned get_seq() const { return header.seq; }
>>>>   void set_seq(unsigned s) { header.seq =3D s; }
>>>> ...
>>>> }
>>>>
>>>> in src/msg/simple/Pipe.cc
>>>>
>>>> class Pipe {
>>>> ...
>>>>   __u32 get_out_seq() { return out_seq; }
>>>> ...
>>>> }
>>>>
>>>> Is this bug or intentional ?
>>>
>>> That's a bug.  The seq values are intended to be 32 bits.
>>>
>>> (We should also be using the ceph_cmp_seq (IIRC) helper for any ine=
quality
>>> checks, which does a sloppy comparison so that a 31-bit signed diff=
erence
>>> is used to determine > or <.  It sounds like in this case we're jus=
t
>>> failing an equality check, though.)
>>>
>>
>> struct ceph_msg_header {
>>         __le64 seq;       /* message seq# for this session */
>>         ...
>> }
>>
>> you means we should leave the upper 32-bits unused?
>=20
> Oh, hmm. I'm confusing this with the cap seq (which is 32 bits). =20
>=20
> I think we can safely go either way.. the question is which path is=20
> easier.  If we move to 32 bits used on the kernel side, will userspac=
e=20
> also need to be patched to make reconnect work?  That unsigned get_se=
q()=20
> is only 32-bits wide.

What is the value of the 64 bit message sequence number?
Does the message sequence number only have to be big enough
to be unique for all conceivable in-flight messages?  If so,
32 bits (or maybe less, but I wouldn't suggest that)
might be enough and 64 bits might have been over-designed.

					-Alex

> If we go with 64 bits, userspace still needs to be fixed to change th=
at=20
> unsigned to uint64_t.
>=20
> What do you think?
> sage
>=20
>=20
>>
>>
>>> sage
>>>
>>>
>>>> Regards
>>>> Yan, Zheng
>>>>
>>>>
>>>>> Next, we find something like this on one of the OSDs.:
>>>>> 2016-05-31 14:34:44.130279 mon.0 XX.XX.XX.188:6789/0 1272184 : cl=
uster [INF] HEALTH_WARN; mds0: Client storage-nfs-01 failing to respond=
 to capability release
>>>>>
>>>>> Finally, I am seeing consistent HEALTH_WARN in my status regardin=
g trimming which I am not sure if it is related:
>>>>>
>>>>> cluster XXXXXXXX-bd8f-4091-bed3-8586fd0d6b46
>>>>>      health HEALTH_WARN
>>>>>             mds0: Behind on trimming (67/30)
>>>>>      monmap e3: 3 mons at {storage02=3DX.X.X.190:6789/0,storage03=
=3DX.X.X.189:6789/0,storage04=3DX.X.X.188:6789/0}
>>>>>             election epoch 206, quorum 0,1,2 storage04,storage03,=
storage02
>>>>>       fsmap e74879: 1/1/1 up {0=3Dcephfs-03=3Dup:active}, 1 up:st=
andby
>>>>>      osdmap e65516: 36 osds: 36 up, 36 in
>>>>>       pgmap v15435732: 4160 pgs, 3 pools, 37539 GB data, 9611 kob=
jects
>>>>>             75117 GB used, 53591 GB / 125 TB avail
>>>>>                 4160 active+clean
>>>>>   client io 334 MB/s rd, 319 MB/s wr, 5839 op/s rd, 4848 op/s wr
>>>>>
>>>>>
>>>>> Regards,
>>>>> James Webb
>>>>> DevOps Engineer, Engineering Tools
>>>>> Unity Technologies
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
