From: David Zafman <david.zafman@inktank.com>
Subject: Re: [RFC] add rocksdb support
Date: Fri, 13 Jun 2014 17:49:01 -0700
Message-ID: <7D6D0D35-727C-4CBE-9D2E-E03E6EAF57CC@inktank.com>
References: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1405201814330.1689@cobra.newdream.net> <75674D092A819E4189E91166C74CB90D013BEDED@shsmsx102.ccr.corp.intel.com> <537CA4BA.4000900@inktank.com> <75674D092A819E4189E91166C74CB90D013C094D@shsmsx102.ccr.corp.intel.com> <5395EAD1.9000501@inktank.com> <75674D092A819E4189E91166C74CB90D013C3C13@shsmsx102.ccr.corp.intel.com> <B9FF37F8E2D7894A9493A5314D0816FC22609DCA@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33139 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410AbaFNAtJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jun 2014 20:49:09 -0400
Received: by mail-ob0-f180.google.com with SMTP id vb8so3560721obc.39
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jun 2014 17:49:08 -0700 (PDT)
In-Reply-To: <B9FF37F8E2D7894A9493A5314D0816FC22609DCA@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sushma Gurram <Sushma.Gurram@sandisk.com>
Cc: "Shu, Xinxin" <xinxin.shu@intel.com>, Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Zhang, Jian" <jian.zhang@intel.com>


Don=92t forget when a new submodule is added you need to initialize it.=
  From the README:

Building Ceph
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

To prepare the source tree after it has been git cloned,

        $ git submodule update --init

To build the server daemons, and FUSE client, execute the following:

        $ ./autogen.sh
        $ ./configure
        $ make


David Zafman
Senior Developer
http://www.inktank.com
http://www.redhat.com

On Jun 13, 2014, at 11:51 AM, Sushma Gurram <Sushma.Gurram@sandisk.com>=
 wrote:

> Hi Xinxin,
>=20
> I tried to compile the wip-rocksdb branch, but the src/rocksdb direct=
ory seems to be empty. Do I need toput autoconf/automake in this direct=
ory?
> It doesn't seem to have any other source files and compilation fails:
> os/RocksDBStore.cc:10:24: fatal error: rocksdb/db.h: No such file or =
directory
> compilation terminated.
>=20
> Thanks,
> Sushma
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Shu, Xinxin
> Sent: Monday, June 09, 2014 10:00 PM
> To: Mark Nelson; Sage Weil
> Cc: ceph-devel@vger.kernel.org; Zhang, Jian
> Subject: RE: [RFC] add rocksdb support
>=20
> Hi mark
>=20
> I have finished development of support of rocksdb submodule,  a pull =
request for support of autoconf/automake for rocksdb has been created ,=
 you can find https://github.com/ceph/rocksdb/pull/2 , if this patch is=
 ok ,  I will create a pull request for rocksdb submodule support , cur=
rently this patch can be found https://github.com/xinxinsh/ceph/tree/wi=
p-rocksdb .
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, June 10, 2014 1:12 AM
> To: Shu, Xinxin; Sage Weil
> Cc: ceph-devel@vger.kernel.org; Zhang, Jian
> Subject: Re: [RFC] add rocksdb support
>=20
> Hi Xinxin,
>=20
> On 05/28/2014 05:05 AM, Shu, Xinxin wrote:
>> Hi sage ,
>> I will add two configure options to --with-librocksdb-static and --w=
ith-librocksdb , with --with-librocksdb-static option , ceph will compi=
le the code that get from ceph repository , with  --with-librocksdb opt=
ion ,  in case of distro packages for rocksdb , ceph will not compile t=
he rocksdb code , will use pre-installed library. is that ok for you ?
>>=20
>> since current rocksdb does not support autoconf&automake , I will ad=
d autoconf&automake support for rocksdb , but before that , i think we =
should fork a stable branch (maybe 3.0) for ceph .
>=20
> I'm looking at testing out the rocksdb support as well, both for the =
OSD and for the monitor based on some issues we've been seeing lately. =
 Any news on the 3.0 fork and autoconf/automake support in rocksdb?
>=20
> Thanks,
> Mark
>=20
>>=20
>> -----Original Message-----
>> From: Mark Nelson [mailto:mark.nelson@inktank.com]
>> Sent: Wednesday, May 21, 2014 9:06 PM
>> To: Shu, Xinxin; Sage Weil
>> Cc: ceph-devel@vger.kernel.org; Zhang, Jian
>> Subject: Re: [RFC] add rocksdb support
>>=20
>> On 05/21/2014 07:54 AM, Shu, Xinxin wrote:
>>> Hi, sage
>>>=20
>>> I will add rocksdb submodule into the makefile , currently we want =
to have fully performance tests on key-value db backend , both leveldb =
and rocksdb. Then optimize on rocksdb performance.
>>=20
>> I'm definitely interested in any performance tests you do here.  Las=
t winter I started doing some fairly high level tests on raw leveldb/hy=
perleveldb/raikleveldb.  I'm very interested in what you see with rocks=
db as a backend.
>>=20
>>>=20
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sage@inktank.com]
>>> Sent: Wednesday, May 21, 2014 9:19 AM
>>> To: Shu, Xinxin
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Re: [RFC] add rocksdb support
>>>=20
>>> Hi Xinxin,
>>>=20
>>> I've pushed an updated wip-rocksdb to github/liewegas/ceph.git that=
 includes the latest set of patches with the groundwork and your rocksd=
b patch.  There is also a commit that adds rocksdb as a git submodule. =
 I'm thinking that, since there aren't any distro packages for rocksdb =
at this point, this is going to be the easiest way to make this usable =
for people.
>>>=20
>>> If you can wire the submodule into the makefile, we can merge this =
in so that rocksdb support is in the ceph.com packages on ceph.com.  I =
suspect that the distros will prefer to turns this off in favor of sepa=
rate shared libs, but they can do this at their option if/when they inc=
lude rocksdb in the distro. I think the key is just to have both --with=
-librockdb and --with-librocksdb-static (or similar) options so that yo=
u can either use the static or dynamically linked one.
>>>=20
>>> Has your group done further testing with rocksdb?  Anything interes=
ting to share?
>>>=20
>>> Thanks!
>>> sage
>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
