From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: Replacing DRBD use with RBD
Date: Thu, 6 May 2010 05:10:11 +0000 (UTC)
Message-ID: <hrtivj$1uq$1@dough.gmane.org>
References: <582033.76293.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35886 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab0EFFKV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 01:10:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1O9tLo-0007yJ-GI
	for ceph-devel@vger.kernel.org; Thu, 06 May 2010 07:10:20 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 06 May 2010 07:10:20 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 06 May 2010 07:10:20 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


>> There is a heartbeat mechanism withing the mon cluster, and it's being
>> used for the monitors to keep track of their peer status. It might be a
>> good idea to add different configurable types of heartbeats.
> 
> Yes, specifically, I meant by using some of the techniques that the
> heartbeat project uses:
> 
> http://www.linux-ha.org/wiki/Heartbeat
> 
> Ideally (my suggestion,) they would make some of them available in a
> library so that other projects like RADOS could use them independently
> without having to rewrite them from scratch.

IMHO Heartbeat is not developed anymore. the new thing (some parts 
derived from Heartbeat) is pacemaker/corosync . It is/will be standard on 
RH (Fedora,EL), SuSE , Ubuntu and Debian.

I'm not a developter but IMHO ceph could(/should?) take advantage from 
these projects to not reinvent the wheel. ;)

- Thomas

* http://www.clusterlabs.org
* http://en.wikipedia.org/wiki/Corosync_%28project%29
* http://www.openais.org

