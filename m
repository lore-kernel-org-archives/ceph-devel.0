From: <Eric_YH_Chen@wistron.com>
Subject: RE: How to sync data on different server but with the same image
Date: Wed, 7 Dec 2011 10:00:40 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D943342@WHQBEMAIL1.whq.wistron>
References: <8512670932FB654F81AF0FEF1BE6D49D9430EB@WHQBEMAIL1.whq.wistron><1323163999.26341.2.camel@Nokia-N900-02-8><8512670932FB654F81AF0FEF1BE6D49D943125@WHQBEMAIL1.whq.wistron> <CAN4=B2kdTfJ27NVGETcY=EhAZtYqGtkZtMMosPd=4hpMDNFjaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:63940 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab1LGCAo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 21:00:44 -0500
Content-class: urn:content-classes:message
In-Reply-To: <CAN4=B2kdTfJ27NVGETcY=EhAZtYqGtkZtMMosPd=4hpMDNFjaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: brchrisman@gmail.com
Cc: wido@widodh.nl, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

Hi, Brian:

    I would like to use SCST target or LIO target.=20
	But I found they are not supported on ubuntu 11.10 server.=20
    (LIO iSCSI is released under 3.1 kernel, but 11.10 server uses 3.0 =
kernel)
    Could you kindly to share how to use SCST target or LIO target on u=
buntu ?

    I try the multipath with STGT, however, but it doesn't work well.=20
    I think that is because it doesn't support BLOCKIO, am I right?=20

    Thanks!

-----Original Message-----
=46rom: Brian Chrisman [mailto:brchrisman@gmail.com]=20
Sent: Wednesday, December 07, 2011 12:01 AM
To: Eric YH Chen/WHQ/Wistron
Cc: wido@widodh.nl; ceph-devel@vger.kernel.org; Chris YT Huang/WHQ/Wist=
ron
Subject: Re: How to sync data on different server but with the same ima=
ge

Eric,
If you export the rbd device directly via your iSCSI target driver, it
should work.
I verified this with the SCST target, but the LIO target should work as=
 well.
As Wido said, you don't want to mount the same rbd device on multiple
clients without a shared filesystem (and in that case, you might as
well use cephfs), but exporting rbd over iSCSI works.


On Tue, Dec 6, 2011 at 1:38 AM,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, Wido:
>
> =A0 This is a preliminary experiment before implement iSCSI High Avai=
lable multipath.
> =A0 =A0 =A0 =A0http://ceph.newdream.net/wiki/ISCSI
>
> =A0 Therefore, we use Ceph as rbd device instead of file system.
>
>
> -----Original Message-----
> From: Wido den Hollander [mailto:wido@widodh.nl]
> Sent: Tuesday, December 06, 2011 5:33 PM
> To: Eric YH Chen/WHQ/Wistron; ceph-devel@vger.kernel.org
> Cc: Chris YT Huang/WHQ/Wistron
> Subject: Re: How to sync data on different server but with the same i=
mage
>
> Hi,
>
> ----- Original message -----
>> Dear All:
>>
>>=A0 =A0 =A0 =A0I map the same rbd image to the rbd device on two diff=
erent servers.
>>
>> =A0=A0=A0 For example:
>>=A0 =A0 =A0 =A0 =A0 =A01. create rbd image named foo
>>=A0 =A0 =A0 =A0 =A0 =A02. map foo to /dev/rbd0 on server A,=A0 =A0mou=
nt /dev/rbd0 to /mnt
>>=A0 =A0 =A0 =A0 =A0 =A03. map foo to /dev/rbd0 on server B,=A0 =A0mou=
nt /dev/rbd0 to /mnt
>>
>>=A0 =A0 =A0 =A0If I put add a file to /mnt via server A, I hope I can=
 see the same
>> file on server B.
>>=A0 =A0 =A0 =A0However, I can't see it until I umount /mnt on server =
A and re-mount
>> /mnt on server B.
>
> You'd have to use an cluster filesystem like GFS or OCFS2 to let this=
 work.
>
> But why not use Ceph as a filesystem instead of RBD? That seems to do=
 what you want.
>
> Wido
>
>>
>>=A0 =A0 =A0 =A0Do you have any comment about this scenario? How could=
 I force the
>> data synchronization?
>>
>>=A0 =A0 =A0 =A0Actually, I want to implement the iSCSI High Available=
 multipath on
>> http://ceph.newdream.net/wiki/ISCSI.
>>=A0 =A0 =A0 =A0Therefore, I tried this small experiment first, but fa=
il. Would you
>> please give me some suggestion before I start to implement it? Thank=
s!
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
