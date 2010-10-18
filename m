From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: RE: Assert in mds/Locker.cc
Date: Mon, 18 Oct 2010 17:32:08 +0200
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D670EB35AA6@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
References: <14C7F4F06DB5814AB0DE29716C4F6D670EB35A76@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail5.alcatel.fr ([64.208.49.27]:35825 "EHLO smail5.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328Ab0JRPcI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Oct 2010 11:32:08 -0400
Received: from FRMRSSXCHHUB03.dc-m.alcatel-lucent.com (FRMRSSXCHHUB03.dc-m.alcatel-lucent.com [135.120.45.63])
	by smail5.alcatel.fr (8.14.3/8.14.3/ICT) with ESMTP id o9IFW6vQ018829
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 18 Oct 2010 17:32:06 +0200
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D670EB35A76@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Never mind, I need http://ceph.newdream.net/debian/dists/unstable/main/ instead of unstable/ceph-unstable like described on the wiki.

 

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Smets, Jan (Jan)
Sent: maandag 18 oktober 2010 17:05
To: ceph-devel@vger.kernel.org
Subject: Assert in mds/Locker.cc

I hit the same bug Thomas Mueller saw 3 weeks ago, I'm using the latest Debian unstable packages.

Sage pushed a fix, but I think my debian packages are outdated, arn't they daily built?


mds/Locker.cc: In function 'void Locker::simple_xlock(SimpleLock*)':
mds/Locker.cc:3138: FAILED assert("shouldn't be called if we are already xlockable" == 0)  ceph version 0.22~rc (b9f2816b47f9b118498ed70fd9f4dc54551af4ae)
 1: (Locker::xlock_start(SimpleLock*, MDRequest*)+0x29b) [0x58bfbb]
 2: (Locker::acquire_locks(MDRequest*, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&)+0x1d39) [0x594399]
 3: (Server::handle_client_openc(MDRequest*)+0x484) [0x4da0e4]
 4: (Server::handle_client_request(MClientRequest*)+0x308) [0x4e4128]
 5: (MDS::_dispatch(Message*)+0x2394) [0x4a6294]
 6: (MDS::ms_dispatch(Message*)+0x6d) [0x4a64ad]
 7: (SimpleMessenger::dispatch_entry()+0x729) [0x4806d9]
 8: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x478d0c]
 9: (Thread::_entry_func(void*)+0xa) [0x48b7aa]
 10: (()+0x68ba) [0x7f11936ea8ba]
 11: (clone()+0x6d) [0x7f119269e01d]


- Clean mkcephfs
- Mount
- dd if=/dev/urandom of=/mnt/ceph/dd-file bs=4k count=1

Client: kernel client 2.6.36-rc8
Servers: 0.22~rc-unstable201009291207-b9f2816b-1 with 2.6.36-rc6


Thanks!
 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
