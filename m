From: Sage Weil <sage@newdream.net>
Subject: Re: Proposal to rename ceph-qa-suite project in tracker.ceph.com
Date: Mon, 13 Feb 2017 22:25:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702132224320.7782@piezo.novalocal>
References: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54438 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMWZV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 17:25:21 -0500
In-Reply-To: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 13 Feb 2017, Nathan Cutler wrote:
> Now that ceph-qa-suite has been assimilated into ceph/ceph.git, shall we
> rename http://tracker.ceph.com/projects/ceph-qa-suite ?
> 
> If nobody objects, I'd like to rename it to "tests" so it would cover both
> teuthology tests and make check tests.

Go for it.  I'd say that many of the tests can actually go in the relevant 
projects directly, though; we can use 'tests' for the underlying 
infrastructure (like ceph.py, ceph_manager.py, an so on)?

sage


