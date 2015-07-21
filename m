From: Sage Weil <sage@newdream.net>
Subject: Re: dmcrypt with luks keys in hammer
Date: Tue, 21 Jul 2015 07:00:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507210655170.8878@cobra.newdream.net>
References: <CAGbvivJH4UJtkcHmgvA7c88YJ6hgmm86fArqJJOszrtBh=kgrg@mail.gmail.com> <alpine.DEB.2.00.1507201419330.8878@cobra.newdream.net> <CAGbviv+2O1z-=9WWSFAFzox=B5dgsASNpYpi5jinmgPW=VTVVw@mail.gmail.com> <alpine.DEB.2.00.1507201521000.8878@cobra.newdream.net>
 <20150721131429.472492bf@g21.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50700 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546AbbGUOAa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 10:00:30 -0400
In-Reply-To: <20150721131429.472492bf@g21.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.com>

On Tue, 21 Jul 2015, David Disseldorp wrote:
> Hi,
> 
> On Mon, 20 Jul 2015 15:21:50 -0700 (PDT), Sage Weil wrote:
> 
> > On Mon, 20 Jul 2015, Wyllys Ingersoll wrote:
> > > No luck with ceph-disk-activate (all or just one device).
> > > 
> > > $ sudo ceph-disk-activate /dev/sdv1
> > > mount: unknown filesystem type 'crypto_LUKS'
> > > ceph-disk: Mounting filesystem failed: Command '['/bin/mount', '-t',
> > > 'crypto_LUKS', '-o', '', '--', '/dev/sdv1',
> > > '/var/lib/ceph/tmp/mnt.QHe3zK']' returned non-zero exit status 32
> > > 
> > > 
> > > Its odd that it should complain about the "crypto_LUKS" filesystem not
> > > being recognized, because it did mount some of the LUKS systems
> > > successfully, though not sometimes just the data and not the journal
> > > (or vice versa).
> > > 
> > > $ lsblk /dev/sdb
> > > NAME                                            MAJ:MIN RM   SIZE RO
> > > TYPE  MOUNTPOINT
> > > sdb                                               8:16   0   3.7T  0 disk
> > > ??sdb1                                            8:17   0   3.6T  0 part
> > > ? ??e8bc1531-a187-4fd2-9e3f-cf90255f89d0 (dm-0) 252:0    0   3.6T  0
> > > crypt /var/lib/ceph/osd/ceph-54
> > > ??sdb2                                            8:18   0    10G  0 part
> > >   ??temporary-cryptsetup-1235 (dm-6)            252:6    0   125K  1 crypt
> > > 
> > > 
> > > $ blkid /dev/sdb1
> > > /dev/sdb1: UUID="d6194096-a219-4732-8d61-d0c125c49393" TYPE="crypto_LUKS"
> > > 
> > > 
> > > A race condition (or other issue) with udev seems likely given that
> > > its rather random which ones come up and which ones don't.
> > 
> > A race condition during creation or activation?  If it's activation I 
> > would expect ceph-disk activate ... to work reasonably reliably when 
> > called manually (on a single device at a time).
> 
> We encountered similar issues on a non-dmcrypt firefly deployment with
> 10 OSDs per node.
> 
> I've been working on a patch set to defer device activation to systemd
> services. ceph-disk activate is extended to support mapping of dmcrypt
> devices prior to OSD startup.
> 
> The master-based changes aren't ready for upstream yet, but can be found
> in my WIP branch at:
> https://github.com/ddiss/ceph/tree/wip_bnc926756_split_udev_systemd_master

This approach looks to be MUCH MUCH better than what we're doing right 
now!
 
> There are a few things that I'd still like to address before submitting
> upstream, mostly covering activate-journal:
> - The test/ceph-disk.sh unit tests need to be extended and fixed.
> - The activate-journal --dmcrypt changes are less than optimal, and leave
>   me with a few unanswered questions:
>   + Does get_journal_osd_uuid(dev) return the plaintext or cyphertext
>     uuid?

The uuid is never encrypted.

>   + If a journal is encrypted, is the data partition also always
>     encrypted?

Yes (I don't think it's useful to support a mixed encrypted/unencrypted 
OSD).

> - dmcrypt journal device mapping should probably also be split out into
>   a separate systemd service, as that'll be needed for the future
>   network based key retrieval feature.
> 
> Feedback on the approach taken would be appreciated.

My only regret is that it won't help non-systemd cases, but I'm okay with 
leaving those as is (users can use the existing workarounds, like 
'ceph-disk activate-all' in rc.local to mop up stragglers) and focus 
instead on the new systemd world.

Let us know if there's anything else we can do to help!

sage

