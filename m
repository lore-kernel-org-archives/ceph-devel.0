From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] Message sequence overflow
Date: Wed, 1 Jun 2016 16:46:14 +0200
Message-ID: <CAOi1vP90rRZsRPOGSPuL8oc5F-1HuygpWrEQaqkD8eFdivN7Qw@mail.gmail.com>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
	<alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
	<CAAM7YA=xU+Ovxf-QU6ruRKGhWS88-d0UaX1AbcR9oCLbEi9_jg@mail.gmail.com>
	<alpine.DEB.2.11.1606011019090.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33179 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcFAOqP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 10:46:15 -0400
Received: by mail-vk0-f67.google.com with SMTP id m81so3617836vka.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 07:46:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606011019090.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, James Webb <jamesw@unity3d.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Wed, Jun 1, 2016 at 4:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 1 Jun 2016, Yan, Zheng wrote:
>> On Wed, Jun 1, 2016 at 8:49 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Wed, 1 Jun 2016, Yan, Zheng wrote:
>> >> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw@unity3d.com> wrote:
>> >> > Dear ceph-users...
>> >> >
>> >> > My team runs an internal buildfarm using ceph as a backend storage platform. We\u2019ve recently upgraded to Jewel and are having reliability issues that we need some help with.
>> >> >
>> >> > Our infrastructure is the following:
>> >> > - We use CEPH/CEPHFS (10.2.1)
>> >> > - We have 3 mons and 6 storage servers with a total of 36 OSDs (~4160 PGs).
>> >> > - We use enterprise SSDs for everything including journals
>> >> > - We have one main mds and one standby mds.
>> >> > - We are using ceph kernel client to mount cephfs.
>> >> > - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
>> >> > - We are using a kernel NFS to serve NFS clients from a ceph mount (~ 32 nfs threads. 0 swappiness)
>> >> > - These are physical machines with 8 cores & 32GB memory
>> >> >
>> >> > On a regular basis, we lose all IO via ceph FS. We\u2019re still trying to isolate the issue but it surfaces as an issue between MDS and ceph client.
>> >> > We can\u2019t tell if our our NFS server is overwhelming the MDS or if this is some unrelated issue. Tuning NFS server has not solved our issues.
>> >> > So far our only recovery has been to fail the MDS and then restart our NFS. Any help or advice will be appreciated on the CEPH side of things.
>> >> > I\u2019m pretty sure we\u2019re running with default tuning of CEPH MDS configuration parameters.
>> >> >
>> >> >
>> >> > Here are the relevant log entries.
>> >> >
>> >> > From my primary MDS server, I start seeing these entries start to pile up:
>> >> >
>> >> > 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluster) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 10000004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877480 seconds ago\
>> >> > 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluster) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 10000005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877382 seconds ago\
>> >> > 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluster) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 10000000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877356 seconds ago
>> >> >
>> >> > From my NFS server, I see these entries from dmesg also start piling up:
>> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq 0 expected 4294967296
>> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq 1 expected 4294967296
>> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq 2 expected 4294967296
>> >> >
>> >>
>> >> 4294967296 is 0x100000000, this looks like sequence  overflow.
>> >>
>> >> In src/msg/Message.h:
>> >>
>> >> class Message {
>> >> ...
>> >>   unsigned get_seq() const { return header.seq; }
>> >>   void set_seq(unsigned s) { header.seq = s; }
>> >> ...
>> >> }
>> >>
>> >> in src/msg/simple/Pipe.cc
>> >>
>> >> class Pipe {
>> >> ...
>> >>   __u32 get_out_seq() { return out_seq; }
>> >> ...
>> >> }
>> >>
>> >> Is this bug or intentional ?
>> >
>> > That's a bug.  The seq values are intended to be 32 bits.
>> >
>> > (We should also be using the ceph_cmp_seq (IIRC) helper for any inequality
>> > checks, which does a sloppy comparison so that a 31-bit signed difference
>> > is used to determine > or <.  It sounds like in this case we're just
>> > failing an equality check, though.)
>> >
>>
>> struct ceph_msg_header {
>>         __le64 seq;       /* message seq# for this session */
>>         ...
>> }
>>
>> you means we should leave the upper 32-bits unused?
>
> Oh, hmm. I'm confusing this with the cap seq (which is 32 bits).
>
> I think we can safely go either way.. the question is which path is
> easier.  If we move to 32 bits used on the kernel side, will userspace
> also need to be patched to make reconnect work?  That unsigned get_seq()
> is only 32-bits wide.
>
> If we go with 64 bits, userspace still needs to be fixed to change that
> unsigned to uint64_t.
>
> What do you think?

Did you guys see my previous message?  I didn't bother to check what
kind of sequence numbers ceph_seq_cmp() - it's seems to be unused BTW,
so I got diverted by Sage's reply.

> Hrm, I think this a bug^Woversight.  Sage's commit 9731226228dd
> ("convert more types in ceph_fs.h to __le* notation") from early 2008
> changed ceph_msg_header's seq from __u32 to __le64 and also changed
> dout()s in the kernel from %d to %lld, so the 32 -> 64 switch seems
> like it was intentional.  Message::get/set_seq() remained unsigned...
>
> The question is which do we fix now - changing the kernel client to
> wrap at 32 would be less of a hassle and easier in terms of backporting,
> but the problem is really in the userspace messenger.  Sage?

Patching the kernel should be trivial - I don't think userspace would
need to be patched in this case.  The change can also be backported
easily.  Going with 64 bits in userspace would be a lot messier...

OTOH the "bug" is in the userspace messenger, so I'd vote for fixing
the userspace, especially if we can piggy back on one of the looming
feature bits for this.

Thanks,

                Ilya
