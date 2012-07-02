From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: "rbd rm" allows removal of mapped device, nukes data, then returns
 -EBUSY
Date: Mon, 02 Jul 2012 09:08:39 -0700
Message-ID: <4FF1C787.7000701@inktank.com>
References: <CAPUexz-goSwxReRH_9gW_owHbTUrOLiwx8hsBzPMEzfEnm5GBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43741 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab2GBQIl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 12:08:41 -0400
Received: by gglu4 with SMTP id u4so4236583ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 09:08:40 -0700 (PDT)
In-Reply-To: <CAPUexz-goSwxReRH_9gW_owHbTUrOLiwx8hsBzPMEzfEnm5GBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On 07/01/2012 11:58 PM, Florian Haas wrote:
> Hi everyone,
>
> just wanted to check if this was the expected behavior -- it doesn't
> look like it would be, to me.
>
> What I do is create a 1G RBD, and just for the heck of it, make an XFS on it:
>
> root@alice:~# rbd create xfsdev --size 1024
> root@alice:~# rbd map xfsdev
> root@alice:~# rbd showmapped
> id	pool	image	snap	device
> 0	rbd	xfsdev	-	/dev/rbd0
> root@alice:~# mkfs -t xfs /dev/rbd/rbd/xfsdev
> log stripe unit (4194304 bytes) is too large (maximum is 256KiB)
> log stripe unit adjusted to 32KiB
> meta-data=/dev/rbd/rbd/xfsdev    isize=256    agcount=9, agsize=31744 blks
>           =                       sectsz=512   attr=2, projid32bit=0
> data     =                       bsize=4096   blocks=262144, imaxpct=25
>           =                       sunit=1024   swidth=1024 blks
> naming   =version 2              bsize=4096   ascii-ci=0
> log      =internal log           bsize=4096   blocks=2560, version=2
>           =                       sectsz=512   sunit=8 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
>
> I double check to see if there's an XFS signature on the device:
>
> root@alice:~# xxd /dev/rbd/rbd/xfsdev | head
> 0000000: 5846 5342 0000 1000 0000 0000 0004 0000  XFSB............
> 0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000020: 17bb f4df b1f3 444b bc01 3b3e f827 8fef  ......DK..;>.'..
> 0000030: 0000 0000 0002 0008 0000 0000 0000 4000  ..............@.
> 0000040: 0000 0000 0000 4001 0000 0000 0000 4002  ......@.......@.
> 0000050: 0000 0001 0000 7c00 0000 0009 0000 0000  ......|.........
> 0000060: 0000 0a00 b5a4 0200 0100 0010 0000 0000  ................
> 0000070: 0000 0000 0000 0000 0c09 0804 0f00 0019  ................
> 0000080: 0000 0000 0000 0040 0000 0000 0000 003d  .......@.......=
> 0000090: 0000 0000 0003 f5d8 0000 0000 0000 0000  ................
>
> Now, I try to remove the device while it's mapped:
>
> root@alice:~# rbd rm xfsdev
> Removing image: 99% complete...2012-07-02 06:52:57.386040 b6c8d710 -1
> librbd: error removing header: (16) Device or resource busy
> Removing image: 99% complete...failed.
> delete error: image still has watchers
> This means the image is still open or the client using it crashed. Try
> again after closing/unmapping it or waiting 30s for the crashed client
> to timeout.
>
> That sounds reasonable, except that the data has already been nuked:

The data objects need to be removed first so that a failure in the
middle won't leave you with data objects you don't know how to remove.
That is, the name of the data objects is stored in the header, so if
'rbd rm' removed the header, then crashed, 'rbd rm' would not know
where the data objects were on the next run.

> root@alice:~# xxd /dev/rbd/rbd/xfsdev | head
> 0000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000030: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000050: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000070: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000080: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 0000090: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>
> After unmapping, the device removal proceeds just fine.
>
> root@alice:~# rbd unmap /dev/rbd0
> root@alice:~# rbd rm xfsdev
> Removing image: 100% complete...done.
>
> Now if the RBD is capable of detecting that it's being watched, why
> not fail the removal _before_ wiping data, potentially with an
> override with a --force flag?

While it would be possible to check if there were watchers, it would be
racy. A better way to prevent removing a mapped image would be to use
the new locking features. We could add an option like --lock to take an
exclusive lock on the image, so you could do 'rbd rm --lock pool/image'
to ensure that no one else has it mapped. This would require all your 
clients to support locking though.

Josh
