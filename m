From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 14:59:13 +0200
Message-ID: <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
 <20160823112140.GH5955@rskikr.localdomain>
 <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754067AbcHWM7S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 08:59:18 -0400
In-Reply-To: <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

> That's a different make-deb(s).sh

Allow me to qualify that statement. This thread seems to be about

https://github.com/ceph/ceph/blob/master/make-debs.sh

while the "make-deb.sh" I am working on is

https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages/make-deb.sh

which is used with the teuthology-openstack backend. However, I see the 
two scripts are similar.

In general, although the autotools stuff is still there in master, it is 
not maintained and should not be expected to work (or continue to work). 
All build infrastructure targeting master should be converted to cmake.

Nathan
