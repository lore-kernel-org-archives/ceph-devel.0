From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Mon, 11 Oct 2010 09:40:20 -0700
Message-ID: <AANLkTinieBbzew5rkmu0640XZbJ+x-wFe-+2H8otnDT3@mail.gmail.com>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	<Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	<AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	<AANLkTimrKDCCDHqYEb9CBhUoYO+OpKJe2Ohdyt65MxU=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63324 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab0JKQkV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Oct 2010 12:40:21 -0400
Received: by fxm4 with SMTP id 4so541877fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Oct 2010 09:40:20 -0700 (PDT)
In-Reply-To: <AANLkTimrKDCCDHqYEb9CBhUoYO+OpKJe2Ohdyt65MxU=@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

On Sun, Oct 10, 2010 at 4:49 PM, DongJin Lee <dongjin.lee@auckland.ac.n=
z> wrote:
> make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-g=
eneric'
> =A0INSTALL /home/aaa/ceph/ceph-client-standalone/ceph.ko
> =A0DEPMOD =A02.6.35-02063507-generic
> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-ge=
neric'
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo depmod
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo modprobe ceph
> aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
> ceph =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0228785 =A00
> libcrc32c =A0 =A0 =A0 =A0 =A0 =A0 =A0 1300 =A02 ceph,btrfs
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
> 192.168.1.2:/ /media/ceph
> failed to parse ceph_options
>
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo rmmod ceph
> aaa@ss1:~/ceph/ceph-client-standalone$ lsmod | grep ceph
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
> 192.168.1.2:/ /media/ceph
> failed to parse ceph_options
>
> Again, now nothing works :( everything I do I get 'failed to parse ce=
ph_options'
>

Hi Dongjin,

There was a bug where not supplying any options to mount.ceph caused
this error message to be displayed. I can see here that you are not
supplying any optinos (using -o) so you are probably hitting this bug.

This should be fixed by commit
566292a5871686e612b30bee58481db489b27bfb. Try checking out the latest
in unstable and this will be resolved.

regards,
Colin McCabe
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
