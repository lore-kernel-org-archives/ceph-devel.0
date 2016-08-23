From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 13:18:05 +0000
Message-ID: <DB5PR05MB1607F44B510339AA71F00F54A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:47456
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754611AbcHWNcv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 09:32:51 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Oops - submodule rocksdb was changed in ceph after v11.0.0:

master - not working:
rocksdb @ 6797e6f	rocksdb: revert the change introduced by dc41731

v11.0.0 - working:
rocksdb @ 5647fa4	rocksdb: pull up to master


and apparently, *the file 'db/slice.cc' was deleted during that change*
hence, this explains why make dist (that is invoked by ./make-debs.sh) comp=
lains about it
         make[2]: *** No rule to make target 'rocksdb/db/slice.cc', needed =
by 'distdir'.  Stop.

Any idea how to fix this?

TIA,
  Avner


-----Original Message-----
From: Avner Ben Hanoch=20
Sent: Tuesday, August 23, 2016 15:13
To: 'Brad Hubbard'=20
Cc: Gregory Farnum; Ceph Development <ceph-devel@vger.kernel.org>
Subject: RE: errors in make-debs.sh because "make dist" fails on 'rocksdb/d=
b/slice.cc'

Thanks Brad,

Unfortunately, cleaning doesn't help
And anyhow the error occurs even with fresh git clone from the HEAD of ceph=
 master (that brings with it fresh submodules)

AFAICU, the SHA1 of src/rocksdb is identical (for both workingv11.0.0  and =
not working HEAD of master) In both cases, I see: SHA1=3D6797e6f Avoid upda=
ting memtable allocated bytes if write_buffer_size is not set (which is als=
o the latest commit in https://github.com/ceph/rocksdb)

Avner

-----Original Message-----
From: Brad Hubbard
Sent: Tuesday, August 23, 2016 14:01
To: Avner Ben Hanoch
Cc: Gregory Farnum; Ceph Development <ceph-devel@vger.kernel.org>
Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksdb/d=
b/slice.cc'


You could try changing to src/rocksdb and running "make clean" and "git cle=
an -fdx" and retrying the build. It's possible some build artefact was left=
 over in that submodule's directory structure for that commit. You could al=
so compare the
SHA1 of the src/rocksdb submodule in each case (workingv11.0.0  and not wor=
king) and see what changed between them.

--
HTH,
Brad

