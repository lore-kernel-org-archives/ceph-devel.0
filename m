From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - core
Date: Wed, 28 Jun 2017 12:48:04 +0200
Message-ID: <6663b229-6570-1d2c-1c2f-2ebf5105173f@suse.cz>
References: <9e7edca0-d56a-2315-9098-94dab50db691@suse.cz>
 <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750829AbdF1KsG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Jun 2017 06:48:06 -0400
In-Reply-To: <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Could we also include:
> 
> https://github.com/ceph/ceph/pull/14392
> https://github.com/ceph/ceph/pull/15529

Hi Josh:

All the outstanding PRs earmarked for 10.2.8 (including the two you 
mentioned) have been merged. I ran two final suites:

rados 
http://pulpito.front.sepia.ceph.com:80/smithfarm-2017-06-27_19:13:42-rados-wip-jewel-backports-distro-basic-smithi/
upgrade/hammer-x 
http://pulpito.front.sepia.ceph.com:80/smithfarm-2017-06-27_15:24:41-upgrade:hammer-x-wip-jewel-backports-distro-basic-vps/

Both are looking pretty good, but these runs did identify two issues 
that might be significant:

* the upgrade suite has what appears to be a regression: 
http://tracker.ceph.com/issues/13381
* the rados suite has this bug (possibly RGW-related) that I haven't 
seen before: http://tracker.ceph.com/issues/20449

The rados suite also had six "infrastructure noise" failures which might 
be hiding real bugs. I reran these, but Sepia is down ATM.

Do you think 10.2.8 is ready for QE to start its testing?

Nathan
