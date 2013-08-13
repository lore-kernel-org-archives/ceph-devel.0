From: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Tue, 13 Aug 2013 16:59:55 +0200
Message-ID: <520A49EB.9090301@gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <20130419064524.GQ11427@reaktio.net> <6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au> <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au> <CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au> <CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B63891798@BITCOM1.int.sbss.com.au> <CAF6-1L4=rY7AJpHGB33KPMk6LfX7q8CHphPzh9amdqwbYzg3dQ@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B6389552A@BITCOM1.int.sbss.com.au> <CAF
 6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55197 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344Ab3HMO76 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 10:59:58 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so738950wiw.17
        for <ceph-devel@vger.kernel.org>; Tue, 13 Aug 2013 07:59:56 -0700 (PDT)
In-Reply-To: <CAF6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: James Harper <james.harper@bendigoit.com.au>, =?ISO-8859-1?Q?Pasi_K?= =?ISO-8859-1?Q?=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>


Hi,

I have been testing this a while now, and just finished testing your 
untested patch. The rbd caching problem still persists.

The system I am testing on has the following characteristics:

Dom0:
     - Linux xen-001 3.2.0-4-amd64 #1 SMP Debian 3.2.46-1 x86_64
     - Most recent git checkout of blktap rbd branch

DomU:
     - Same kernel as dom0
     - Root (xvda1) is a logical volume on dom0
     - xvda2 is a Rados Block Device format 1

Let me start by saying that the errors only occur with RBD client 
caching ON.
I will give the error messages of both dom0 and domU before and after I 
applied the patch.

Actions in domU to trigger errors:

~# mkfs.xfs -f /dev/xvda2
~# mount /dev/xvda2 /mnt
~# bonnie -u 0 -g 0 /mnt


Error messages:

BEFORE patch:

Without RBD cache:

dom0: no errors
domU: no errors

With RBD cache:

dom0: no errors

domU:
Aug 13 18:18:33 debian-vm-101 kernel: [   37.960475] lost page write due 
to I/O error on xvda2
Aug 13 18:18:33 debian-vm-101 kernel: [   37.960488] lost page write due 
to I/O error on xvda2
Aug 13 18:18:33 debian-vm-101 kernel: [   37.960501] lost page write due 
to I/O error on xvda2
...
Aug 13 18:18:52 debian-vm-101 kernel: [   56.394645] XFS (xvda2): 
xfs_do_force_shutdown(0x2) called from line 1007 of file 
/build/linux-s5x2oE/linux-3.2.46/fs/xfs/xfs_log.c.  Return address = 
0xffffffffa013ced5
Aug 13 18:19:19 debian-vm-101 kernel: [   83.941539] XFS (xvda2): 
xfs_log_force: error 5 returned.
Aug 13 18:19:19 debian-vm-101 kernel: [   83.941565] XFS (xvda2): 
xfs_log_force: error 5 returned.
...

AFTER patch:

Without RBD cache:

dom0: no errors
domU: no errors

With RBD cache:

dom0:
Aug 13 16:40:49 xen-001 kernel: [   94.954734] tapdisk[3075]: segfault 
at 7f749ee86da0 ip 00007f749d060776 sp 00007f748ea7a460 error 7 in 
libpthread-2.13.so[7f749d059000+17000]


domU:
Same as before patch.



I would like to add that I have the time to test this, we are happy to 
help you in any way possible. However, since I am no C developer, I 
won't be able to do much more than testing.


Regards

Frederik


On 13-08-13 11:20, Sylvain Munaut wrote:
> Hi,
>
>> I hope not. How could I tell? It's not something I've explicitly enabled.
> It's disabled by default.
>
> So you'd have to have enabled it either in ceph.conf  or directly in
> the device path in the xen config. (option is 'rbd cache',
> http://ceph.com/docs/next/rbd/rbd-config-ref/ )
>
> Cheers,
>
>      Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

