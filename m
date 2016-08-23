From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: errors in make-debs.sh because "make dist" fails on
 'rocksdb/db/slice.cc'
Date: Tue, 23 Aug 2016 15:33:51 +0200
Message-ID: <a48780cc-bfbf-7b24-32b9-0cd3581b00df@suse.cz>
References: <DB5PR05MB1607C4B81D5433484A17801FA9E80@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CAJ4mKGYP+9TQ8wT-eUH1WkgwqXY3z2uF+3WFtpK8BRFNF9VWBw@mail.gmail.com>
 <DB5PR05MB160736C8DBCC82350BE98385A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <20160823110125.GG5955@rskikr.localdomain>
 <20160823112140.GH5955@rskikr.localdomain>
 <cb68488d-2c92-b0dd-cda4-92d3ea149b22@suse.cz>
 <e367df5c-5995-25dd-fc0b-b5096d757edf@suse.cz>
 <DB5PR05MB1607E0FC452D4FF419A78542A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757265AbcHWNfh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 09:35:37 -0400
In-Reply-To: <DB5PR05MB1607E0FC452D4FF419A78542A9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>, Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

> Thanks for the clarification Nathan,
>
> I am using the updated master branch from https://github.com/ceph/ceph .  Anyhow, I don't think the problem is in the file make-debs.sh itself, but in something that is invoked from it regarding make dist with regard to the file db/slice.cc from rocksdb submodule.
>
> Do you have any idea if someone execute make-debs.sh on the updated ceph master branch?

AFAIK you are the first to try it on master.

Since the script uses autotools (not cmake) to do the build, it is not 
expected to work on master. IMO the script needs to be modified.
