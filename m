From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: service ceph vs. /etc/init.d/ceph
Date: Thu, 8 Jul 2010 19:59:10 +0000 (UTC)
Message-ID: <i15ame$og4$1@dough.gmane.org>
References: <i14p03$hn$5@dough.gmane.org>
	<1278602038.2253.24.camel@wido-laptop.pcextreme.nl>
	<i14qoh$hn$7@dough.gmane.org>
	<AANLkTik1943swfYSA5qyzFCxU_1_RhCQFcCx4sfh3_EJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45715 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758560Ab0GHT7V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jul 2010 15:59:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWxFe-00033Z-S3
	for ceph-devel@vger.kernel.org; Thu, 08 Jul 2010 21:59:18 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 21:59:18 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jul 2010 21:59:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 08 Jul 2010 16:42:30 +0100 schrieb Miguel F Mascarenhas Sousa
Filipe:

> Regarding this, I had a problem with installing ceph from source on a
> non-debian derived, nor redhat derived distro (it's mandriva derived).
> make install doesn't seem to install any init/startup script.

what's your distro? did you try to build the rpm's with the ceph.spec 
file? 


