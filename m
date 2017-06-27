From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - core
Date: Tue, 27 Jun 2017 21:56:41 +0200
Message-ID: <2e34d6e0-2024-a2e7-f74f-cc84ee5829a4@suse.cz>
References: <9e7edca0-d56a-2315-9098-94dab50db691@suse.cz>
 <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39779 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753282AbdF0T4o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 15:56:44 -0400
In-Reply-To: <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> Do you think it's time for QE to do its testing?
> 
> Could we also include:
> 
> https://github.com/ceph/ceph/pull/14392
> https://github.com/ceph/ceph/pull/15529

Hi again Josh:

Both of the PRs you mentioned are either merged or tested+cleared for 
merge. The upgrade/hammer-x suite is also running nearly clean: 
http://pulpito.front.sepia.ceph.com/smithfarm-2017-06-27_15:24:41-upgrade:hammer-x-wip-jewel-backports-distro-basic-vps/

The two failures appear to be http://tracker.ceph.com/issues/13381 so we 
might have a regression?

I scheduled another rados suite for good measure.

Nathan
