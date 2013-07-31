From: Haomai Wang <haomaiwang@gmail.com>
Subject: Blueprint:  Add LevelDB support to ceph cluster backend store
Date: Wed, 31 Jul 2013 11:10:38 +0800
Message-ID: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51953 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3GaDKn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 23:10:43 -0400
Received: by mail-pd0-f177.google.com with SMTP id u10so129964pdi.8
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 20:10:43 -0700 (PDT)
Received: from [10.96.24.99] (notes4.com. [106.187.36.73])
        by mx.google.com with ESMTPSA id s5sm86213341pbo.38.2013.07.30.20.10.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 20:10:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Every node of ceph cluster has a backend filesystem such as btrfs,
xfs and ext4 that provides storage for data objects, whose location
are determined by CRUSH algorithm. There should exists an abstract
interface sitting between osd and backend store, allowing different
backend store implementation. Currently, we only have general 
POSIX interface. LevelDB is a fast key-value storage library written at 
Google that provides an ordered mapping from string keys to string 
values. We could implement a LevelDB backend to support base 
operations correspond to POSIX operations.  LevelDB driver enables 
gateway to communicate with LevelDB to store objects on the node 
basis.


LevelDB driver is attractive by the folks who own a special use case 
such as a write-heave system. If we can abstract a general interface, 
we can choose other DBM if you find it more suitable, such as Kyoto 
Cabinet, BDB. Futhermore, we can choose backen store for each OSD
node. So we have different OSD type for special purpose.

Expected Results: Objects can be stored reliably to LevelDB. The IO 
performance and recovery process can be comparable to original 
stores. And for special case, LevelDB driver should have much better 
performance than local filesystem backend driver. The snapshot and
any features you think of are optional.

Best regards,
Wheats



