From: Thomas Mueller <thomas@chaschperli.ch>
Subject: kclient IPv4 vs IPv6 problem
Date: Mon, 19 Jul 2010 14:10:55 +0000 (UTC)
Message-ID: <i21mdf$fma$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34253 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934150Ab0GSOLG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Jul 2010 10:11:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Oar3e-0006v5-S5
	for ceph-devel@vger.kernel.org; Mon, 19 Jul 2010 16:11:02 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jul 2010 16:11:02 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jul 2010 16:11:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

if I mount ceph with localhost, 

> mount -t ceph localhost:/ /mnt

it fails with:

mount error 22 = Invalid argument


dmesg shows:
[  813.704419] ceph: parse_ips bad ip '[::1],[127.0.0.1]:/'

on my machine ipv6 and ipv4 are enabled (standard debian installation). 
Seems like "localhost" resolves to ipv4 and ipv6 what confuses ceph 
kclient.

As I only have ipv6 on the machine I can't test it in a real network. But 
maybe this also applies to DNS hostnames with both A and AAAA entries.

- Thomas

ceph-client-standalone/unstable-backport 
ref 0938669c180056f517db836f05697f8a2c41ec61

