From: Gregory Farnum <greg@inktank.com>
Subject: Re: "rbd rm" allows removal of mapped device, nukes data, then
 returns -EBUSY
Date: Mon, 2 Jul 2012 09:14:21 -0700
Message-ID: <CAPYLRzh50Tu2KF+J6Fc03uKfA245M-0prxK+KLNEa=ek-2MLzA@mail.gmail.com>
References: <CAPUexz-goSwxReRH_9gW_owHbTUrOLiwx8hsBzPMEzfEnm5GBQ@mail.gmail.com>
	<4FF1C787.7000701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55258 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab2GBQOX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 12:14:23 -0400
Received: by lbbgm6 with SMTP id gm6so7847724lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 09:14:21 -0700 (PDT)
In-Reply-To: <4FF1C787.7000701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 2, 2012 at 9:08 AM, Josh Durgin <josh.durgin@inktank.com> w=
rote:
> On 07/01/2012 11:58 PM, Florian Haas wrote:
>>
>> Hi everyone,
>>
>> just wanted to check if this was the expected behavior -- it doesn't
>> look like it would be, to me.
>>
>> What I do is create a 1G RBD, and just for the heck of it, make an X=
=46S on
>> it:
>>
>> root@alice:~# rbd create xfsdev --size 1024
>> root@alice:~# rbd map xfsdev
>> root@alice:~# rbd showmapped
>> id =A0 =A0 =A0pool =A0 =A0image =A0 snap =A0 =A0device
>> 0 =A0 =A0 =A0 rbd =A0 =A0 xfsdev =A0- =A0 =A0 =A0 /dev/rbd0
>> root@alice:~# mkfs -t xfs /dev/rbd/rbd/xfsdev
>> log stripe unit (4194304 bytes) is too large (maximum is 256KiB)
>> log stripe unit adjusted to 32KiB
>> meta-data=3D/dev/rbd/rbd/xfsdev =A0 =A0isize=3D256 =A0 =A0agcount=3D=
9, agsize=3D31744 blks
>> =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
sectsz=3D512 =A0 attr=3D2, projid32bit=3D0
>> data =A0 =A0 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bsize=3D=
4096 =A0 blocks=3D262144, imaxpct=3D25
>> =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
sunit=3D1024 =A0 swidth=3D1024 blks
>> naming =A0 =3Dversion 2 =A0 =A0 =A0 =A0 =A0 =A0 =A0bsize=3D4096 =A0 =
ascii-ci=3D0
>> log =A0 =A0 =A0=3Dinternal log =A0 =A0 =A0 =A0 =A0 bsize=3D4096 =A0 =
blocks=3D2560, version=3D2
>> =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
sectsz=3D512 =A0 sunit=3D8 blks, lazy-count=3D1
>> realtime =3Dnone =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extsz=3D4096 =A0=
 blocks=3D0, rtextents=3D0
>>
>> I double check to see if there's an XFS signature on the device:
>>
>> root@alice:~# xxd /dev/rbd/rbd/xfsdev | head
>> 0000000: 5846 5342 0000 1000 0000 0000 0004 0000 =A0XFSB............
>> 0000010: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000020: 17bb f4df b1f3 444b bc01 3b3e f827 8fef =A0......DK..;>.'..
>> 0000030: 0000 0000 0002 0008 0000 0000 0000 4000 =A0..............@.
>> 0000040: 0000 0000 0000 4001 0000 0000 0000 4002 =A0......@.......@.
>> 0000050: 0000 0001 0000 7c00 0000 0009 0000 0000 =A0......|.........
>> 0000060: 0000 0a00 b5a4 0200 0100 0010 0000 0000 =A0................
>> 0000070: 0000 0000 0000 0000 0c09 0804 0f00 0019 =A0................
>> 0000080: 0000 0000 0000 0040 0000 0000 0000 003d =A0.......@.......=3D
>> 0000090: 0000 0000 0003 f5d8 0000 0000 0000 0000 =A0................
>>
>> Now, I try to remove the device while it's mapped:
>>
>> root@alice:~# rbd rm xfsdev
>> Removing image: 99% complete...2012-07-02 06:52:57.386040 b6c8d710 -=
1
>> librbd: error removing header: (16) Device or resource busy
>> Removing image: 99% complete...failed.
>> delete error: image still has watchers
>> This means the image is still open or the client using it crashed. T=
ry
>> again after closing/unmapping it or waiting 30s for the crashed clie=
nt
>> to timeout.
>>
>> That sounds reasonable, except that the data has already been nuked:
>
>
> The data objects need to be removed first so that a failure in the
> middle won't leave you with data objects you don't know how to remove=
=2E
> That is, the name of the data objects is stored in the header, so if
> 'rbd rm' removed the header, then crashed, 'rbd rm' would not know
> where the data objects were on the next run.
>
>
>> root@alice:~# xxd /dev/rbd/rbd/xfsdev | head
>> 0000000: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000010: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000020: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000030: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000040: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000050: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000060: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000070: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000080: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>> 0000090: 0000 0000 0000 0000 0000 0000 0000 0000 =A0................
>>
>> After unmapping, the device removal proceeds just fine.
>>
>> root@alice:~# rbd unmap /dev/rbd0
>> root@alice:~# rbd rm xfsdev
>> Removing image: 100% complete...done.
>>
>> Now if the RBD is capable of detecting that it's being watched, why
>> not fail the removal _before_ wiping data, potentially with an
>> override with a --force flag?
>
>
> While it would be possible to check if there were watchers, it would =
be
> racy.
Sure, but if they have it watched when we start we could at least bail
out then instead of at the end. You want to put a feature request in
the tracker, Florian? :)
-Greg

> A better way to prevent removing a mapped image would be to use
> the new locking features. We could add an option like --lock to take =
an
> exclusive lock on the image, so you could do 'rbd rm --lock pool/imag=
e'
> to ensure that no one else has it mapped. This would require all your
> clients to support locking though.
>
> Josh
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
