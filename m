From: Sage Weil <sage@newdream.net>
Subject: Re: cephx auth issues:Having issues trying to get the OSD up on a
 MIPS64, when the OSD tries to communicate with the monitor!!!
Date: Tue, 28 Oct 2014 16:58:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410281657230.15740@cobra.newdream.net>
References: <BC9BE980F12C4446A1CB0380E1C97DCD3390E11E@EXMAIL1.taec.toshiba.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59482 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbaJ1X6e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 19:58:34 -0400
In-Reply-To: <BC9BE980F12C4446A1CB0380E1C97DCD3390E11E@EXMAIL1.taec.toshiba.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Prashanth Nednoor <Prashanth.Nednoor@taec.toshiba.com>
Cc: Philip Kufeldt <Philip.Kufeldt@taec.toshiba.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Tue, 28 Oct 2014, Prashanth Nednoor wrote:
> Folks,
> 
> I am trying to get the osd up and having an issue. OSD does exchange some messages with the MONITOR before this error.
> Seems like an issue with authentication in my set up with MIPS based OSD and Intel XEON MONITORS. I have attached the logs.
> The OSD(209.243.157.187) sends some request to MONITOR (209.243.160.45).
> I see this message No session security set, followed by the below message.
> The reply is coming back as auth_reply(proto 2 -1 (1) Operation not permitted.
> 
> Is there an ENDIAN issue here between MIPS based OSD(BIGEENDIAN) and INTEL XEONS(LITTLE ENDIAN), my CEPH-MOINTORS are INTEL XEONS???
> 
> I made sure the keyrings are all consistent. Here are the keys on OSD and MONITOR.
> 
> I tried disabling authentication by setting the following auth_service_required = none, auth_client_required = none and auth_cluster_required = none.
> Looks there was some issue with this in osd_init code, where it seems like AUTHENTICATION IS MANDATORY.
> 
> HERE IS THE INFORMATION ON MY KEYS ON OSD AND MONITOR.
> ON THE OSD:
> more /etc/ceph/ceph.client.admin.keyring
> [osd.0]
>         key = AQCddYJv4JkxIhAApeqP7Ahp+uUXYrgmgQt+LA==
> [client.admin]
>         key = AQA1jixUQAaWABAA1tAjhIbrmOCIqNAkeNVulQ==
> 
> more /var/lib/ceph/bootstrap-osd/ceph.keyring
> [client.bootstrap-osd]
>         key = AQA1jixUwGjoGxAASUUlYC2rGfH7Zl4rCfCylA==
> 
> ON THE MONITOR:
> more /etc/ceph/ceph.client.admin.keyring
> [client.admin]
>         key = AQA1jixUQAaWABAA1tAjhIbrmOCIqNAkeNVulQ==
> 
> more /var/lib/ceph/bootstrap-osd/ceph.keyring
> [client.bootstrap-osd]
>         key = AQA1jixUwGjoGxAASUUlYC2rGfH7Zl4rCfCylA==
> 
> 
> Any pointers are  greatly appreciated?? 
> Thanks in advance for help.

Can you put

 debug auth = 20
 debug mon = 20
 debug ms = 20

in the [global] section of ceph.conf and reproduce this, and attach 
both the ceph mon log and osd logs?

Thanks!
sage



> thanks
> Prashanth
> 
> 
> -----Original Message-----
> From: Prashanth Nednoor 
> Sent: Sunday, October 26, 2014 9:14 PM
> To: 'Sage Weil'; Philip Kufeldt
> Cc: 'ceph-devel@vger.kernel.org'
> Subject: RE: Having issues trying to get the OSD up on a MIPS64!!!
> 
> Sage,
> 
> Good news, I am able to create the OSD successfully, let's see what's in store next.
> 
> It was an issue with  leveldb1.17 not having  either memory barrier or atomic operation support for DEBIAN MIPS???
> Not even the latest version leveldb1.18  I pulled from https://github.com/google/leveldb.
> 
> But this link  talks about that https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=681945
> 
> So, I ported over the memory barrier/atomic fix for MIPS onto leveldb1.17... I had to look into the mips/barrier.h files on our eval board, to make sure We had the correct macros.
> 
> Now, my osd creation is successful on the MIPS, created object store /var/lib/ceph/osd/ceph-0 journal /dev/sda2 for osd.0 fsid f615496c-b40a-4905-bbcd-2d3e181ff21a
> I have to start looking into the CLIENT/MONITOR side to make sure everything is good.
> 
> Really thankful for your suggestions for this quick resolution, for now we are good, untill the next and then the next......
> 
> Thanks
> Prashanth
> 
> -----Original Message-----
> From: Prashanth Nednoor
> Sent: Sunday, October 26, 2014 7:32 PM
> To: 'Sage Weil'; Philip Kufeldt
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: Having issues trying to get the OSD up on a MIPS64!!!
> 
> Hi Sage,
> 
> Leveldb version is 1.17.
> 
> Thanks
> Prashanth
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Friday, October 24, 2014 6:11 PM
> To: Philip Kufeldt
> Cc: Prashanth Nednoor; ceph-devel@vger.kernel.org
> Subject: RE: Having issues trying to get the OSD up on a MIPS64!!!
> 
> On Sat, 25 Oct 2014, Philip Kufeldt wrote:
> > 64 bit big endian
> 
> My guess is that there is an endianness bug in leveldb then.  I wonder who else has tried it on MIPS?
> 
> sage
> 
> 
> > 
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@newdream.net]
> > > Sent: Friday, October 24, 2014 5:47 PM
> > > To: Prashanth Nednoor
> > > Cc: ceph-devel@vger.kernel.org; Philip Kufeldt
> > > Subject: RE: Having issues trying to get the OSD up on a MIPS64!!!
> > > 
> > > Hi Prashanth,
> > > 
> > > On Fri, 24 Oct 2014, Prashanth Nednoor wrote:
> > > > Hi Sage,
> > > >
> > > > Thank you for the prompt response.
> > > > Is there anything in /dev/disk/by-partuuid/ or is it missing entirely?
> > > >   Nothing , it was Missing Entirely.
> > > >   GOOD NEWS:  I worked around  this issue, if I set my journal 
> > > > path in the
> > > /etc/ceph.conf.
> > > >
> > > > My udev version is udevd --version 164
> > > 
> > > Hmm, that should be new enough, but it seems like it isn't setting 
> > > up the links.  What distro is it?  On most systems it's
> > > /lib/udev/rules.d/60-persistent- storage.rules that does it.  Maybe 
> > > see if running partprobe /dev/sda or run 'udevadm monitor' and do 
> > > 'udevadm trigger /dev/sda' in another terminal to see what happens.
> > > 
> > > Or, work around it like you did. :)
> > > 
> > > > I still see the segfaults, I have attached details.
> > > > I put the osd debug logs(osd-output.txt) and the
> > > leveldb_bt(leveldb_bt.txt).
> > > > Looks like we have an issue in leveldb....
> > > 
> > > Yeah, that looks like a problem with leveldb.  What distro is this?  
> > > What version leveldb?
> > > 
> > > I don't actually know anything about MIPS.. what's teh wordsize and 
> > > endianess?
> > > 
> > > sage
> > > 
> > > 
> > > >
> > > > HERE IS THE BACK TRACE: I have attached the gdb before running it.
> > > > #0  0x77f68ee0 in leveldb::SkipList<char const*, 
> > > > leveldb::MemTable::KeyComparator>::FindGreaterOrEqual(char const* 
> > > > const&, leveldb::SkipList<char const*,
> > > > leveldb::MemTable::KeyComparator>::Node**) const () from
> > > > /usr/local/lib/libleveldb.so.1
> > > > #1  0x77f69054 in leveldb::SkipList<char const*, 
> > > > leveldb::MemTable::KeyComparator>::Insert(char const* const&) () 
> > > > from
> > > > /usr/local/lib/libleveldb.so.1
> > > > #2  0x77f68618 in leveldb::MemTable::Add(unsigned long long,
> > > leveldb::ValueType, leveldb::Slice const&, leveldb::Slice const&) ()
> > > >    from /usr/local/lib/libleveldb.so.1
> > > > #3  0x77f7e434 in leveldb::(anonymous
> > > namespace)::MemTableInserter::Put(leveldb::Slice const&, 
> > > leveldb::Slice
> > > const&) ()
> > > >    from /usr/local/lib/libleveldb.so.1
> > > > #4  0x77f7e93c in
> > > > leveldb::WriteBatch::Iterate(leveldb::WriteBatch::Handler*) const
> > > > () from /usr/local/lib/libleveldb.so.1
> > > > #5  0x77f7eb8c in
> > > > leveldb::WriteBatchInternal::InsertInto(leveldb::WriteBatch
> > > > const*,
> > > > leveldb::MemTable*) () from /usr/local/lib/libleveldb.so.1
> > > > #6  0x77f59360 in leveldb::DBImpl::Write(leveldb::WriteOptions
> > > > const&,
> > > > leveldb::WriteBatch*) () from /usr/local/lib/libleveldb.so.1
> > > > #7  0x00a5dda0 in LevelDBStore::submit_transaction_sync
> > > > (this=0x1f77d10, t=<value optimized out>) at
> > > > os/LevelDBStore.cc:146
> > > > #8  0x00b0d344 in DBObjectMap::sync (this=0x1f7af28, oid=0x0,
> > > > spos=0x72cfe3b8) at os/DBObjectMap.cc:1126
> > > > #9  0x009b10b8 in FileStore::_set_replay_guard (this=0x1f72450, 
> > > > fd=17, spos=..., hoid=0x0, in_progress=false) at
> > > > os/FileStore.cc:2070
> > > > #10 0x009b1c0c in FileStore::_set_replay_guard (this=0x1f72450,
> > > cid=DWARF-2 expression error: DW_OP_reg operations must be used 
> > > either alone or in conjuction with DW_OP_piece.
> > > > ) at os/FileStore.cc:2047
> > > > #11 0x009b2138 in FileStore::_create_collection (this=0x1f72450,
> > > > c=DWARF-
> > > 2 expression error: DW_OP_reg operations must be used either alone 
> > > or in conjuction with DW_OP_piece.
> > > > ) at os/FileStore.cc:4753
> > > > #12 0x009e42a8 in FileStore::_do_transaction (this=0x1f72450, 
> > > > t=..., op_seq=<value optimized out>, trans_num=0,
> > > > handle=0x72cfec3c) at
> > > > os/FileStore.cc:2413
> > > > #13 0x009eb47c in FileStore::_do_transactions (this=0x1f72450, 
> > > > tls=..., op_seq=2, handle=0x72cfec3c) at os/FileStore.cc:1952
> > > > #14 0x009eb858 in FileStore::_do_op (this=0x1f72450, 
> > > > osr=0x1f801b8,
> > > > handle=...) at os/FileStore.cc:1761
> > > > #15 0x00c8f0bc in ThreadPool::worker (this=0x1f72cf0,
> > > > wt=0x1f7ea90) at
> > > > common/WorkQueue.cc:128
> > > > #16 0x00c91b94 in ThreadPool::WorkThread::entry() ()
> > > > #17 0x77f1c0a8 in start_thread () from /lib/libpthread.so.0
> > > > #18 0x777c1738 in ?? () from /lib/libc.so.6
> > > >
> > > > Do  I need to set any variable to set the cache size etcetc in ceph.conf.
> > > > I only have osd_leveldb_cache_size=5242880 for now.
> > > >
> > > >
> > > > Thanks
> > > > Prashanth
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sage@newdream.net]
> > > > Sent: Thursday, October 23, 2014 5:54 PM
> > > > To: Prashanth Nednoor
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: Re: Having issues trying to get the OSD up on a MIPS64!!!
> > > >
> > > > Hi Prashanth,
> > > >
> > > > On Thu, 23 Oct 2014, Prashanth Nednoor wrote:
> > > > > Hello Everyone,
> > > > >
> > > > > We are using ceph-0.86, good news is we were able to compile and 
> > > > > load all the libraries and binaries needed to configure a 
> > > > > CEPH-OSD on MIPS
> > > > > 64 platform. The CEPH monitor is also able to detect the OSD, 
> > > > > but not up yet, as the osd activate failed.
> > > > > Since we don?t have the required CEPH deploy utility for MIPS64, 
> > > > > we are following the manual procedure to create and activate an OSD.
> > > > > We have disabled authentication between the clients and the 
> > > > > OSD?s for now.
> > > > >
> > > > > Has any body tried CEPH on a MIPS64?
> > > > > /dev/sda is a 2TB local hard drive.
> > > > >
> > > > > This is how my partition looks after ceph-disk-prepare 
> > > > > /home/prashan/ceph-0.86/src# parted GNU Parted 2.3 Using 
> > > > > /dev/sda Welcome to GNU Parted! Type 'help' to view a list of commands.
> > > > > (parted) p
> > > > > Model: ATA TOSHIBA MQ01ABB2 (scsi) Disk /dev/sda: 2000GB Sector 
> > > > > size (logical/physical): 512B/4096B Partition Table: gpt
> > > > >
> > > > > Number  Start   End     Size    File system  Name          Flags
> > > > >  2      1049kB  5369MB  5368MB               ceph journal
> > > > >  1      5370MB  2000GB  1995GB  xfs          ceph data
> > > > >
> > > > >
> > > > >
> > > > > The following are the steps to create an OSD
> > > > > 1)	ceph-disk zap /dev/sda
> > > > > 2)	ceph-disk-prepare --cluster  f615496c-b40a-4905-bbcd-
> > > > > 2d3e181ff21a --fs-type xfs /dev/sda
> > > > > 3)	mount /dev/sda1 /var/lib/ceph/osd/ceph-0/
> > > > > 4)	ceph-osd -i 0 ?mkfs is giving an error ,
> > > > > filestore(/var/lib/ceph/osd/ceph-0) could not find
> > > > > 23c2fcde/osd_superblock/0//-1 in index: (2) No such file.
> > > > > After this it segfaults. We have analyzed this further with the 
> > > > > help of strace and root caused this as objectmap file reading issue.
> > > > > open("/var/lib/ceph/osd/ceph-0/current/omap/000005.log",
> > > > > O_RDONLY)
> > > =
> > > > > 11, the first time it reads 32k, the read succeeds with 63 bytes 
> > > > > and it tries to read again with 27k and the read returns 0 bytes 
> > > > > and the CEPH osd segfaults.
> > > >
> > > > Can you generate a full log with --debug-osd 20 --debug-filestore
> > > > 20 --
> > > debug-jouranl 20 passed to ceph-osd --mkfs and post that somewhere?  
> > > It should tell us where things are going wrong.  In particular, we 
> > > want to see if that file/object is being written properly.  It will 
> > > also have a backtrace showing exactly where it crashed.
> > > >
> > > > > Please note that ceph-disk prepare creates a journal in a path 
> > > > > which is not valid(dev/disk/by-partuuid/cbd4a5d1-012f-4863-b492-
> > > 080ad2a505cb).
> > > > > So after step3 above I remove this journal below and manually 
> > > > > create a journal file before doing step4 above.
> > > > >
> > > > >
> > > > > ls -l /var/lib/ceph/osd/ceph-0/
> > > > > total 16
> > > > > -rw-r--r-- 1 root root 37 Oct 22 21:40 ceph_fsid
> > > > > -rw-r--r-- 1 root root 37 Oct 22 21:40 fsid lrwxrwxrwx 1 root 
> > > > > root
> > > > > 58 Oct 22 21:40 journal -> /dev/disk/by- 
> > > > > partuuid/cbd4a5d1-012f-4863-b492-080ad2a505cb
> > > >
> > > > Is there anything in /dev/disk/by-partuuid/ or is it missing entirely?
> > > > Maybe you have an old udev.  What distro is this?
> > > >
> > > > sage
> > > >
> > > > > -rw-r--r-- 1 root root 37 Oct 22 21:40 journal_uuid
> > > > > -rw-r--r-- 1 root root 21 Oct 22 21:40 magic
> > > > >
> > > > > Any pointers to move ahead will be greatly appreciated??
> > > > >
> > > > > thanks
> > > > > Prashanth
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > > in the body of a message to majordomo@vger.kernel.org More
> > > majordomo
> > > > > info at  http://vger.kernel.org/majordomo-info.html
> > > > >
> > > > >
> > > >
> > 
> > 
> 
