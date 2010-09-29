From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: multi-mds hangs on bonnie++ test
Date: Wed, 29 Sep 2010 06:38:44 +0000 (UTC)
Message-ID: <i7umtk$gtb$1@dough.gmane.org>
References: <i7qf66$644$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35500 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab0I2Gi4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Sep 2010 02:38:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1P0qJY-0006mu-Gd
	for ceph-devel@vger.kernel.org; Wed, 29 Sep 2010 08:38:52 +0200
Received: from trillian.muellerit.ch ([83.169.22.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Sep 2010 08:38:52 +0200
Received: from thomas by trillian.muellerit.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Sep 2010 08:38:52 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mon, 27 Sep 2010 16:02:14 +0000 schrieb Thomas Mueller:

> hi
> 
> encouraged by the roadmap mail I started my tests with CEPH_NUM_MDS=3
> (mon,osd: just one instance). OS is Debian Squeeze with kernel 2.56.35.4

omg, I was testing on master not on unstable... please ignore.

- Thomas

