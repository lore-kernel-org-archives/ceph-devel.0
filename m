From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: How to create nova volumes inside rbd pool .
Date: Thu, 27 Sep 2012 06:33:15 +0000 (UTC)
Message-ID: <loom.20120927T083015-790@post.gmane.org>
References: <loom.20120927T064251-722@post.gmane.org> <5063DFC9.5030505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52249 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab2I0Gd0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Sep 2012 02:33:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TH7f8-00024D-4I
	for ceph-devel@vger.kernel.org; Thu, 27 Sep 2012 08:33:30 +0200
Received: from ABTS-KK-dynamic-054.228.172.122.airtelbroadband.in ([ABTS-KK-dynamic-054.228.172.122.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 08:33:30 +0200
Received: from ramu.freesystems by ABTS-KK-dynamic-054.228.172.122.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 08:33:30 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Mick,

  Iam creating nova pool using this command,
rbd --pool nova create --size 1024 testpool.It's creating pool fine,
but i want to create volume inside this pool(testpool).

Thanks,
Ramu.

