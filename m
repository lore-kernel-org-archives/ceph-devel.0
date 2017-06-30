From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 14:42:19 +0200
Message-ID: <4c4f980f-f60b-9b9d-fb28-10d34b09ed95@suse.cz>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57831 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbdF3MmV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Jun 2017 08:42:21 -0400
In-Reply-To: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

> The easiest thing is to
> 
> 1/ Stop testing filestore+btrfs for luminous onward.  We've recommended
> against btrfs for a long time and are moving toward bluestore anyway.
> 
> 2/ Leave btrfs in the mix for jewel, and manually tolerate and filter out
> the occasional ENOSPC errors we see.  (They make the test runs noisy but
> are pretty easy to identify.)

I'm fine with this, having learned how to identify these failures.

Nathan
