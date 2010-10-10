From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Mon, 11 Oct 2010 12:49:19 +1300
Message-ID: <AANLkTimrKDCCDHqYEb9CBhUoYO+OpKJe2Ohdyt65MxU=@mail.gmail.com>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	<Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	<AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:31286 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0JJXt2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Oct 2010 19:49:28 -0400
Received: by vws2 with SMTP id 2so619837vws.19
        for <ceph-devel@vger.kernel.org>; Sun, 10 Oct 2010 16:49:19 -0700 (PDT)
In-Reply-To: <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Just to aid, below is the terminal output.

aaa@ss1:~/ceph/ceph-client-standalone$ make
make -C /lib/modules/2.6.35-02063507-generic/build
M=3D/home/aaa/ceph/ceph-client-standalone CONFIG_CEPH_FS=3Dm modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-gen=
eric'
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "account_page_dirtied"
[/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!
make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-gene=
ric'
aaa@ss1:~/ceph/ceph-client-standalone$ sudo make modules_install
make -C /lib/modules/2.6.35-02063507-generic/build
M=3D/home/aaa/ceph/ceph-client-standalone CONFIG_CEPH_FS=3Dm
modules_install
make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-gen=
eric'
  INSTALL /home/aaa/ceph/ceph-client-standalone/ceph.ko
  DEPMOD  2.6.35-02063507-generic
make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-gene=
ric'
aaa@ss1:~/ceph/ceph-client-standalone$ sudo depmod
aaa@ss1:~/ceph/ceph-client-standalone$ sudo modprobe ceph
aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
ceph                  228785  0
libcrc32c               1300  2 ceph,btrfs
aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
192.168.1.2:/ /media/ceph
failed to parse ceph_options

aaa@ss1:~/ceph/ceph-client-standalone$ sudo rmmod ceph
aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
192.168.1.2:/ /media/ceph
failed to parse ceph_options

Again, now nothing works :( everything I do I get 'failed to parse ceph=
_options'

Thanks

On Mon, Oct 11, 2010 at 12:06 PM, DongJin Lee
<dongjin.lee@auckland.ac.nz> wrote:
>> What kind of freezes? =A0Do they resolve themselves?
>> Anything in dmesg? =A0The client in 2.6.35 should work out of the bo=
x.
>
> It froze and nothing happened, I can't reproduce this anymore after I
> compiled the latest kclient
> When kclient is not loaded, i.e., lsmod doesn't show ceph, and I trie=
d
> to mount, I get this error
> "failed to parse ceph_options" I'm using 2.6.35.7 (the latest).
>
> I have used master-backport, but the make fails, it still complains a=
bout the
> WARNING: "account_page_dirtied"
> [/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!
>
> Again, the only thing that the 'make' work is the unstable-backport,
> I think something just went wrong, I keep getting the 'failed to pars=
e
> error'. dmesg doesn't show anything.
>
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
> 192.168.1.2:/ /media/ceph
> failed to parse ceph_options
>
> Thanks
>
>
>>> so I just git the latest ceph-client-standalone, set to the master =
and
>>> did the make. I get
>>>
>>> WARNING: "account_page_dirtied"
>>> [/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!
>>> =A0 LD [M] =A0/home/aaa/ceph/ceph-client-standalone/ceph.ko
>>> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-=
generic'
>>>
>>> So when I tried to modprobe ceph, I get
>>> FATAL: Error inserting ceph
>>> (/lib/modules/2.6.35-02063507-generic/extra/ceph.ko): Unknown symbo=
l
>>> in module, or unknown parameter (see dmesg)
>>>
>>> dmesg just shows "ceph: Unknown symbol account_page_dirtied (err 0)=
"
>>
>> This symbol was introduced for 2.6.36; you need master-backport.
>>
>>> For "unstable" branch, I get lots of errors starting from
>>>
>>> make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507=
-generic'
>>> =A0 CC [M] =A0/home/aaa/ceph/ceph-client-standalone/super.o
>>> /home/aaa/ceph/ceph-client-standalone/super.c:2:35: error:
>>> linux/ceph/ceph_debug.h: No such file or directory
>>> In file included from /home/aaa/ceph/ceph-client-standalone/super.c=
:18:
>>> /home/aaa/ceph/ceph-client-standalone/super.h:17:32: error:
>>> linux/ceph/libceph.h: No such file or directory
>>> In file included from /home/aaa/ceph/ceph-client-standalone/super.c=
:18:
>>> /home/aaa/ceph/ceph-client-standalone/super.h: In function ?ceph_pu=
t_cap_snap?:
>>> /home/aaa/ceph/ceph-client-standalone/super.h:153: error: implicit
>>> declaration of function ?ceph_buffer_put?
>>> /home/aaa/ceph/ceph-client-standalone/super.h: At top level:
>>> /home/aaa/ceph/ceph-client-standalone/super.h:234: error: field
>>> ?i_vino? has incomplete type
>>> ...
>>>
>>> unstable-backport is the only thing that seems to modprobed,
>>> however it gives "failed to parse ceph_options" when I tried to mou=
nt..
>>
>> You definitely need to use one of the -backport branches, unless you=
're
>> running on the latest kernel (the master and unstable branches don't
>> include any backport code). =A0The master-backport is probably the b=
est
>> choice, as unstable is in a bit of limbo pending the upcoming merge
>> window, rbd, and some reorganization of the code into mulitple modul=
es
>> (libceph, ceph, rbd).
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
