From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: MonitorStore.cc assert
Date: Wed, 11 Aug 2010 17:40:25 +0000 (UTC)
Message-ID: <i3una9$gdc$2@dough.gmane.org>
References: <14C7F4F06DB5814AB0DE29716C4F6D670C562AB6@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40777 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab0HKRkj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Aug 2010 13:40:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OjFI1-0005L3-35
	for ceph-devel@vger.kernel.org; Wed, 11 Aug 2010 19:40:33 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Aug 2010 19:40:33 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Aug 2010 19:40:33 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 11 Aug 2010 09:06:14 +0200 schrieb Smets, Jan (Jan):

> I was not using ceph at that time, and my clocks are drifting somehow
> ...
> 
> Last logs seen:
> 
> 10.08.10_22:55:02.051810 7fdbdaac9710 log [WRN] : lease_expire from mon0
> was sent from future time 10.08.10_22:55:03.346407, clocks not
> synchronized ...

maybe not related to the problem, but also important:

do run a ntpd on every osd/mon/mds as there is a need for precise 
syncronised time. 

- Thomas

