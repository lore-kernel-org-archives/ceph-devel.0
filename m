From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [ceph-users] Message sequence overflow
Date: Thu, 2 Jun 2016 17:50:06 +0800
Message-ID: <CAAM7YAmnUPyoTTNSd2RUyyoFra96acK-VmAXe868zN0fyL0=8w@mail.gmail.com>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
	<alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
	<CAAM7YA=xU+Ovxf-QU6ruRKGhWS88-d0UaX1AbcR9oCLbEi9_jg@mail.gmail.com>
	<alpine.DEB.2.11.1606011019090.6221@cpach.fuggernut.com>
	<CAAM7YAmzpqAoh0TuVj0zCXPgrM=0BjfbwD+C3rJa=0CKwmRhAA@mail.gmail.com>
	<CAOi1vP9UxJfOoN=DM+Wsf4kTdHideNN_usygw2GKVkzLtSwFrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36297 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbcFBJuI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 05:50:08 -0400
Received: by mail-vk0-f65.google.com with SMTP id c189so7512620vkb.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 02:50:07 -0700 (PDT)
In-Reply-To: <CAOi1vP9UxJfOoN=DM+Wsf4kTdHideNN_usygw2GKVkzLtSwFrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, James Webb <jamesw@unity3d.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Thu, Jun 2, 2016 at 5:13 PM, Ilya Dryomov <idryomov@gmail.com> wrote=
:
> On Thu, Jun 2, 2016 at 4:46 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Wed, Jun 1, 2016 at 10:22 PM, Sage Weil <sage@newdream.net> wrote=
:
>>> On Wed, 1 Jun 2016, Yan, Zheng wrote:
>>>> On Wed, Jun 1, 2016 at 8:49 PM, Sage Weil <sage@newdream.net> wrot=
e:
>>>> > On Wed, 1 Jun 2016, Yan, Zheng wrote:
>>>> >> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw@unity3d.com>=
 wrote:
>>>> >> > Dear ceph-users...
>>>> >> >
>>>> >> > My team runs an internal buildfarm using ceph as a backend st=
orage platform. We=E2=80=99ve recently upgraded to Jewel and are having=
 reliability issues that we need some help with.
>>>> >> >
>>>> >> > Our infrastructure is the following:
>>>> >> > - We use CEPH/CEPHFS (10.2.1)
>>>> >> > - We have 3 mons and 6 storage servers with a total of 36 OSD=
s (~4160 PGs).
>>>> >> > - We use enterprise SSDs for everything including journals
>>>> >> > - We have one main mds and one standby mds.
>>>> >> > - We are using ceph kernel client to mount cephfs.
>>>> >> > - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
>>>> >> > - We are using a kernel NFS to serve NFS clients from a ceph =
mount (~ 32 nfs threads. 0 swappiness)
>>>> >> > - These are physical machines with 8 cores & 32GB memory
>>>> >> >
>>>> >> > On a regular basis, we lose all IO via ceph FS. We=E2=80=99re=
 still trying to isolate the issue but it surfaces as an issue between =
MDS and ceph client.
>>>> >> > We can=E2=80=99t tell if our our NFS server is overwhelming t=
he MDS or if this is some unrelated issue. Tuning NFS server has not so=
lved our issues.
>>>> >> > So far our only recovery has been to fail the MDS and then re=
start our NFS. Any help or advice will be appreciated on the CEPH side =
of things.
>>>> >> > I=E2=80=99m pretty sure we=E2=80=99re running with default tu=
ning of CEPH MDS configuration parameters.
>>>> >> >
>>>> >> >
>>>> >> > Here are the relevant log entries.
>>>> >> >
>>>> >> > From my primary MDS server, I start seeing these entries star=
t to pile up:
>>>> >> >
>>>> >> > 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluste=
r) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), =
ino 10000004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63=
=2E877480 seconds ago\
>>>> >> > 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluste=
r) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), =
ino 10000005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63=
=2E877382 seconds ago\
>>>> >> > 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluste=
r) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), =
ino 10000000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63=
=2E877356 seconds ago
>>>> >> >
>>>> >> > From my NFS server, I see these entries from dmesg also start=
 piling up:
