From: Luis Henriques <lhenriques@suse.com>
Subject: Question regarding struct ceph_timestamp
Date: Tue, 9 May 2017 15:23:31 +0100
Message-ID: <20170509142331.ntm3wuyk2ce6mnui@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754468AbdEIOXe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 May 2017 10:23:34 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AC9CABBD
        for <ceph-devel@vger.kernel.org>; Tue,  9 May 2017 14:23:32 +0000 (UTC)
Received: from localhost (hermes.olymp [local])
        by hermes.olymp (OpenSMTPD) with ESMTPA id c1d56d25
        for <ceph-devel@vger.kernel.org>;
        Tue, 9 May 2017 14:23:31 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

While analysing an xfstest failure (generic/258) I had to look at the
definition of struct ceph_timespec.  And I was surprised to verify that
both its fields (tv_sec and tv_nsec) are 32-bits (__le32).  And I believe
that this explains the test failure, as ceph_encode_timespec() would fail
to convert the negative pre-epoch value (-315615540 => 3979351756).

The failure can be easily reproduced by simply creating a test file in a
cephfs mount with:

 $ touch -t 196001010101 /mnt/testfile
 $ ls -l /mnt/testfile
 -rw-r--r-- 1 root 0 0 Jan  1  1960 testfile

After remounting the filesystem:

 $ ls -l /mnt/testfile
 -rw-r--r-- 1 root 0 0 Feb  6  2096 testfile

Am I missing something?  If I'm not (and I probably am!), this isn't just
a client-side issue and fixing it will require touching several other
parts of the code.

Cheers,
--
Luís
