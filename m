From: Simon Frerichs | Fremaks GmbH <frerichs@fremaks.de>
Subject: Re: Updating OSD from current stable (0.47-2) to next failed with
 broken filestore
Date: Mon, 18 Jun 2012 10:01:26 +0200
Message-ID: <4FDEE056.5090009@fremaks.de>
References: <4FDC87C2.7060000@fremaks.de> <Pine.LNX.4.64.1206171416490.20239@cobra.newdream.net> <Pine.LNX.4.64.1206171421210.20239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.fremaks.net ([46.19.89.69]:52760 "EHLO mail.fremaks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab2FRIBb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jun 2012 04:01:31 -0400
In-Reply-To: <Pine.LNX.4.64.1206171421210.20239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

it's fixed now in the 'next' branch.
We're using XFS for data storage.

Thanks for fixing this.
Simon

Am 17.06.12 23:22, schrieb Sage Weil:
> On Sun, 17 Jun 2012, Sage Weil wrote:
>> Hi Simon,
>>
>> We've opened http://tracker.newdream.net/issues/2598 to track this.
> Actually, having looked at the code, I'm pretty sure I see the proble=
m.
> I pushed a fix to the 'next' branch.  Can you try the latest and see =
if it
> resolves the problem?
>
> (Also, out of curiosity, what file system are you running underneath =
the
> ceph-osd?)
>
> Thanks!
> sage
>
>
>> Thanks!
>> sage
>>
>> On Sat, 16 Jun 2012, Simon Frerichs | Fremaks GmbH wrote:
>>
>>> Hi,
>>>
>>> i tried updating one of our osds from stable 0.47-2 to latest next =
branch and
>>> it started updating the filestore and failed.
>>> After that neither next branch osd nor stable osd would start with =
this
>>> filestore anymore.
>>> Is their something wrong with the filestore update?
>>>
>>> Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134135 7ffe=
d3e35780 0
>>> filestore(/data/osd11) mount FIEMAP ioctl is supported and appears =
to work Jun
>>> 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134163 7ffed3e3=
5780 0
>>> filestore(/data/osd11) mount FIEMAP ioctl is disabled via 'filestor=
e fiemap'
>>> config option Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:=
03.134476
>>> 7ffed3e35780 0 filestore(/data/osd11) mount did NOT detect btrfs Ju=
n 16
>>> 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134485 7ffed3e3578=
0 0
>>> filestore(/data/osd11) mount syncfs(2) syscall not support by glibc=
 Jun 16
>>> 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134513 7ffed3e3578=
0 0
>>> filestore(/data/osd11) mount no syncfs(2), must use sync(2). Jun 16=
 14:10:03
>>> fcstore01 ceph-osd: 2012-06-16 14:10:03.134514 7ffed3e35780 0
>>> filestore(/data/osd11) mount WARNING: multiple ceph-osd daemons on =
the same
>>> host will be slow Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16
>>> 14:10:03.134551 7ffed3e35780 -1 filestore(/data/osd11) FileStore::m=
ount :
>>> stale version stamp detected: 2. Proceeding, do_update is set, DO N=
OT USE THIS
>>> OPTION IF YOU DO NOT KNOW WHAT IT DOES. More details can be found o=
n the wiki.
>>> Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134585 7ffe=
d3e35780 0
>>> filestore(/data/osd11) mount found snaps <> Jun 16 14:10:12 fcstore=
01
>>> ceph-osd: 2012-06-16 14:10:12.531974 7ffed3e35780 0 filestore(/data=
/osd11)
>>> mount: enabling WRITEAHEAD journal mode: btrfs not detected Jun 16 =
14:10:12
>>> fcstore01 ceph-osd: 2012-06-16 14:10:12.543721 7ffed3e35780 1 journ=
al _open
>>> /dev/sdb1 fd 18: 53687091200 bytes, block size 4096 bytes, directio=
 =3D 1, aio =3D
>>> 0 Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.588059 7f=
fed3e35780
>>> 1 journal _open /dev/sdb1 fd 18: 53687091200 bytes, block size 4096=
 bytes,
>>> directio =3D 1, aio =3D 0 Jun 16 14:10:12 fcstore01 ceph-osd: 2012-=
06-16
>>> 14:10:12.588905 7ffed3e35780 -1 FileStore is old at version 2. Upda=
ting... Jun
>>> 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.588914 7ffed3e3=
5780 -1
>>> Removing tmp pgs Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16
>>> 14:10:12.594362 7ffed3e35780 -1 Getting collections Jun 16 14:10:12=
 fcstore01
>>> ceph-osd: 2012-06-16 14:10:12.594369 7ffed3e35780 -1 597 to process=
=2E Jun 16
>>> 14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.595195 7ffed3e3578=
0 -1 0/597
>>> processed Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.5=
95213
>>> 7ffed3e35780 -1 Updating collection omap current version is 0 Jun 1=
6 14:10:12
>>> fcstore01 ceph-osd: 2012-06-16 14:10:12.662274 7ffed3e35780 -1
>>> os/FlatIndex.cc: In function 'virtual int
>>> FlatIndex::collection_list_partial(const hobject_t&, int, int, snap=
id_t,
>>> std::vector<hobject_t>*, hobject_t*)' thread 7ffed3e35780 time 2012=
-06-16
>>> 14:10:12.637479#012os/FlatIndex.cc: 386: FAILED assert(0)#012#012 c=
eph version
>>> 0.47.2-500-g1e899d0 (commit:1e899d08e61bbba0af6f3600b6bc9a5fc9e5c2e=
9)#012 1:
>>> /usr/local/bin/ceph-osd() [0x6b337d]#012 2:
>>> (FileStore::collection_list_partial(coll_t, hobject_t, int, int, sn=
apid_t,
>>> std::vector<hobject_t, std::allocator<hobject_t> >*, hobject_t*)+0x=
9c)
>>> [0x67b24c]#012 3: (OSD::convert_collection(ObjectStore*, coll_t)+0x=
529)
>>> [0x5b90e9]#012 4: (OSD::do_convertfs(ObjectStore*)+0x46f) [0x5b9b9f=
]#012 5:
>>> (OSD::convertfs(std::string const&, std::string const&)+0x47) [0x5b=
a127]#012
>>> 6: (main()+0x967) [0x531d07]#012 7: (__libc_start_main()+0xfd)
>>> [0x7ffed1d8aead]#012 8: /usr/local/bin/ceph-osd() [0x5357b9]#012 NO=
TE: a copy
>>> of the executable, or `objdump -rdS <executable>` is needed to inte=
rpret this.
>>>
>>> Simon
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Mit freundlichen Gr=FC=DFen
Simon Frerichs

=46remaks GmbH
Rahester Verlaat 11
26605 Aurich

Tel: 04941 / 7399790
=46ax: 04941 / 7399799

Diese E-Mail kann vertrauliche und/oder rechtlich gesch=FCtzte Informat=
ionen enthalten. Wenn Sie nicht der richtige Adressat sind oder diese e=
Mail irrt=FCmlich erhalten haben, informieren Sie bitte sofort den Abse=
nder und vernichten Sie diese eMail. Das unerlaubte Kopieren sowie die =
unbefugte Weitergabe dieser eMail und/oder der darin enthaltenen Inform=
ationen ist nicht gestattet.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
