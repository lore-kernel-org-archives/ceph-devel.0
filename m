From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Problem in building Ceph on CentOS 6
Date: Wed, 21 Mar 2012 09:37:41 -0700
Message-ID: <3779DB66B05F4499814F1FE63B5D81E1@dreamhost.com>
References: <CALwGbPKfZSBGoTQT+3+3iDv4Bqt2orUTDahc6reObdnLq1cdsw@mail.gmail.com>
 <2588ED1D12494B3EAD14CAD5D6787E9E@dreamhost.com>
 <CALwGbP+_vv1iuuq8dZNafaPcjPZ0qPYH8UoKR3X-tsQvCRXx4A@mail.gmail.com>
 <5A266BFABB6F4473AFCE93EC765D8337@dreamhost.com>
 <CALwGbP+5ZQDObh8WdsT2-ABKOaKOS9YE1hPdsKpGEMhrwvuC5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63985 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136Ab2CUQho convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 12:37:44 -0400
Received: by yenl12 with SMTP id l12so1096800yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 09:37:44 -0700 (PDT)
In-Reply-To: <CALwGbP+5ZQDObh8WdsT2-ABKOaKOS9YE1hPdsKpGEMhrwvuC5Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?=E8=83=A1=E7=80=9A=E6=A3=AE?= <softrank.net@gmail.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

I'm not sure what you mean here. Building software never installs confi=
g files unless you're doing an install as well... =20


On Tuesday, March 20, 2012 at 11:20 PM, =E8=83=A1=E7=80=9A=E6=A3=AE wro=
te:

> I've successfully built ceph, but why can't I see config files?
> No files in /usr/local/etc/ceph, and no ceph folder under /etc either=
=2E
> =20
> On Tue, Mar 20, 2012 at 3:52 PM, Greg Farnum
> <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> =
wrote:
> > You should keep discussion on the list...I think you want to say ye=
s to all of those, but I'm actually not sure! :)
> > =20
> > =20
> > On Tuesday, March 20, 2012 at 12:20 AM, =E8=83=A1=E7=80=9A=E6=A3=AE=
 wrote:
> > =20
> > > Thank you Greg.
> > > Should I tick on the following options before compiling to enable
> > > ceph? Are there any other options should I enable?
> > > =20
> > > Use in-kernel support for DNS lookup (CEPH_LIB_USE_DNS_RESOLVER)
> > > Ceph core library (EXPERIMENTAL) (CEPH_LIB)
> > > Include file:line in ceph debug output (CEPH_LIB_PRETTYDEBUG)
> > > Ceph distributed file system (EXPERIMENTAL) (CEPH_FS)
> > > =20
> > > =20
> > > On Tue, Mar 20, 2012 at 2:35 PM, Greg Farnum
> > > <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.co=
m)> wrote:
> > > > On Monday, March 19, 2012 at 11:21 PM, =E8=83=A1=E7=80=9A=E6=A3=
=AE wrote:
> > > > > Hello everyone.
> > > > > =20
> > > > > I'm following the steps in
> > > > > http://ceph.newdream.net/wiki/Building_kernel_client?TPSecNot=
ice&TPNotCheck
> > > > > to build ceph on my CentOS.
> > > > > =20
> > > > > I've updated my kernel to version 3.2.12 without selecting an=
y ceph
> > > > > related configuration options. Then I follow these steps unti=
l "$ make
> > > > > -C ceph".
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > If you're using such a new kernel version, why not just the bui=
lt-in version of Ceph?
> > > > =20
> > > > If you don't want to do that, what branch are you attempting to=
 build from? What's the most recent patch?
> > > > The backports etc stuff isn't real well-maintained right now bu=
t this and the build error should let our kernel devs figure out what's=
 going on.
> > > > -Greg
> > > > =20
> > > > > =20
> > > > > I get the following error message.
> > > > > =20
> > > > > =20
> > > > > > [deltamaster@localhost ceph-client-standalone]$ sudo make -=
C ceph
> > > > > > make: Entering directory `/home/deltamaster/ceph-client-sta=
ndalone/ceph'
> > > > > > make -C /lib/modules/3.2.12/build M=3D/home/deltamaster/cep=
h-client-standalone/ceph CONFIG_CEPH_FS=3Dm modules
> > > > > > make[1]: Entering directory `/usr/src/linux-3.2.12'
> > > > > > CC [M] /home/deltamaster/ceph-client-standalone/ceph/inode.=
o
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c:95: w=
arning: initialization from incompatible pointer type
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c: In f=
unction =E2=80=98fill_inode=E2=80=99:
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c:623: =
error: assignment of read-only member =E2=80=98i_nlink=E2=80=99
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c: In f=
unction =E2=80=98ceph_permission=E2=80=99:
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810:=
 error: =E2=80=98IPERM_FLAG_RCU=E2=80=99 undeclared (first use in this =
function)
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810:=
 error: (Each undeclared identifier is reported only once
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810:=
 error: for each function it appears in.)
> > > > > > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1816:=
 error: too many arguments to function =E2=80=98generic_permission=E2=80=
=99
> > > > > > make[2]: *** [/home/deltamaster/ceph-client-standalone/ceph=
/inode.o] Error 1
> > > > > > make[1]: *** [_module_/home/deltamaster/ceph-client-standal=
one/ceph] Error 2
> > > > > > make[1]: Leaving directory `/usr/src/linux-3.2.12'
> > > > > > make: *** [all] Error 2
> > > > > > make: Leaving directory `/home/deltamaster/ceph-client-stan=
dalone/ceph'
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > I've no idea how to solve this.
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
> > > > > the body of a message to majordomo@vger.kernel.org (mailto:ma=
jordomo@vger.kernel.org)
> > > > > More majordomo info at http://vger.kernel.org/majordomo-info.=
html
> > > > =20
> > > =20
> > =20
> =20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
