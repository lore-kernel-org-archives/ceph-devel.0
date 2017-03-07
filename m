From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] block: Move bdi_unregister() to del_gendisk()
Date: Tue, 7 Mar 2017 13:24:55 +0300
Message-ID: <20170307102401.GA4120@mwanda>
References: <20170307001322.GA28752@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:29844 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbdCGK2H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Mar 2017 05:28:07 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v27AQN26031794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <ceph-devel@vger.kernel.org>; Tue, 7 Mar 2017 10:26:23 GMT
Content-Disposition: inline
In-Reply-To: <20170307001322.GA28752@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jack@suse.cz
Cc: ceph-devel@vger.kernel.org

Also:

    arch/powerpc/sysdev/axonram.c:277 axon_ram_probe()
    error: we previously assumed 'bank->disk->queue' could be null (see line 231)

regards,
dan carpenter
