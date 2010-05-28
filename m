From: Thomas Mueller <thomas@chaschperli.ch>
Subject: cmon silently fails if addr is wrong in ceph.conf (0.20.1)
Date: Fri, 28 May 2010 07:47:38 +0000 (UTC)
Message-ID: <htnseq$l6k$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37836 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab0E1Hrt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 May 2010 03:47:49 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OHuIE-00063k-Bq
	for ceph-devel@vger.kernel.org; Fri, 28 May 2010 09:47:46 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 09:47:46 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 09:47:46 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i missconfigured the mon addr in ceph.conf. /etc/init.d/ceph did not show 
any errors - seemd to start. but cmon did not start.

i've "straced" cmon:

bind(6, {sa_family=AF_INET, sin_port=htons(6789), sin_addr=inet_addr
("192.168.32.61")}, 16) = -1 EADDRNOTAVAbind(6, {sa_family=AF_INET, 
sin_port=htons(6789), sin_addr=inet_addr("192.168.32.61")}, 16) = -1 
EADDRNOTAVAIL (Cannot assign requested address)IL (Cannot assign 
requested address)

A descriptive error message would be cool.

- Thomas

