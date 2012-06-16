From: Simon Frerichs | Fremaks GmbH <frerichs@fremaks.de>
Subject: Updating OSD from current stable (0.47-2) to next failed with broken
 filestore
Date: Sat, 16 Jun 2012 15:18:58 +0200
Message-ID: <4FDC87C2.7060000@fremaks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.fremaks.net ([46.19.89.69]:33886 "EHLO mail.fremaks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab2FPNTD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 16 Jun 2012 09:19:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.fremaks.net (Postfix) with ESMTP id DDC4839F0F
	for <ceph-devel@vger.kernel.org>; Sat, 16 Jun 2012 15:18:59 +0200 (CEST)
Received: from mail.fremaks.net ([127.0.0.1])
	by localhost (mail.fremaks.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hCdK5EkcXPol for <ceph-devel@vger.kernel.org>;
	Sat, 16 Jun 2012 15:18:59 +0200 (CEST)
Received: from morpheuss-Mac-Pro.local (vpn-46-19-88-242.fremaks.net [46.19.88.242])
	by mail.fremaks.net (Postfix) with ESMTPSA id 50E4F39F0E
	for <ceph-devel@vger.kernel.org>; Sat, 16 Jun 2012 15:18:59 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

i tried updating one of our osds from stable 0.47-2 to latest next 
branch and it started updating the filestore and failed.
After that neither next branch osd nor stable osd would start with this 
filestore anymore.
Is their something wrong with the filestore update?

Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134135 
7ffed3e35780 0 filestore(/data/osd11) mount FIEMAP ioctl is supported 
and appears to work Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 
14:10:03.134163 7ffed3e35780 0 filestore(/data/osd11) mount FIEMAP ioctl 
is disabled via 'filestore fiemap' config option Jun 16 14:10:03 
fcstore01 ceph-osd: 2012-06-16 14:10:03.134476 7ffed3e35780 0 
filestore(/data/osd11) mount did NOT detect btrfs Jun 16 14:10:03 
fcstore01 ceph-osd: 2012-06-16 14:10:03.134485 7ffed3e35780 0 
filestore(/data/osd11) mount syncfs(2) syscall not support by glibc Jun 
16 14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134513 7ffed3e35780 
0 filestore(/data/osd11) mount no syncfs(2), must use sync(2). Jun 16 
14:10:03 fcstore01 ceph-osd: 2012-06-16 14:10:03.134514 7ffed3e35780 0 
filestore(/data/osd11) mount WARNING: multiple ceph-osd daemons on the 
same host will be slow Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 
14:10:03.134551 7ffed3e35780 -1 filestore(/data/osd11) FileStore::mount 
: stale version stamp detected: 2. Proceeding, do_update is set, DO NOT 
USE THIS OPTION IF YOU DO NOT KNOW WHAT IT DOES. More details can be 
found on the wiki. Jun 16 14:10:03 fcstore01 ceph-osd: 2012-06-16 
14:10:03.134585 7ffed3e35780 0 filestore(/data/osd11) mount found snaps 
<> Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.531974 
7ffed3e35780 0 filestore(/data/osd11) mount: enabling WRITEAHEAD journal 
mode: btrfs not detected Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 
14:10:12.543721 7ffed3e35780 1 journal _open /dev/sdb1 fd 18: 
53687091200 bytes, block size 4096 bytes, directio = 1, aio = 0 Jun 16 
14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.588059 7ffed3e35780 1 
journal _open /dev/sdb1 fd 18: 53687091200 bytes, block size 4096 bytes, 
directio = 1, aio = 0 Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 
14:10:12.588905 7ffed3e35780 -1 FileStore is old at version 2. 
Updating... Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 
14:10:12.588914 7ffed3e35780 -1 Removing tmp pgs Jun 16 14:10:12 
fcstore01 ceph-osd: 2012-06-16 14:10:12.594362 7ffed3e35780 -1 Getting 
collections Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 
14:10:12.594369 7ffed3e35780 -1 597 to process. Jun 16 14:10:12 
fcstore01 ceph-osd: 2012-06-16 14:10:12.595195 7ffed3e35780 -1 0/597 
processed Jun 16 14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.595213 
7ffed3e35780 -1 Updating collection omap current version is 0 Jun 16 
14:10:12 fcstore01 ceph-osd: 2012-06-16 14:10:12.662274 7ffed3e35780 -1 
os/FlatIndex.cc: In function 'virtual int 
FlatIndex::collection_list_partial(const hobject_t&, int, int, snapid_t, 
std::vector<hobject_t>*, hobject_t*)' thread 7ffed3e35780 time 
2012-06-16 14:10:12.637479#012os/FlatIndex.cc: 386: FAILED 
assert(0)#012#012 ceph version 0.47.2-500-g1e899d0 
(commit:1e899d08e61bbba0af6f3600b6bc9a5fc9e5c2e9)#012 1: 
/usr/local/bin/ceph-osd() [0x6b337d]#012 2: 
(FileStore::collection_list_partial(coll_t, hobject_t, int, int, 
snapid_t, std::vector<hobject_t, std::allocator<hobject_t> >*, 
hobject_t*)+0x9c) [0x67b24c]#012 3: 
(OSD::convert_collection(ObjectStore*, coll_t)+0x529) [0x5b90e9]#012 4: 
(OSD::do_convertfs(ObjectStore*)+0x46f) [0x5b9b9f]#012 5: 
(OSD::convertfs(std::string const&, std::string const&)+0x47) 
[0x5ba127]#012 6: (main()+0x967) [0x531d07]#012 7: 
(__libc_start_main()+0xfd) [0x7ffed1d8aead]#012 8: 
/usr/local/bin/ceph-osd() [0x5357b9]#012 NOTE: a copy of the executable, 
or `objdump -rdS <executable>` is needed to interpret this.

Simon

