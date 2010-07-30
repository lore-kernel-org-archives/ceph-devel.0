From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: /sys/class/rbd does not exist after loading ceph module
Date: Fri, 30 Jul 2010 21:17:04 +0800
Message-ID: <AANLkTimrYZQmLbHO=CU1yPLDT_MxpFxq=Cs0sF1x70+Z@mail.gmail.com>
References: <AANLkTi=r74Q3SBS71+QcditFhNxzUfdCf1F9F18R4Yiy@mail.gmail.com>
	<AANLkTikOViq3VCY2fwtut1c1kU8dkM7pRRwqfrYyhEPL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49147 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650Ab0G3NRG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 09:17:06 -0400
Received: by ewy23 with SMTP id 23so614586ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 06:17:05 -0700 (PDT)
In-Reply-To: <AANLkTikOViq3VCY2fwtut1c1kU8dkM7pRRwqfrYyhEPL@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I though all ceph client, including RBD, was already included in
kernel 2.6.34. so I just download it from kernel.org and compile it,
like make menuconfig, make, make modues_install etc.

Do you mean that I still need patch kernel 2.6.34 and build the new cep=
h.ko?


> I would like to try the RBD feature of Ceph. I am following
> http://ceph.newdream.net/wiki/Rbd,=E8=81=BD but failed at :

* did you really compile the ceph.ko module from source?
* did you verify that you actually loaded the right ceph.ko module and
not stock ceph.ko?

general note: do use the new 0.21. you won't get happy with 0.20.2.

- Thomas


On Fri, Jul 30, 2010 at 4:41 PM, Xiaoguang Liu <syslxg@gmail.com> wrote=
:
> =C2=A0I would like to try the RBD feature of Ceph. I am following
> http://ceph.newdream.net/wiki/Rbd,=C2=A0 but failed at :
>
> =C2=A0echo "xxx name=3Dadmin rbd foo" > /sys/class/rbd/add
>
>
> =C2=A0It was because folder /sys/class/rbd does not exist. But ceph k=
ernel
> module is loaded and I can mount -t ceph xxxx:/ /mnt/ceph.
>
> =C2=A0I am using kernel 2.6.34.1 on fedora 13.
>
> =C2=A0the following symbols are set in .config while compiling the ke=
rnel.
>
> =C2=A0CONFIG_CEPH_FS=3Dm
> =C2=A0CONFIG_CEPH_FS_PRETTYDEBUG=3Dy
>
> =C2=A0Ceph 0.20.2 is installed by yum.
>
> =C2=A0Did I miss anything?
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
