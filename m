From: Jean-Adrien <adv1@jeanjean.ch>
Subject: Re: mkcephfs 0.20 failure on debian: FAILED assert(r == 0)
Date: Wed, 12 May 2010 12:29:14 +0000 (UTC)
Message-ID: <loom.20100512T140305-368@post.gmane.org>
References: <hrhh53$gf3$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34832 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab0ELMfH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 May 2010 08:35:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OCB9V-00087o-24
	for ceph-devel@vger.kernel.org; Wed, 12 May 2010 14:35:05 +0200
Received: from 80-219-183-100.dclient.hispeed.ch ([80.219.183.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 May 2010 14:35:05 +0200
Received: from adv1 by 80-219-183-100.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 May 2010 14:35:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thomas Mueller <thomas <at> chaschperli.ch> writes:

> 
> Hi
> 
> I wanted to do some testing. but i failed on mkcephfs.  see mkcephfs 
> output below. 
>  **          testing and review.  Do not trust it with important 
> data.       **
> os/FileJournal.cc: In function 'int FileJournal::_open(bool, bool)':
> os/FileJournal.cc:74: FAILED assert(r == 0)
>  1: (FileJournal::create()+0x7f) [0x55725f]
>  2: (FileStore::mkjournal()+0x74) [0x542f04]
>  3: (FileStore::mkfs()+0x4c9) [0x540dd9]
>  4: (OSD::mkfs(char const*, char const*, ceph_fsid, int)+0x4a) [0x4c2dca]
>  5: (main()+0x751) [0x4585e1]
>  6: (__libc_start_main()+0xe6) [0x7fc412c811a6]
>  7: (std::ios_base::Init::~Init()+0x61) [0x457be9]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed 
> to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion*'
> /usr/lib/ceph/ceph_common.sh: line 95:  8680 Aborted                 
> (core dumped) bash -c "$1"
> failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.8485 -
> i 1 --mkfs --osd-data /data/osd1'


Hi,

I try to setup a little test cluster using kvm, and I have exactly the same
problem.
Moreover, I notice that when I want to delete the data created in the btrfs
partition it is not possible to remove the current directory, even if it is
empty:

root@cods-1:/mnt/btrfs/data# rm -rf osd0/
rm: cannot remove directory `osd0/current': Directory not empty

The only way is to reformat the partition (mkfs.btrfs /dev/sdb1)

But the next time I try to make the fs I have the same problem 
./mkcephfs -c ceph.conf -a -k /var/ceph-data/keyring.bin

I tried the --mkbtrfs option too, but I have the same result.
Did you made the same observations ? Any clue ?

Have a nice day

-- Jean-Adrien

