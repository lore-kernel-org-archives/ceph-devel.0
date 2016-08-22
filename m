From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Mon, 22 Aug 2016 11:59:36 +0200
Message-ID: <20160822095936.kj4ymayc52cnmbh3@nora.maurer-it.com>
References: <57B698D0.1050409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proxmox.maurer-it.com ([212.186.127.180]:56829 "EHLO
        proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbcHVKKr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 06:10:47 -0400
Received: from proxmox.maurer-it.com (localhost [127.0.0.1])
        by proxmox.maurer-it.com (Proxmox) with ESMTP id DFF38110E04F
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 11:59:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57B698D0.1050409@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Aug 19, 2016 at 07:27:44AM +0200, Loic Dachary wrote:
> Hi Sage,
> 
> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
> 
> Do you think it is time to cut the release and ask QE to start testing ?
> 
> Cheers
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 

We'd like to also see http://tracker.ceph.com/issues/16255 included if
possible, as it currently blocks upgrades to Jewel for existing
installations.

Regards,
Fabian

