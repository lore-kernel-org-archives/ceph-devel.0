From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: build ceph-client failed
Date: Mon, 2 Aug 2010 16:14:32 +0800
Message-ID: <AANLkTi=8ANiN=rELL9wi35rFK-0aSLxWD69HQcbjZcs8@mail.gmail.com>
References: <AANLkTi=QFSR9X9OrcrtzJwbWtFdY4VkQV0PePZ_Jm3Fq@mail.gmail.com>
	<AANLkTiktTXsKM=VoC=jgjd_zf8FEXy-d1ijyhvBDqeFP@mail.gmail.com>
	<AANLkTinJ7LkQFVOd9k2OKyb6SNEjkECD9AW6Erjko+DK@mail.gmail.com>
	<1280735375.1999.2.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54593 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab0HBIOf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 04:14:35 -0400
Received: by qwh6 with SMTP id 6so1332355qwh.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 01:14:34 -0700 (PDT)
In-Reply-To: <1280735375.1999.2.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

I finally get it work.

under stock kernel 2.6.33, I checkout the rbd branch, compile the
whole kernel 2.6.35 under ceph-client/ by make menuconfig && make &&
make modules_install && make install.

after boot from the new kernel, I can find /sys/class/rbd.

These were exactly what I did 4 hours ago, it looks like the rbd
branch had some problem at that time. (I saw 2.6.35rc3 during
menuconfig this mornig; Just now it was 2.6.35)

=46ollowing the wiki, I can see /dev/rbd0 now! But mkfs again it got
kernel crashed.

I guess it was becuase I was running ceph 0.20.2. I am about to compile=
 0.21.






On Mon, Aug 2, 2010 at 3:49 PM, Wido den Hollander <wido@widodh.nl> wro=
te:
> Hi Xiaoguang,
>
> No, the RBD code will only compile against 2.6.35, so your options ar=
e:
> * Get a 2.6.35 kernel for Fedora 13 somewhere and compile RBD against
> that
> * Compile a 2.6.35 kernel for your system
>
> If you choose this first, you only have to run "make" in fs/ceph (wit=
h
> ofcourse the right paramaters).
>
> I've updated the Wiki a bit, these was no reference of you having to
> chdir to fs/ceph
>
> Wido
>
> On Mon, 2010-08-02 at 13:41 +0800, Xiaoguang Liu wrote:
>> I do want to use the latest kernel. I am not sure if it is ok to
>> compile the checkouted RBD code on stock kernel 2.6.33, or I must
>> update the running kernel to 2.6.35 first?
>>
>> I found the checkout code was quite large, it should be a whole late=
st
>> kernel + RBD code. So Do I really have to upgrade the running kernel
>> first? I suppose after compiling the checkout code, I get a new kern=
el
>> and a new ceph.ko, as well as other modules, right?
>>
>>
>>
>> On Mon, Aug 2, 2010 at 12:00 PM, Gregory Farnum <gregf@hq.newdream.n=
et> wrote:
>> > I'm not sure about this specific error, but in general the ceph-cl=
ient
>> > code requires the very latest kernel release from Linus (ie, 2.6.3=
5
>> > now).
>> > For older kernels, you need to use the backports branches availabl=
e in
>> > http://git.kernel.org/?p=3Dlinux/kernel/git/sage/ceph-client-stand=
alone.git
>> >
>> > Right now the rbd branch doesn't have a backports equivalent, but =
you
>> > could try to checkout the unstable-backport and merge the rbd bran=
ch
>> > in and see if it works. Otherwise I believe the rbd branch will be
>> > merged into unstable very soon, so you shouldn't have long to wait=
=2E :)
>> > -Greg
>> >
>> > On Sun, Aug 1, 2010 at 8:52 PM, Xiaoguang Liu <syslxg@gmail.com> w=
rote:
>> >> I wanted to build RBD client. Following
>> >> http://ceph.newdream.net/wiki/Rbd, I check out the code by
>> >>
>> >> git clone git://ceph.newdream.net/git/ceph-client.git
>> >> cd ceph-client
>> >> git checkout -b rbd origin/rbd
>> >>
>> >> By the wiki, I should run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD"=
 next.
>> >> But "make" told me nothing to build because no ".config" found. s=
o I
>> >> did a "make menuconfig" first. (Glad to find the new symbol
>> >> CONFIG_CEPH_RBD).
>> >>
>> >> run make EXTRA_CFLAGS=3D"-DCONFIG_CEPH_RBD" again, make start com=
piling
>> >> and stop after a while with the error message below:
>> >>
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/test=
_nx.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/micr=
ocode_core.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/micr=
ocode_intel.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kernel/micr=
ocode_amd.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LD [M] =A0arch/x86/kernel/micr=
ocode.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LD =A0 =A0 =A0arch/x86/kvm/bui=
lt-in.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CC [M] =A0arch/x86/kvm/svm.o
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm=
/svm.c:18:
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:30:19: error: i=
odev.h: No such file or directory
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:31:20: error: i=
oapic.h: No such file or directory
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm=
/irq.h:32,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from arch/x86/kvm/svm.c:18:
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/lapic.h:11: error: fi=
eld a=80?deva=80? has incomplete type
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0In file included from arch/x86/kvm=
/svm.c:18:
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arch/x86/kvm/irq.h:73: error: fiel=
d a=80?deva=80? has incomplete type
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make[2]: *** [arch/x86/kvm/svm.o] =
Error 1
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make[1]: *** [arch/x86/kvm] Error =
2
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make: *** [arch/x86] Error 2
>> >>
>> >>
>> >> I can find iodev.h at ./virt/kvm/, why make can not find it? BTW,=
 I
>> >> did this on Fedora 13, stock kernel 2.6.33.3.
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >>
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
