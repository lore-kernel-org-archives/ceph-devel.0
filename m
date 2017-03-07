From: Jan Kara <jack@suse.cz>
Subject: Re: [bug report] block: Move bdi_unregister() to del_gendisk()
Date: Tue, 7 Mar 2017 11:54:56 +0100
Message-ID: <20170307105456.GD2578@quack2.suse.cz>
References: <20170307001322.GA28752@mwanda>
 <20170307102401.GA4120@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35287 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755153AbdCGOns (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Mar 2017 09:43:48 -0500
Content-Disposition: inline
In-Reply-To: <20170307102401.GA4120@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jack@suse.cz, ceph-devel@vger.kernel.org

On Tue 07-03-17 13:24:55, Dan Carpenter wrote:
> Also:
> 
>     arch/powerpc/sysdev/axonram.c:277 axon_ram_probe()
>     error: we previously assumed 'bank->disk->queue' could be null (see line 231)

So this is real however the error path of axon_ram_probe() looks hosed. You
are not supposed to call del_gendisk() if you did not call
device_add_disk() before and axon_ram_probe() leaks the gendisk structure
because it forgets to call put_disk(). I'll look into fixing this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
