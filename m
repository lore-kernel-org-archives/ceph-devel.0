From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: dkms client module
Date: Thu, 14 Apr 2011 09:44:09 -0700
Message-ID: <BANLkTinL3_Pyo9TRRhtoFa+bQfTjXv+dPQ@mail.gmail.com>
References: <4DA61E01.9050505@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36563 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab1DNQoK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 12:44:10 -0400
Received: by iwn34 with SMTP id 34so1565605iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 09:44:10 -0700 (PDT)
In-Reply-To: <4DA61E01.9050505@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 13, 2011 at 3:04 PM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
=2E..
> I got ceph-client-standalone from git and fixed the specific 2.6.32
> problems according to http://marc.info/?l=3Dceph-devel&m=3D1298130443=
00561&w=3D2 .
>
> Then I run into this:
>
> =A0./dkms/add-to-dkms-and-build
>
> =A0Creating symlink /var/lib/dkms/ceph/2.6.37/source ->
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /usr/src/ceph-2.6.37
>
> =A0DKMS: add Completed.
>
> =A0Kernel preparation unnecessary for this kernel. =A0Skipping...
>
> =A0Building module:
> =A0cleaning build area....
> =A0make KERNELRELEASE=3D2.6.32-71.24.1.el6.x86_64 -C ceph/....(bad ex=
it status: 2)
>
> =A0Error! Bad return status for module build on kernel: 2.6.32-71.24.=
1.el6.x86_64 (x86_64)
> =A0Consult the make.log in the build directory
> =A0/var/lib/dkms/ceph/2.6.37/build/ for more information.
> =A00
> =A00
>
> make.log says:
>
> =A0DKMS make.log for ceph-2.6.37 for kernel 2.6.32-71.24.1.el6.x86_64=
 (x86_64)
> =A0Wed Apr 13 23:47:41 CEST 2011
> =A0make: Entering directory `/var/lib/dkms/ceph/2.6.37/build/ceph'
> =A0make: *** No targets. =A0Stop.
> =A0make: Leaving directory `/var/lib/dkms/ceph/2.6.37/build/ceph'
>
> It seems to me there should be a Makefile in the root of ceph-client-=
standalone
> that points make to the Makefiles of the subdirectories, but I'm an i=
gnorant
> wrt to make, so I'm not sure about anything.
>

As the ceph-client-standalone provides 3 different modules (libceph,
ceph, rbd), you should probably try building it as 3 separate modules
and not as a single module. There isn't a single Makefile, and you
should treat ceph-client-standalone/libceph,
ceph-client-standalone/ceph and ceph-client-standalone/rbd as
standalone modules when building them.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
