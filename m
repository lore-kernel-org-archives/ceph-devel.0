From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: How to sync data on different server but with the same image
Date: Tue, 6 Dec 2011 08:00:56 -0800
Message-ID: <CAN4=B2kdTfJ27NVGETcY=EhAZtYqGtkZtMMosPd=4hpMDNFjaw@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D9430EB@WHQBEMAIL1.whq.wistron>
	<1323163999.26341.2.camel@Nokia-N900-02-8>
	<8512670932FB654F81AF0FEF1BE6D49D943125@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56173 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab1LFQA4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 11:00:56 -0500
Received: by vcbfk14 with SMTP id fk14so5018593vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 08:00:56 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D943125@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: wido@widodh.nl, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

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
