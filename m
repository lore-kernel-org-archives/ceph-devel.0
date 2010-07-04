From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: ubuntu problem while trying to get Ceph working with 2 servers
Date: Sun, 4 Jul 2010 13:56:07 +0000 (UTC)
Message-ID: <i0q3tn$q8m$1@dough.gmane.org>
References: <201007032221.24831.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45692 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757659Ab0GDN4T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 4 Jul 2010 09:56:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OVPgA-00071Z-QD
	for ceph-devel@vger.kernel.org; Sun, 04 Jul 2010 15:56:18 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 04 Jul 2010 15:56:18 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 04 Jul 2010 15:56:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> But Ubuntu does not allow to login as root.
> 
> # ssh root@ec2-67-202-18-178.compute-1.amazonaws.com Permission denied
> (publickey).

did you check the /var/log/auth.log and /var/log/syslog on the slave for 
sshd error messages?

if you created the /root/.ssh directory yourself on the slave it has 
maybe wrong permissions.

or maybe ubuntu has disabled root login in /etc/ssh/sshd_config ? but 
last time i used it it was not disabled.

- Thomas