>>>> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6=
800 seq 0 expected 4294967296
>>>> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6=
800 seq 1 expected 4294967296
>>>> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6=
800 seq 2 expected 4294967296
>>>> >> >
>>>> >>
>>>> >> 4294967296 is 0x100000000, this looks like sequence  overflow.
>>>> >>
>>>> >> In src/msg/Message.h:
>>>> >>
>>>> >> class Message {
>>>> >> ...
>>>> >>   unsigned get_seq() const { return header.seq; }
>>>> >>   void set_seq(unsigned s) { header.seq =3D s; }
>>>> >> ...
>>>> >> }
>>>> >>
>>>> >> in src/msg/simple/Pipe.cc
>>>> >>
>>>> >> class Pipe {
>>>> >> ...
>>>> >>   __u32 get_out_seq() { return out_seq; }
>>>> >> ...
>>>> >> }
>>>> >>
>>>> >> Is this bug or intentional ?
>>>> >
>>>> > That's a bug.  The seq values are intended to be 32 bits.
>>>> >
>>>> > (We should also be using the ceph_cmp_seq (IIRC) helper for any =
inequality
>>>> > checks, which does a sloppy comparison so that a 31-bit signed d=
ifference
>>>> > is used to determine > or <.  It sounds like in this case we're =
just
>>>> > failing an equality check, though.)
>>>> >
>>>>
>>>> struct ceph_msg_header {
>>>>         __le64 seq;       /* message seq# for this session */
>>>>         ...
>>>> }
>>>>
>>>> you means we should leave the upper 32-bits unused?
>>>
>>> Oh, hmm. I'm confusing this with the cap seq (which is 32 bits).
>>>
>>> I think we can safely go either way.. the question is which path is
>>> easier.  If we move to 32 bits used on the kernel side, will usersp=
ace
>>> also need to be patched to make reconnect work?  That unsigned get_=
seq()
>>> is only 32-bits wide.
>>
>> I don't think userspace need to be patched.
>>
>>>
>>> If we go with 64 bits, userspace still needs to be fixed to change =
that
>>> unsigned to uint64_t.
>>>
>>> What do you think?
>>> sage
>>>
>>
>> I like the 64 bits approach. Here is userspace code that checks
>> message sequence.
>>
>> Pipe::reader() {
>>
>> ...
>>       if (m->get_seq() <=3D in_seq) {
>>         ldout(msgr->cct,0) << "reader got old message "
>>                 << m->get_seq() << " <=3D " << in_seq << " " << m <<=
 " " << *m
>>                 << ", discarding" << dendl;
>>
>>         msgr->dispatch_throttle_release(m->get_dispatch_throttle_siz=
e());
>>         m->put();
>>
>>         if (connection_state->has_feature(CEPH_FEATURE_RECONNECT_SEQ=
) &&
>>             msgr->cct->_conf->ms_die_on_old_message)
>>           assert(0 =3D=3D "old msgs despite reconnect_seq feature");
>>         continue;
>>       }
>>       if (m->get_seq() > in_seq + 1) {
>>         ldout(msgr->cct,0) << "reader missed message?  skipped from =
seq "
>>                            << in_seq << " to " << m->get_seq() << de=
ndl;
>>         if (msgr->cct->_conf->ms_die_on_skipped_message)
>>           assert(0 =3D=3D "skipped incoming seq");
>>       }
>>       m->set_connection(connection_state.get());
>>       // note last received message.
>>       in_seq =3D m->get_seq();
>> ...
>> }
>>
>> Looks like the code works perfectly when the two ends of connection
>> have different bits. We don't need to worry about the change breaks
>> interoperability between patched userspace and un-patched userspace.
>
> Are you sure?  It seems to me that if that were true, we wouldn't hav=
e
> this thread in the first place.  An unpatched m->get_seq() in
>
>     if (m->get_seq() <=3D in_seq) {
>
> would truncate and the "old message" branch would be taken.  The same
> goes for the unpatched m->set_seq() - the other (patched) side is goi=
ng
> to trip over.

The user space code never increates in_seq. Instead it assigns
m->get_seq() to in_seq. If m->get_seq() return 32-bits value, the
upper 32-bits of in_seq are always zero.

I did some tests (set the initial value of out_seq to 0xffffff00) . It
seems that the user space code also starts to malfunction when the seq
overflows. There is code compares
{newly_acked_seq, out_seq}, {in_seq, in_seq_acked}, but it does not
take the overflow into consideration.

Besides, I found that Pipe::randomize_out_seq() never randomizes the ou=
t_seq.

Regards
Yan, Zheng

>
> Thanks,
>
>                 Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
