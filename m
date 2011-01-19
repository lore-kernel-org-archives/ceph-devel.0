From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cephfs set_layout on filesystem root?
Date: Wed, 19 Jan 2011 09:34:08 -0800
Message-ID: <AANLkTimZ_=WxGPJUcAM0LOwxazXj3nVgNvQSCqRFOk9k@mail.gmail.com>
References: <1295455606.6777.23.camel@sale659.sandia.gov>
	<AANLkTi=LNa0AyiT4UfyrJLQrUCrPDACBocsiQV=yw7GQ@mail.gmail.com>
	<1295457888.6777.33.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59987 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1ASReN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 12:34:13 -0500
Received: by eye27 with SMTP id 27so583791eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 09:34:11 -0800 (PST)
In-Reply-To: <1295457888.6777.33.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 19, 2011 at 9:24 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi Greg,
>
> On Wed, 2011-01-19 at 10:00 -0700, Gregory Farnum wrote:
>> On Wed, Jan 19, 2011 at 8:46 AM, Jim Schutt <jaschut@sandia.gov> wro=
te:
>> > Hi,
>> >
>> > I've been experimenting with using cephfs to set
>> > the object/stripe size on a Ceph filesystem root,
>> > and it seems to not persist across a filesystem
>> > restart. =A0Is that expected behavior?
>> > ...
>> > Am I missing something?
>> Hmmm, not that I see. It should definitely be a persistent setting.
>>
>> <debug_mode>
>> Have you tried this on non-root directories, and were results the sa=
me
>> or different?
>> </debug_mode>
>> -Greg
>>
>
> I tried to test this, but got this instead after
> restarting my filesystem:
>
> 2011-01-19 10:16:31.073571 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 47/47/9) [41] r=3D0 mlcod 0'0 !hml degraded] clear_pr=
ior
> 2011-01-19 10:16:31.073584 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml degraded] notin=
g past interval(47-47 [41]/[41])
> 2011-01-19 10:16:31.073598 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml degraded] cance=
l_recovery
> 2011-01-19 10:16:31.073610 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml degraded] clear=
_recovery_state
> 2011-01-19 10:16:31.073623 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml inactive] clear=
_primary_state
> 2011-01-19 10:16:31.073653 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml inactive] clear=
_prior
> 2011-01-19 10:16:31.073668 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml inactive] up [4=
1] -> [41,53], acting [41] -> [41,53], role 0 -> 0
> 2011-01-19 10:16:31.073681 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml inactive] on_ch=
ange
> 2011-01-19 10:16:31.073783 7f318f7fe940 osd41 48 pg[3.62f( empty n=3D=
0 ec=3D2 les=3D18 48/48/9) [41,53] r=3D0 mlcod 0'0 !hml inactive] [41] =
-> [41,53], replicas changed
> 2011-01-19 10:16:31.092006 7f318f7fe940 osd41 48 write_superblock sb(=
01d356fc-7539-8c8d-7e49-8a2f42242802 osd41 e48 [1,48] lci=3D[9,23])
> os/FileStore.cc: In function 'void FileStore::sync_entry()':
> os/FileStore.cc:2309: FAILED assert(r =3D=3D 0)
> =A0ceph version 0.24.1 (commit:6152f5227d1ab177230211b6d25e62d6094e26=
e6)
> =A01: (FileStore::sync_entry()+0x25d9) [0x5a79a9]
> =A02: (FileStore::SyncThread::entry()+0xd) [0x522b7d]
> =A03: (Thread::_entry_func(void*)+0x7) [0x48a467]
> =A04: /lib64/libpthread.so.0 [0x7f319d05c73d]
> =A05: (clone()+0x6d) [0x7f319bf72f6d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
>
> ---
>
> So the sequence of events was:
> - create new file system, start, mount
> - create a directory, change its object/stripe sizes (to 512 KiB)
> - unmount, shut down filesystem, restart
> =A0=3D=3D> osd assert.
Okay, this is probably unrelated to your attempt to change non-root
dir layouts. (It's in the OSD, which just isn't going to care at all
about metadata changes.) Can you gather up the debug info for that and
file a bug report?

I'll work on reproducing the dir layout issue here shortly (shouldn't
be hard) and let you know what I come up with. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
