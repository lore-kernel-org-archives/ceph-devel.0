From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: Ceph and SL5.5
Date: Sat, 17 Jul 2010 14:22:47 +0000 (UTC)
Message-ID: <i1sebn$mh$1@dough.gmane.org>
References: <EE7C26DD-410B-4169-9EFD-98B6D682B216@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45835 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759954Ab0GQOXD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 17 Jul 2010 10:23:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Oa8I8-0003Mp-FR
	for ceph-devel@vger.kernel.org; Sat, 17 Jul 2010 16:23:00 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jul 2010 16:23:00 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jul 2010 16:23:00 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Sat, 17 Jul 2010 05:12:38 +0100 schrieb effie mouzeli:

> Hello all,
> 
> I am trying to check out how Ceph is doing under Scientific Linux 5.5
> (unfortunately, academia loves SL).
> 
> Currently I am running a cluster of 2 VMs, VM 1 is mon, mds and osd,  VM
> 2 is running osd only, and VM 3 is where I mount ceph.  All VMs  are
> running  SL5.5 x86_64 with the latest updates  and are on a gbit
> network. Additionally  I compiled ceph from source, (checked out 
> yesterday), with fuse support, since SL5.5 has a 2.6.18 kernel..

IMHO SL is RHEL based (like CentOS).

try to use the git version branch unstable. many problems are fixed since 
last release. also your xlist error.

- Thomas

