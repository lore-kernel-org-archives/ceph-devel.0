From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: build ceph-client failed
Date: Sun, 1 Aug 2010 21:00:44 -0700
Message-ID: <AANLkTiktTXsKM=VoC=jgjd_zf8FEXy-d1ijyhvBDqeFP@mail.gmail.com>
References: <AANLkTi=QFSR9X9OrcrtzJwbWtFdY4VkQV0PePZ_Jm3Fq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50720 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab0HBEAq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 00:00:46 -0400
Received: by wwj40 with SMTP id 40so3431587wwj.1
        for <ceph-devel@vger.kernel.org>; Sun, 01 Aug 2010 21:00:45 -0700 (PDT)
In-Reply-To: <AANLkTi=QFSR9X9OrcrtzJwbWtFdY4VkQV0PePZ_Jm3Fq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

I'm not sure about this specific error, but in general the ceph-client
code requires the very latest kernel release from Linus (ie, 2.6.35
now).
=46or older kernels, you need to use the backports branches available i=
n
http://git.kernel.org/?p=3Dlinux/kernel/git/sage/ceph-client-standalone=
=2Egit

Right now the rbd branch doesn't have a backports equivalent, but you
could try to checkout the unstable-backport and merge the rbd branch
in and see if it works. Otherwise I believe the rbd branch will be
merged into unstable very soon, so you shouldn't have long to wait. :)
-Greg

On Sun, Aug 1, 2010 at 8:52 PM, Xiaoguang Liu <syslxg@gmail.com> wrote:
> I wanted to build RBD client. Following
> http://ceph.newdream.net/wiki/Rbd, I check out the code by
>
> git clone git://ceph.newdream.net/git/ceph-client.git
> cd ceph-client
> git checkout -b rbd origin/rbd
>
> By the wiki, I should run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" nex=
t.
> But "make" told me nothing to build because no ".config" found. so I
> did a "make menuconfig" first. (Glad to find the new symbol
> CONFIG_CEPH_RBD).
>
> run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" again, make start compili=
ng
> and stop after a while with the error message below:
>
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/test_nx.=
o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/microcod=
e_core.o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/microcod=
e_intel.o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/microcod=
e_amd.o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LD [M] =A0arch/x86/kernel/microcod=
e.o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LD =A0 =A0 =A0arch/x86/kvm/built-i=
n.o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kvm/svm.o
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm/svm=
=2Ec:18:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:30:19: error: iodev=
=2Eh: No such file or directory
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:31:20: error: ioapi=
c.h: No such file or directory
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm/irq=
=2Eh:32,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 from arch/x86/kvm/svm.c:18:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/lapic.h:11: error: field =
a=80?deva=80? has incomplete type
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm/svm=
=2Ec:18:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:73: error: field a=80=
?deva=80? has incomplete type
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make[2]: *** [arch/x86/kvm/svm.o] Erro=
r 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make[1]: *** [arch/x86/kvm] Error 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make: *** [arch/x86] Error 2
>
>
> I can find iodev.h at ./virt/kvm/, why make can not find it? BTW, I
> did this on Fedora 13, stock kernel 2.6.33.3.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
