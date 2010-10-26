From: Christian Brunner <chb@muc.de>
Subject: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
Date: Tue, 26 Oct 2010 14:13:35 +0200
Message-ID: <AANLkTikqk0KDAKRt=ED4-HCzKiUw9jhew+tyaZe1TGOM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56639 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab0JZMNg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 08:13:36 -0400
Received: by gwj21 with SMTP id 21so3209578gwj.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Oct 2010 05:13:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When accessing multiple RBD-Volumes from one VM in parallel, we are
receiving an assertion:

./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
2: /usr/lib64/librados.so.1() [0x3865855dc9]
3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,
ceph::buffer::list const&, unsigned long,
RadosClient::AioCompletion*)+0x24b) [0x386585724b]
4: (rados_aio_write()+0x9a) [0x386585741a]
5: /usr/bin/qemu-kvm() [0x45a305]
6: /usr/bin/qemu-kvm() [0x45a430]
7: /usr/bin/qemu-kvm() [0x43bb73]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
2: /usr/lib64/librados.so.1() [0x3865855dc9]
3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,
ceph::buffer::list const&, unsigned long,
RadosClient::AioCompletion*)+0x24b) [0x386585724b]
4: (rados_aio_write()+0x9a) [0x386585741a]
5: /usr/bin/qemu-kvm() [0x45a305]
6: /usr/bin/qemu-kvm() [0x45a430]
7: /usr/bin/qemu-kvm() [0x43bb73]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'
*** Caught signal (ABRT) ***
ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (sigabrt_handler(int)+0x91) [0x3865922b91]
2: /lib64/libc.so.6() [0x3c0c032a30]
3: (gsignal()+0x35) [0x3c0c0329b5]
4: (abort()+0x175) [0x3c0c034195]
5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3c110beaad]

This is reproducible by doing the following inside a VM:

# mkfs.btrfs /dev/vdb /dev/vdc /dev/vdd /dev/vde
# mount /dev/vdb /mnt
# cd /mnt
# bonnie++ -u root -d /mnt -f

Any hints are welcome...

Thanks,

Christian
