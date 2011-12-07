From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: How to sync data on different server but with the same image
Date: Wed, 7 Dec 2011 09:59:16 -0800
Message-ID: <CAN4=B2m=qdsqM7TsGgVpOrtypNQmvCmKsgPxJR3dPx0KmgxZUw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D9430EB@WHQBEMAIL1.whq.wistron>
	<1323163999.26341.2.camel@Nokia-N900-02-8>
	<8512670932FB654F81AF0FEF1BE6D49D943125@WHQBEMAIL1.whq.wistron>
	<CAN4=B2kdTfJ27NVGETcY=EhAZtYqGtkZtMMosPd=4hpMDNFjaw@mail.gmail.com>
	<8512670932FB654F81AF0FEF1BE6D49D943342@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36298 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab1LGR7R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 12:59:17 -0500
Received: by vcbfk14 with SMTP id fk14so676234vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2011 09:59:16 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D943342@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: wido@widodh.nl, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

You will likely have to recompile your kernel.  For LIO, recent
kernels should have the option available.  For SCST, you'll need
compile your kernel with some patches and likely some userspace
components.  If you look at the SCST user guide docs, I've verified
that they are correct and work with rbd (at least for rhel-based
systems, but they should also work for other distros).

http://iscsi-scst.sourceforge.net/iscsi-scst-howto.txt

On Tue, Dec 6, 2011 at 6:00 PM,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, Brian:
>
> =A0 =A0I would like to use SCST target or LIO target.
> =A0 =A0 =A0 =A0But I found they are not supported on ubuntu 11.10 ser=
ver.
> =A0 =A0(LIO iSCSI is released under 3.1 kernel, but 11.10 server uses=
 3.0 kernel)
> =A0 =A0Could you kindly to share how to use SCST target or LIO target=
 on ubuntu ?
>
> =A0 =A0I try the multipath with STGT, however, but it doesn't work we=
ll.
> =A0 =A0I think that is because it doesn't support BLOCKIO, am I right=
?
>
> =A0 =A0Thanks!
>
> -----Original Message-----
> From: Brian Chrisman [mailto:brchrisman@gmail.com]
> Sent: Wednesday, December 07, 2011 12:01 AM
> To: Eric YH Chen/WHQ/Wistron
> Cc: wido@widodh.nl; ceph-devel@vger.kernel.org; Chris YT Huang/WHQ/Wi=
stron
> Subject: Re: How to sync data on different server but with the same i=
mage
>
> Eric,
> If you export the rbd device directly via your iSCSI target driver, i=
t
> should work.
> I verified this with the SCST target, but the LIO target should work =
as well.
> As Wido said, you don't want to mount the same rbd device on multiple
> clients without a shared filesystem (and in that case, you might as
> well use cephfs), but exporting rbd over iSCSI works.
>
>
> On Tue, Dec 6, 2011 at 1:38 AM, =A0<Eric_YH_Chen@wistron.com> wrote:
>> Hi, Wido:
>>
>> =A0 This is a preliminary experiment before implement iSCSI High Ava=
ilable multipath.
>> =A0 =A0 =A0 =A0http://ceph.newdream.net/wiki/ISCSI
>>
>> =A0 Therefore, we use Ceph as rbd device instead of file system.
>>
>>
>> -----Original Message-----
>> From: Wido den Hollander [mailto:wido@widodh.nl]
>> Sent: Tuesday, December 06, 2011 5:33 PM
>> To: Eric YH Chen/WHQ/Wistron; ceph-devel@vger.kernel.org
>> Cc: Chris YT Huang/WHQ/Wistron
>> Subject: Re: How to sync data on different server but with the same =
image
>>
>> Hi,
>>
>> ----- Original message -----
>>> Dear All:
>>>
>>>=A0 =A0 =A0 =A0I map the same rbd image to the rbd device on two dif=
ferent servers.
>>>
>>> =A0=A0=A0 For example:
>>>=A0 =A0 =A0 =A0 =A0 =A01. create rbd image named foo
>>>=A0 =A0 =A0 =A0 =A0 =A02. map foo to /dev/rbd0 on server A,=A0 =A0mo=
unt /dev/rbd0 to /mnt
>>>=A0 =A0 =A0 =A0 =A0 =A03. map foo to /dev/rbd0 on server B,=A0 =A0mo=
unt /dev/rbd0 to /mnt
>>>
>>>=A0 =A0 =A0 =A0If I put add a file to /mnt via server A, I hope I ca=
n see the same
>>> file on server B.
>>>=A0 =A0 =A0 =A0However, I can't see it until I umount /mnt on server=
 A and re-mount
>>> /mnt on server B.
>>
>> You'd have to use an cluster filesystem like GFS or OCFS2 to let thi=
s work.
>>
>> But why not use Ceph as a filesystem instead of RBD? That seems to d=
o what you want.
>>
>> Wido
>>
>>>
>>>=A0 =A0 =A0 =A0Do you have any comment about this scenario? How coul=
d I force the
>>> data synchronization?
>>>
>>>=A0 =A0 =A0 =A0Actually, I want to implement the iSCSI High Availabl=
e multipath on
>>> http://ceph.newdream.net/wiki/ISCSI.
>>>=A0 =A0 =A0 =A0Therefore, I tried this small experiment first, but f=
ail. Would you
>>> please give me some suggestion before I start to implement it? Than=
ks!
>>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
