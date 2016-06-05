From: Sage Weil <sage@newdream.net>
Subject: RE: Bluestore crash in mkfs
Date: Sat, 4 Jun 2016 22:36:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606042235220.6221@cpach.fuggernut.com>
References: <BL2PR02MB21151DAE1DAF64B6CC74D01FF45A0@BL2PR02MB2115.namprd02.prod.outlook.com> <CAB=cV2Tp9ASRHxLSw5H3K=4PbrxrFkF4sARsfDRxDVqJpQ8ZHg@mail.gmail.com> <BL2PR02MB2115840732283AC0927974AEF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-961266820-1465094174=:6221"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58977 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbcFECfr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Jun 2016 22:35:47 -0400
In-Reply-To: <BL2PR02MB2115840732283AC0927974AEF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Jianjian Huo <samuel.huo@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-961266820-1465094174=:6221
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 4 Jun 2016, Somnath Roy wrote:
> Same conf file worked for me sometimes back. I think db path/wal path is optional and if you don't mention anything, it will coexist on the block partition.
> Not sure if this is something changed recently though..
> The trace is also not complaining about db path , it is getting a seg fault while parsing rocksdb option. 

Hmm, I haven't seen this.

Note that you don't need 'devs'.  And you're right that just specifying 
the block path is enough.  If you're doing a manual build, is it 
possible you're dynamically linking rocksdb or something?

sage

> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Jianjian Huo [mailto:samuel.huo@gmail.com] 
> Sent: Friday, June 03, 2016 9:29 PM
> To: Somnath Roy
> Cc: Sage Weil (sage@newdream.net); ceph-devel
> Subject: Re: Bluestore crash in mkfs
> 
> On Fri, Jun 3, 2016 at 7:16 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Sage,
> > Latest code in Bluestore is crashing on me during mkfs. Here is the dump.
> >
> > ceph version 10.2.0-1809-gac8c40f 
> > (ac8c40f3e3257517f71d2af8bd26dcd264887b7f)
> >  1: (()+0x99e65e) [0x55cf5263565e]
> >  2: (()+0x113d0) [0x7f323526f3d0]
> >  3: 
> > (rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Options 
> > const&)+0x59) [0x55cf525d4ce9]
> >  4: (rocksdb::GetOptionsFromString(rocksdb::Options const&, 
> > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > std::allocator<char> > const&, rocksdb::Options*)+0x15a) 
> > [0x55cf525dc74a]
> >  5: 
> > (RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_string<char, 
> > std::char_traits<char>, std::allocator<char> >, 
> > rocksdb::Options&)+0x22e) [0x55cf524f58be]
> >  6: (RocksDBStore::init(std::__cxx11::basic_string<char, 
> > std::char_traits<char>, std::allocator<char> >)+0x77) [0x55cf524f5f17]
> >  7: (BlueStore::_open_db(bool)+0x274) [0x55cf5234b9e4]
> >  8: (BlueStore::mkfs()+0x899) [0x55cf52361ad9]
> >  9: (OSD::mkfs(CephContext*, ObjectStore*, 
> > std::__cxx11::basic_string<char, std::char_traits<char>, 
> > std::allocator<char> > const&, uuid_d, int)+0x117) [0x55cf52001427]
> >  10: (main()+0x1003) [0x55cf51f9f2e3]
> >  11: (__libc_start_main()+0xf0) [0x7f32331fa830]
> >  12: (_start()+0x29) [0x55cf51fe2719]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> >
> >
> > I am using the following option :
> >
> >        devs = /dev/sdb1
> >        bluestore_block_path = /dev/sdb2
> >
> > Am I missing anything ?
> 
> This is what Mark posted last time, you forgot db path?
> https://github.com/ceph/cbt/blob/master/example/bluestore/ceph.conf.bluestore_example
> >
> > Thanks & Regards
> > Somnath
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-961266820-1465094174=:6221--
