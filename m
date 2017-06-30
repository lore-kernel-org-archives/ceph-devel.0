From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - core
Date: Fri, 30 Jun 2017 14:21:52 +0200
Message-ID: <9cade684-1f16-487d-d9fc-057522db1dee@suse.cz>
References: <9e7edca0-d56a-2315-9098-94dab50db691@suse.cz>
 <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
 <6663b229-6570-1d2c-1c2f-2ebf5105173f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56111 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751545AbdF3MVy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Jun 2017 08:21:54 -0400
In-Reply-To: <6663b229-6570-1d2c-1c2f-2ebf5105173f@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi again Josh:

Here comes the recap of 10.2.8 status. All requested PRs have been 
merged, so I ran a "rados" suite and an "upgrade/hammer-x" suite. There 
were some failures, but most were obvious infrastructure noise and 
disappeared on re-run. There were also two failures that stood out and 
seemed like they might be real bugs:

[1] rados issue: http://tracker.ceph.com/issues/20449
[2] upgrade issue: http://tracker.ceph.com/issues/13381

Regarding [1], my initial analysis was wrong. The real cause of the 
failure is a transient gevent/greenlet timeout; happens in about 40% of 
the runs.

Regarding [2], Sage analyzed the initial failure in the tracker. I 
re-ran the test on both smithi and vps with the following results:

* on vps, both jobs passed
* on smithi, one job passed and the other failed. However, the failure 
was for a different reason ("ceph-objectstore-tool: exp list-pgs failure 
with status 1") - see 
http://pulpito.front.sepia.ceph.com/smithfarm-2017-06-30_09:08:18-upgrade:hammer-x-wip-jewel-backports-distro-basic-smithi/
* http://tracker.ceph.com/issues/13381 was not reproduced

What other testing do you think is needed before we send 10.2.8 to QE?

Nathan
