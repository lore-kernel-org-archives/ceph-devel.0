From: Nathan Cutler <ncutler@suse.cz>
Subject: Shaman build fails with "reference is not a tree"
Date: Fri, 13 Jan 2017 12:36:24 +0100
Message-ID: <0dc16c42-995c-8623-f2e6-5b69868f8e15@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56917 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbdAMLg1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 13 Jan 2017 06:36:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, "Mick, Dan" <dmick@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Is it me, or is Shaman is acting weird? wip-hammer-backports build 
suddenly fails because:

Submodule 'src/rocksdb' (https://github.com/ceph/rocksdb) registered for 
path 'src/rocksdb'
Cloning into 'src/rocksdb'...
fatal: reference is not a tree: 422e26633267b25c225975b456a9f4fc40091a2e
Unable to checkout '422e26633267b25c225975b456a9f4fc40091a2e' in 
submodule path 'src/rocksdb'

Some googling suggests the following might help:

git submodule sync
git submodule update

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
