From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: build ceph-client failed
Date: Mon, 2 Aug 2010 13:41:38 +0800
Message-ID: <AANLkTinJ7LkQFVOd9k2OKyb6SNEjkECD9AW6Erjko+DK@mail.gmail.com>
References: <AANLkTi=QFSR9X9OrcrtzJwbWtFdY4VkQV0PePZ_Jm3Fq@mail.gmail.com>
	<AANLkTiktTXsKM=VoC=jgjd_zf8FEXy-d1ijyhvBDqeFP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56185 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab0HBFlj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 01:41:39 -0400
Received: by qyk8 with SMTP id 8so1349573qyk.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Aug 2010 22:41:38 -0700 (PDT)
In-Reply-To: <AANLkTiktTXsKM=VoC=jgjd_zf8FEXy-d1ijyhvBDqeFP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

I do want to use the latest kernel. I am not sure if it is ok to
compile the checkouted RBD code on stock kernel 2.6.33, or I must
update the running kernel to 2.6.35 first?

I found the checkout code was quite large, it should be a whole latest
kernel + RBD code. So Do I really have to upgrade the running kernel
first? I suppose after compiling the checkout code, I get a new kernel
and a new ceph.ko, as well as other modules, right?



On Mon, Aug 2, 2010 at 12:00 PM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
> I'm not sure about this specific error, but in general the ceph-clien=
t
> code requires the very latest kernel release from Linus (ie, 2.6.35
> now).
> For older kernels, you need to use the backports branches available i=
n
> http://git.kernel.org/?p=3Dlinux/kernel/git/sage/ceph-client-standalo=
ne.git
>
> Right now the rbd branch doesn't have a backports equivalent, but you
> could try to checkout the unstable-backport and merge the rbd branch
> in and see if it works. Otherwise I believe the rbd branch will be
> merged into unstable very soon, so you shouldn't have long to wait. :=
)
> -Greg
>
> On Sun, Aug 1, 2010 at 8:52 PM, Xiaoguang Liu <syslxg@gmail.com> wrot=
e:
>> I wanted to build RBD client. Following
>> http://ceph.newdream.net/wiki/Rbd, I check out the code by
>>
>> git clone git://ceph.newdream.net/git/ceph-client.git
>> cd ceph-client
>> git checkout -b rbd origin/rbd
>>
>> By the wiki, I should run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" ne=
xt.
>> But "make" told me nothing to build because no ".config" found. so I
>> did a "make menuconfig" first. (Glad to find the new symbol
>> CONFIG_CEPH_RBD).
>>
>> run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" again, make start compil=
ing
>> and stop after a while with the error message below:
>>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/test_nx=
=2Eo
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/microco=
de_core.o
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/microco=
de_intel.o
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/microco=
de_amd.o
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LD [M] =A0arch/x86/kernel/microco=
de.o
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LD =A0 =A0 =A0arch/x86/kvm/built-=
in.o
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kvm/svm.o
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm/sv=
m.c:18:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:30:19: error: iode=
v.h: No such file or directory
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:31:20: error: ioap=
ic.h: No such file or directory
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm/ir=
q.h:32,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 from arch/x86/kvm/svm.c:18:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/lapic.h:11: error: field=
 a=80?deva=80? has incomplete type
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm/sv=
m.c:18:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:73: error: field a=
=80?deva=80? has incomplete type
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make[2]: *** [arch/x86/kvm/svm.o] Err=
or 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make[1]: *** [arch/x86/kvm] Error 2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make: *** [arch/x86] Error 2
>>
>>
>> I can find iodev.h at ./virt/kvm/, why make can not find it? BTW, I
>> did this on Fedora 13, stock kernel 2.6.33.3.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
