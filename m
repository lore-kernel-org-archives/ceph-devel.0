From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 17/46] fs: Use rename lock and RCU for multi-step operations
Date: Mon, 7 Feb 2011 13:04:46 -0800
Message-ID: <AANLkTinhfZcr-Mz2jAZodSrH-914D7iJREmVSD-i8Fb-@mail.gmail.com>
References: <cover.1290852958.git.npiggin@kernel.dk>
	<d44ddcf1d1e0813b3ce2b3872c7c702a31b62894.1290852959.git.npiggin@kernel.dk>
	<AANLkTi=pj-pLYVSrU+6+BtioCWLod2ueZecNaap619fw@mail.gmail.com>
	<AANLkTik3ScP5rvR2bOXOEEH8SNZGg+xO6Gy32CW3XmU6@mail.gmail.com>
	<AANLkTinVP=OuJ-3u9pHdDuuKJoVrP4Unr5Dx1x=qHtXC@mail.gmail.com>
	<AANLkTimUjC8B0=nn5+yDshzp0hy6Zk1wxYHWEZbk83Tf@mail.gmail.com>
	<AANLkTi=or1Ya21Am8Dr4KVHgqkwvNxFwgn407=wxRfVa@mail.gmail.com>
	<AANLkTinmaojfNDYk1i4jMP33MmEQDur9XZvFp=qhV01e@mail.gmail.com>
	<1297104732.15475.60.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51185 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab1BGVEs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 16:04:48 -0500
In-Reply-To: <1297104732.15475.60.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Nick Piggin <npiggin@gmail.com>, Nick Piggin <npiggin@kernel.dk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 7, 2011 at 10:52 AM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> On Wed, 2011-01-26 at 22:18 -0700, Nick Piggin wrote:
>> On Wed, Jan 26, 2011 at 9:10 AM, Yehuda Sadeh Weinraub
>> <yehudasa@gmail.com> wrote:
>> > On Wed, Jan 19, 2011 at 2:32 PM, Nick Piggin <npiggin@gmail.com> w=
rote:
>> >> On Thu, Jan 20, 2011 at 9:27 AM, Yehuda Sadeh Weinraub
>> >> <yehudasa@gmail.com> wrote:
>> >>> On Tue, Jan 18, 2011 at 2:42 PM, Nick Piggin <npiggin@gmail.com>=
 wrote:
>> >>>> On Wed, Jan 19, 2011 at 9:32 AM, Yehuda Sadeh Weinraub
>> >>>
>> >>>>> There's an issue with ceph as it references the
>> >>>>> dentry->d_parent(->d_inode) at dentry_release(), so setting
>> >>>>> dentry->d_parent to NULL here doesn't work with ceph. Though t=
here is
>> >>>>> some workaround for it, we would like to be sure that this one=
 is
>> >>>>> really required so that we don't exacerbate the ugliness. The
>> >>>>> workaround is to keep a pointer to the parent inode in the pri=
vate
>> >>>>> dentry structure, which will be referenced only at the .releas=
e()
>> >>>>> callback. This is clearly not ideal.
>> >>>>
>> >>>> Hmm, I'll have to think about it. Probably we can check for
>> >>>> d_count =3D=3D 0 rather than parent !=3D NULL I think?
>> >>>>
>> >>>
>> >>> That'll solve ceph's problem, don't know about how'd affect othe=
r
>> >>> stuff. We'll need to know whether this is the solution, or wheth=
er
>> >>> we'd need to introduce some other band aid fix.
>> >>
>> >> No I think it will work fine. Basically we just need to know whet=
her
>> >> we have been deleted, and if so then we restart rather than walki=
ng
>> >> back up the parent.
>> >>
>> >> I'll send a patch in a few days. For the meantime, it's a rathe
>> >> small window for ceph to worry about. So we'll have something
>> >> before -rc2 which should be OK.
>> >>
>> >
>> > I guess that it's a bit late for -rc2, should we assume that it'll=
 be on -rc3?
>>
>> Yeah, I'm sorry I've been travelling and a bit disconnected.
>>
>> NFS folk are having a similar problem and looks like similar
>> proposed fix will do it.
>>
>> http://marc.info/?l=3Dlinux-fsdevel&m=3D129599823927039&w=3D2
>>
>> So I think it is the best way to go to restore behaviour back to wha=
t
>> filesystems already expect, to avoid more surprises in future.
>
> I think the following BUG indicates I'm hitting this problem?
> All I have to do to cause it is unlink a file.
>
> My ceph client kernel is 8dbdea8444 (master branch) from
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.g=
it
> + e41cdbb6c5 (master branch) + a3f5274e53 (unstable branch)
> =A0from git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-clien=
t.git
>
> Are there any patches available for this I can test?
>
> Thanks -- Jim
>

It does look like this specific problem.
You can try cherry-pick commit 9c3db35 off the ceph git. It is just a
temporary workaround, and it wasn't tested too much. Hopefully Nick
will push his fix soon so that it wouldn't be needed.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
