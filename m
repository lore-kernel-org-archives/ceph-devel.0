From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: simple performance tests
Date: Fri, 18 Jun 2010 08:10:34 +0000 (UTC)
Message-ID: <hvf9lq$lik$1@dough.gmane.org>
References: <hva4nu$2nr$1@dough.gmane.org>
	<AANLkTikactG3sjz7mwC1620jM19_6N6W3IPTrbgmIpvr@mail.gmail.com>
	<hvcnpj$5tm$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49222 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab0FRIKr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Jun 2010 04:10:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPWew-0000hC-I8
	for ceph-devel@vger.kernel.org; Fri, 18 Jun 2010 10:10:42 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jun 2010 10:10:42 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jun 2010 10:10:42 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 17 Jun 2010 08:53:07 +0000 schrieb Thomas Mueller:

> Am Wed, 16 Jun 2010 07:45:47 -0700 schrieb Gregory Farnum:
> 
>> How's your CPU utilization on that processor? It'd be good if all those
>> daemons ran fine on an Atom but I'm not sure?
> 
> I'll do some load monitoring and post the results.

I getting used to atop - nice tool to have a summary of what's going on.

it showed that cmds ate 50% of the cpu power.

i've started the MDS on another computer. with 3 osds (1 disk per osd) 
and journal on a partition (same disk as osd) i get now 47 mb/s in dbench 
10 test (ceph data/metadata size 1) and with "size 2" 31.3649mb/s

dd bs=1M count=8192 gives me 107mb/s ("size 1")

so now ceph outperforms samba. :)

- Thomas

