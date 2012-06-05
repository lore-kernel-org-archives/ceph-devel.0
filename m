From: chandrashekhar <chandubigc@gmail.com>
Subject: Re: OSD per disk.
Date: Tue, 5 Jun 2012 12:34:23 +0000 (UTC)
Message-ID: <loom.20120605T142846-305@post.gmane.org>
References: <loom.20120528T080903-621@post.gmane.org> <1c048abb-0cbb-4d69-9922-419c16019887@mailpro> <loom.20120528T111434-469@post.gmane.org> <CADvuQREMRQtBv2NhM_QH0A_-mFE5wRGPVMHk0Wu7jhUvgXjcYQ@mail.gmail.com> <CA+7V1=Ey224p64Wo0172OrTTiA0sbg9x_13aJwRvBr7VRySHbQ@mail.gmail.com> <CADvuQRHzTy+Kvhah7sop6fdSvhYvA63ZNXBkntukmYLD_ejbVA@mail.gmail.com> <CA+4uBUY+qq0x81wg=Qom70ttAX4f-bwkDH=H5o6rPHdvpFgFuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46809 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab2FEMee (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jun 2012 08:34:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Sbsxz-0003Am-Tj
	for ceph-devel@vger.kernel.org; Tue, 05 Jun 2012 14:34:32 +0200
Received: from segment-124-30.sify.net ([segment-124-30.sify.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 14:34:31 +0200
Received: from chandubigc by segment-124-30.sify.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 14:34:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>>
I built ceph from source ( f859f25d7eaec01fb6a82b88409d005c8177fea2  branch).

mkcephfs -a -c /etc/ceph/ceph.conf  -k /etc/ceph/keyring.admin -- is working
fine, but when I tried to start ceph its showing following error.

>strace ceph -a start

rt_sigprocmask(SIG_SETMASK, [PIPE], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [PIPE], [PIPE], 8) = 0
mmap(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK,
-1, 0) = 0x7f1cc5a49000
mprotect(0x7f1cc5a49000, 4096, PROT_NONE) = 0
clone(child_stack=0x7f1cc6248f70,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM
|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f1cc62499d0, tls=0x7f1cc6249700, 
child_tidptr=0x7f1cc62499d0) =
21042
rt_sigprocmask(SIG_SETMASK, [PIPE], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [PIPE], [PIPE], 8) = 0
mmap(NULL, 1052672, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK,
-1, 0) = 0x7f1ccaa98000
mprotect(0x7f1ccaa98000, 4096, PROT_NONE) = 0
clone(child_stack=0x7f1ccab97f70,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f1ccab989d0, tls=0x7f1ccab98700, child_tidptr=0x7f1ccab989d0) =
21043
rt_sigprocmask(SIG_SETMASK, [PIPE], NULL, 8) = 0
futex(0x201b904, FUTEX_WAIT_PRIVATE, 1, NULL




