From: Sage Weil <sage@newdream.net>
Subject: Re: Luminous "upgrade"
Date: Thu, 29 Jun 2017 02:30:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706290229230.3424@piezo.novalocal>
References: <ac2ebcde-f3d1-7706-86bc-8123956314a8@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35473 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdF2CaQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 22:30:16 -0400
In-Reply-To: <ac2ebcde-f3d1-7706-86bc-8123956314a8@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 29 Jun 2017, Willem Jan Withagen wrote:
> Hi,
> 
> I installed the FreeBSD package i build for v12.1.0 but now my cluster
> reports:
> 
>   cluster:
>     id:     6436b2a5-59a5-11e7-b746-0025903744dc
>     health: HEALTH_ERR
>             mds rank 0 has failed
>             mds cluster is degraded
>             all OSDs are running luminous or later but
> require_osd_release < luminous
> 
> However `ceph osd set` only has:
> 	require_jewel_osds|require_kraken_osds
> 
> So I cannot set something luminous....

Do

 ceph osd require-osd-release luminous

sage
