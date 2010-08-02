From: Xiaoguang Liu <syslxg@gmail.com>
Subject: build ceph-client failed
Date: Mon, 2 Aug 2010 11:52:29 +0800
Message-ID: <AANLkTi=QFSR9X9OrcrtzJwbWtFdY4VkQV0PePZ_Jm3Fq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57447 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0HBDwb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Aug 2010 23:52:31 -0400
Received: by qyk7 with SMTP id 7so5120542qyk.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Aug 2010 20:52:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I wanted to build RBD client. Following
http://ceph.newdream.net/wiki/Rbd, I check out the code by

git clone git://ceph.newdream.net/git/ceph-client.git
cd ceph-client
git checkout -b rbd origin/rbd

By the wiki, I should run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" next.
But "make" told me nothing to build because no ".config" found. so I
did a "make menuconfig" first. (Glad to find the new symbol
CONFIG_CEPH_RBD).

run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" again, make start compiling
and stop after a while with the error message below:


		  CC [M]  arch/x86/kernel/test_nx.o
		  CC [M]  arch/x86/kernel/microcode_core.o
		  CC [M]  arch/x86/kernel/microcode_intel.o
		  CC [M]  arch/x86/kernel/microcode_amd.o
		  LD [M]  arch/x86/kernel/microcode.o
		  LD      arch/x86/kvm/built-in.o
		  CC [M]  arch/x86/kvm/svm.o
		In file included from arch/x86/kvm/svm.c:18:
		arch/x86/kvm/irq.h:30:19: error: iodev.h: No such file or directory
		arch/x86/kvm/irq.h:31:20: error: ioapic.h: No such file or directory
		In file included from arch/x86/kvm/irq.h:32,
						 from arch/x86/kvm/svm.c:18:
		arch/x86/kvm/lapic.h:11: error: field a=80?deva=80? has incomplete ty=
pe
		In file included from arch/x86/kvm/svm.c:18:
		arch/x86/kvm/irq.h:73: error: field a=80?deva=80? has incomplete type
		make[2]: *** [arch/x86/kvm/svm.o] Error 1
		make[1]: *** [arch/x86/kvm] Error 2
		make: *** [arch/x86] Error 2


I can find iodev.h at ./virt/kvm/, why make can not find it? BTW, I
did this on Fedora 13, stock kernel 2.6.33.3.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
