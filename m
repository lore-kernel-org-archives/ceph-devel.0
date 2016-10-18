From: Willem Jan Withagen <wjw@digiware.nl>
Subject: inconsistent problem....
Date: Tue, 18 Oct 2016 15:07:54 +0200
Message-ID: <851ba931-f1c8-dc23-7cc4-822efb2c6cab@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:12322 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759960AbcJRNH7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Oct 2016 09:07:59 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id BE9F72BAA7
        for <ceph-devel@vger.kernel.org>; Tue, 18 Oct 2016 15:07:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I have all tests up and running on my development box.
So I build a Jenkins instance to do regular testing.

But there readable.sh consistently fails with errors like the one below.
However it is not always on the smae file, and comparing files with
those in the repo shows that they are equal.

Anybody a suggestion of what is going wrong here?
Memory corruption coudl be one, but then I'd expect other type of
failures as well.

--WjW

 /usr/local/jenkins/workspace/ceph-freebsd/src/test/encoding/readable.sh: line 104: 45887 Abort trap              (core dumped) $CEPH_DENCODER type $type import $vdir/objects/$type/$f decode dump_json > $tmp1
75: **** failed to decode
/usr/local/jenkins/workspace/ceph-freebsd/ceph-object-corpus/archive/0.52/objects/ObjectStore::Transaction/c46fcf6ab50f20c159da635e80a21382
****
75: /usr/local/jenkins/workspace/ceph-freebsd/src/os/Transaction.cc: In
function 'void ObjectStore::Transaction::_build_actions_from_tbl()'
thread aef8000 time 2016-10-18 12:35:36.204693
75: /usr/local/jenkins/workspace/ceph-freebsd/src/os/Transaction.cc:
343: FAILED assert(0 == "collection attr methods have been removed")
75:  ceph version Development (no_version)
75:  1: 0x1a03098 <_ZN4ceph18__ceph_assert_failEPKcS1_iS1_+0x4e8> at
/usr/local/jenkins/workspace/ceph-freebsd/build/bin/ceph-dencoder
75:  2: 0x11593d2
<_ZN11ObjectStore11Transaction23_build_actions_from_tblEv+0x1802> at
/usr/local/jenkins/workspace/ceph-freebsd/build/bin/ceph-dencoder
75:  3: 0x1163052 <_ZN11ObjectStore11Transaction5beginEv+0x32> at
/usr/local/jenkins/workspace/ceph-freebsd/build/bin/ceph-dencoder
75:  4: 0x1159dd1
<_ZN11ObjectStore11Transaction4dumpEPN4ceph9FormatterE+0x51> at
/usr/local/jenkins/workspace/ceph-freebsd/build/bin/ceph-dencoder
75:  5: 0xe9eb21
<_ZN12DencoderBaseIN11ObjectStore11TransactionEE4dumpEPN4ceph9FormatterE+0x21>
at /usr/local/jenkins/workspace/ceph-freebsd/build/bin/ceph-dencoder
75:  6: 0xd2f278 <main+0x18838> at
/usr/local/jenkins/workspace/ceph-freebsd/build/bin/ceph-dencoder
75:  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
75: /usr/local/jenkins/workspace/ceph-freebsd/src/os/Transaction.cc: In
function 'void ObjectStore::Transaction::_build_actions_from_tbl()'
thread aef8000 time 2016-10-18 12:35:36.211442

