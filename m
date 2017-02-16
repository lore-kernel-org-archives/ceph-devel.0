From: Wido den Hollander <wido@42on.com>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Thu, 16 Feb 2017 16:14:00 +0100 (CET)
Message-ID: <250864845.10165.1487258041091@ox.pcextreme.nl>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl>
 <alpine.DEB.2.11.1702151712530.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:46070 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932178AbdBPPOE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 10:14:04 -0500
In-Reply-To: <alpine.DEB.2.11.1702151712530.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 15 februari 2017 om 18:14 schreef Sage Weil <sage@newdream.net>:
> 
> 
> On Wed, 15 Feb 2017, Wido den Hollander wrote:
> > Hi,
> > 
> > Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't 
> > provide a OSD ID.
> > 
> > With BlueStore coming I think the use-case for this is becoming very 
> > valid:
> > 
> > 1. Stop OSD
> > 2. Zap disk
> > 3. Re-create OSD with same ID and UUID (with BlueStore)
> > 4. Start OSD
> > 
> > This allows for a in-place update of the OSD without modifying the 
> > CRUSHMap. For the cluster's point of view the OSD goes down and comes 
> > back up empty.
> > 
> > There were some drawbacks around this and some dangers, so before I 
> > start working on a PR for this, any gotcaches which might be a problem?
> > 
> > The idea is that users have a very simple way to re-format a OSD 
> > in-place while keeping the same CRUSH location, ID and UUID.
> 
> +1
> 
> However, I don't think we need to specify the osd id.. just the uuid.  If 
> you pass an existing uuid to 'osd create' it will give you back the 
> existing osd id.  Please test to confirm, but I *think* it is sufficient 
> to just give ceph-disk prepare the old osd's uuid.
> 

Ok, so there were a few things going on here:

- My memory which told me it wasn't possible
- Old Journal data
- Cephx issues

What it boils down to is that this is not sufficient:

$ systemctl stop ceph-osd@4
$ cat /var/lib/ceph/osd/ceph-4/fsid
$ umount
$ ceph-disk prepare --zap-disk --osd-uuid 8f3b58f4-ded3-4b50-836e-72745405f482 /dev/sdb

What needs to be done:

$ systemctl stop ceph-osd@4
$ ceph auth del osd.4
$ cat /var/lib/ceph/osd/ceph-4/fsid
$ umount
$ dd if=/dev/zero of=/dev/sdb2 bs=1M count=100
$ ceph-disk prepare --zap-disk --osd-uuid 8f3b58f4-ded3-4b50-836e-72745405f482 /dev/sdb

Zapping a disk only removes the GPT structures and your XFS (filestore's case) will overwrite the previous system.

However, if the partition layout is the same as before the Journal will not be emptied and the OSD will crash during start.

If you go to BlueStore this is not a problem since you overwrite the whole disk:

$ ceph-disk prepare --zap-disk --osd-uuid 8f3b58f4-ded3-4b50-836e-72745405f482 --bluestore /dev/sdb

Also, the old Cephx is not re-used but a new one is registered, so you have to remove the old one first.

> Maybe the thing to do is create a streamlined command to do this: 
> 'ceph-disk prepare --zap-and-reformat' or something that grabs the old 
> uuid for you, does the zap, and then feeds it to prepare?

Probably a good idea, we just need to figure out how to remove the old key. The bootstrap key isn't allowed to do that:

root@echo:~# ceph --id bootstrap-osd --keyring /var/lib/ceph/bootstrap-osd/ceph.keyring auth list
Error EACCES: access denied
root@echo:~#

The steps it should take:

1. Get OSD UUID
2. Try to unmount the disk (fails if OSD is still running)
3. Remove old Cephx key (how to do so?)
4. Zap the disk
5. Prepare disk with same UUID
6. Add new cephx key
7. Start the OSD

I am not sure on how to do step #3 from a client with the bootstrap-osd keyring though.

Wido

> 
> sage
>
