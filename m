From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Fri, 9 Jun 2017 19:16:01 +0300
Message-ID: <20170609161600.GB13741@gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
 <alpine.DEB.2.11.1706091602210.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36312 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdFIQQE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 12:16:04 -0400
Received: by mail-lf0-f42.google.com with SMTP id o83so31636673lff.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jun 2017 09:16:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1706091602210.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Fri, Jun 09, 2017 at 04:07:15PM +0000, Sage Weil wrote:

> This neatly avoids the systemd limitations for all but the most 
> adventuresome admins and avoid the more common case of an admin falling 
> into the "oh, I can name my cluster? cool! [...] oh, i have to add 
> --cluster rover to every command? ick!" trap.

"... oh, I can add --cluster to CEPH_ARGS. cool!" :-)

-- 
Mykola Golub
