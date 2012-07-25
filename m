From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: Clusters and pools
Date: Wed, 25 Jul 2012 06:48:00 +0000 (UTC)
Message-ID: <juo4r0$ljn$1@dough.gmane.org>
References: <F5955DC568F9AF4DB00BE0F7E950BE0C0E903140@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58944 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2GYGsM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Jul 2012 02:48:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1StvOE-0002WN-B1
	for ceph-devel@vger.kernel.org; Wed, 25 Jul 2012 08:48:10 +0200
Received: from 62-167-2-230.static.adslpremium.ch ([62.167.2.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 08:48:10 +0200
Received: from thomas by 62-167-2-230.static.adslpremium.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 08:48:10 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



Am Wed, 25 Jul 2012 04:34:45 +0000 schrieb Ryan Nicholson:

> I'm running a cluster based on 4 hosts that each have 3 fast, SCSI
> osd's, and 1 very large SATA osd, meaning, 12 fast osd's and 4 slow
> osd's total. I wish to segregate these into 2 pools, that operate
> independently. The goal is to use the faster disks as an area to hold
> rbd based VM's, and the larger area to host rbd-base large volumes (to
> start), and possibly have that become just a big cephfs area once, the
> fs side of things is considered more stable.
> 

slightly another topic, but maybe you could also give TIER try:

http://www.lessfs.com/wordpress/?p=776

http://sourceforge.net/projects/tier/files/

- Thomas

