From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cfuse abort on file delete (0.20.2)
Date: Sat, 29 May 2010 11:12:15 -0700
Message-ID: <AANLkTimAhwOSB0OcO1WTVQQmxvRHyNwUkGI2IHHwp4Dr@mail.gmail.com>
References: <hto39j$l6k$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57472 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0E2SMR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 May 2010 14:12:17 -0400
Received: by fxm10 with SMTP id 10so1450821fxm.19
        for <ceph-devel@vger.kernel.org>; Sat, 29 May 2010 11:12:16 -0700 (PDT)
In-Reply-To: <hto39j$l6k$4@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Thanks for the bug report!
If you pull the latest testing or unstable branch this should be fixed =
now.
-Greg

On Fri, May 28, 2010 at 2:44 AM, Thomas Mueller <thomas@chaschperli.ch>=
 wrote:
> hi
>
> saw the new version 0.20.2 and compiled it. now i'm able to create mo=
re than 3 10mb files. :)
>
> i created 10mb files for testing with
>
> # for i in $(seq 1 100); do =A0dd if=3D/dev/zero of=3Dtest${i} bs=3D1=
M count=3D10; done
>
> then tried to delete the files:
>
> # rm -f test*
>
> result (many):
> rm: cannot remove `test84': Transport endpoint is not connected
>
> see below for output of cfuse.
>
> with the following command i can reproduce the behavoiur:
>
> for i in $(seq 200 300); do =A0dd if=3D/dev/zero of=3Dtest${i} bs=3D1=
M count=3D10; done; rm -f test*;
>
> after restarting the cfuse mount I can successfully delete the files.
>
> - Thomas
>
> output of cfuse:
>
> # cfuse /mnt
> mounting ceph
> 10.05.28 11:31:35.633016 4193a940 monclient(hunting): found mon0
> starting fuse
> ceph_fuse_ll_main starting fuse on pid 18223
>
> ./include/xlist.h: In function 'xlist<T>::~xlist() [with T =3D Object=
Cacher::Object*]':
> ./include/xlist.h:63: FAILED assert(_size =3D=3D 0)
> =A01: (Client::put_inode(Inode*, int)+0x180) [0x48bec0]
> =A02: (Client::_ll_put(Inode*, int)+0x69) [0x48c059]
> =A03: (Client::ll_forget(vinodeno_t, int)+0x447) [0x48c5b7]
> =A04: cfuse [0x46af40]
> =A05: (fuse_session_loop()+0x75) [0x35bdc0ede5]
> =A06: (ceph_fuse_ll_main(Client*, int, char const**)+0x18c) [0x46979c=
]
> =A07: (main()+0x187) [0x44e3e7]
> =A08: (__libc_start_main()+0xf4) [0x3888c1d994]
> =A09: (__gxx_personality_v0()+0x1c1) [0x44e149]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
> ./include/xlist.h: In function 'xlist<T>::~xlist() [with T =3D Object=
Cacher::Object*]':
> ./include/xlist.h:63: FAILED assert(_size =3D=3D 0)
> =A01: (Client::put_inode(Inode*, int)+0x180) [0x48bec0]
> =A02: (Client::_ll_put(Inode*, int)+0x69) [0x48c059]
> =A03: (Client::ll_forget(vinodeno_t, int)+0x447) [0x48c5b7]
> =A04: cfuse [0x46af40]
> =A05: (fuse_session_loop()+0x75) [0x35bdc0ede5]
> =A06: (ceph_fuse_ll_main(Client*, int, char const**)+0x18c) [0x46979c=
]
> =A07: (main()+0x187) [0x44e3e7]
> =A08: (__libc_start_main()+0xf4) [0x3888c1d994]
> =A09: (__gxx_personality_v0()+0x1c1) [0x44e149]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion=
*'
> Aborted
>
>
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
