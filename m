From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 13:31:57 +0000
Message-ID: <DB5PR05MB1607E0FC452D4FF419A78542A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
 <20160823112140.GH5955@rskikr.localdomain>
 <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz>
 <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:64784
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753801AbcHXBNq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 21:13:46 -0400
In-Reply-To: <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks for the clarification Nathan,

I am using the updated master branch from https://github.com/ceph/ceph .  A=
nyhow, I don't think the problem is in the file make-debs.sh itself, but in=
 something that is invoked from it regarding make dist with regard to the f=
ile db/slice.cc from rocksdb submodule.

Do you have any idea if someone execute make-debs.sh on the updated ceph ma=
ster branch?

TIA,
  Avner

-----Original Message-----
From: Nathan Cutler [mailto:ncutler@suse.cz]=20
Sent: Tuesday, August 23, 2016 15:59
To: Brad Hubbard; Avner Ben Hanoch=20
Cc: Gregory Farnum; Ceph Development <ceph-devel@vger.kernel.org>
Subject: Re: errors in make-debs.sh because "make dist" fails on 'rocksdb/d=
b/slice.cc'

> That's a different make-deb(s).sh

Allow me to qualify that statement. This thread seems to be about

https://github.com/ceph/ceph/blob/master/make-debs.sh

while the "make-deb.sh" I am working on is

https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages/make-=
deb.sh

which is used with the teuthology-openstack backend. However, I see the two=
 scripts are similar.

In general, although the autotools stuff is still there in master, it is no=
t maintained and should not be expected to work (or continue to work).=20
All build infrastructure targeting master should be converted to cmake.

Nathan
