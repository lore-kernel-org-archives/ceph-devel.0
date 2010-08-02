From: Wido den Hollander <wido@widodh.nl>
Subject: Re: build ceph-client failed
Date: Mon, 02 Aug 2010 09:49:35 +0200
Message-ID: <1280735375.1999.2.camel@wido-desktop>
References: <AANLkTi=QFSR9X9OrcrtzJwbWtFdY4VkQV0PePZ_Jm3Fq@mail.gmail.com>
	 <AANLkTiktTXsKM=VoC=jgjd_zf8FEXy-d1ijyhvBDqeFP@mail.gmail.com>
	 <AANLkTinJ7LkQFVOd9k2OKyb6SNEjkECD9AW6Erjko+DK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:35292 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab0HBHth (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 03:49:37 -0400
In-Reply-To: <AANLkTinJ7LkQFVOd9k2OKyb6SNEjkECD9AW6Erjko+DK@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Xiaoguang,

No, the RBD code will only compile against 2.6.35, so your options are:
* Get a 2.6.35 kernel for Fedora 13 somewhere and compile RBD against
that
* Compile a 2.6.35 kernel for your system

If you choose this first, you only have to run "make" in fs/ceph (with
ofcourse the right paramaters).

I've updated the Wiki a bit, these was no reference of you having to
chdir to fs/ceph

Wido

On Mon, 2010-08-02 at 13:41 +0800, Xiaoguang Liu wrote:
> I do want to use the latest kernel. I am not sure if it is ok to
> compile the checkouted RBD code on stock kernel 2.6.33, or I must
> update the running kernel to 2.6.35 first?
>=20
> I found the checkout code was quite large, it should be a whole lates=
t
> kernel + RBD code. So Do I really have to upgrade the running kernel
> first? I suppose after compiling the checkout code, I get a new kerne=
l
> and a new ceph.ko, as well as other modules, right?
>=20
>=20
>=20
> On Mon, Aug 2, 2010 at 12:00 PM, Gregory Farnum <gregf@hq.newdream.ne=
t> wrote:
> > I'm not sure about this specific error, but in general the ceph-cli=
ent
> > code requires the very latest kernel release from Linus (ie, 2.6.35
> > now).
> > For older kernels, you need to use the backports branches available=
 in
> > http://git.kernel.org/?p=3Dlinux/kernel/git/sage/ceph-client-standa=
lone.git
> >
> > Right now the rbd branch doesn't have a backports equivalent, but y=
ou
> > could try to checkout the unstable-backport and merge the rbd branc=
h
> > in and see if it works. Otherwise I believe the rbd branch will be
> > merged into unstable very soon, so you shouldn't have long to wait.=
 :)
> > -Greg
> >
> > On Sun, Aug 1, 2010 at 8:52 PM, Xiaoguang Liu <syslxg@gmail.com> wr=
ote:
> >> I wanted to build RBD client. Following
> >> http://ceph.newdream.net/wiki/Rbd, I check out the code by
> >>
> >> git clone git://ceph.newdream.net/git/ceph-client.git
> >> cd ceph-client
> >> git checkout -b rbd origin/rbd
> >>
> >> By the wiki, I should run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" =
next.
> >> But "make" told me nothing to build because no ".config" found. so=
 I
> >> did a "make menuconfig" first. (Glad to find the new symbol
> >> CONFIG_CEPH_RBD).
> >>
> >> run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" again, make start comp=
iling
> >> and stop after a while with the error message below:
> >>
> >>
> >>                  CC [M]  arch/x86/kernel/test_nx.o
> >>                  CC [M]  arch/x86/kernel/microcode_core.o
> >>                  CC [M]  arch/x86/kernel/microcode_intel.o
> >>                  CC [M]  arch/x86/kernel/microcode_amd.o
> >>                  LD [M]  arch/x86/kernel/microcode.o
> >>                  LD      arch/x86/kvm/built-in.o
> >>                  CC [M]  arch/x86/kvm/svm.o
> >>                In file included from arch/x86/kvm/svm.c:18:
> >>                arch/x86/kvm/irq.h:30:19: error: iodev.h: No such f=
ile or directory
> >>                arch/x86/kvm/irq.h:31:20: error: ioapic.h: No such =
file or directory
> >>                In file included from arch/x86/kvm/irq.h:32,
> >>                                                 from arch/x86/kvm/=
svm.c:18:
> >>                arch/x86/kvm/lapic.h:11: error: field a=E2=82=AC?de=
va=E2=82=AC? has incomplete type
> >>                In file included from arch/x86/kvm/svm.c:18:
> >>                arch/x86/kvm/irq.h:73: error: field a=E2=82=AC?deva=
=E2=82=AC? has incomplete type
> >>                make[2]: *** [arch/x86/kvm/svm.o] Error 1
> >>                make[1]: *** [arch/x86/kvm] Error 2
> >>                make: *** [arch/x86] Error 2
> >>
> >>
> >> I can find iodev.h at ./virt/kvm/, why make can not find it? BTW, =
I
> >> did this on Fedora 13, stock kernel 2.6.33.3.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
