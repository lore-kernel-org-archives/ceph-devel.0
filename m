From: Sage Weil <sage@inktank.com>
Subject: security session at CDS
Date: Wed, 29 Oct 2014 09:32:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410290849380.18919@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37182 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933459AbaJ2Qca (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 12:32:30 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id F16D680068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 09:32:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C412980068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 09:32:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here are the main takeaways I got from the session on security

	http://pad.ceph.com/p/hammer-security_and_auth

run daemons as unprivileged users.  there is a ticket for this already:
  http://tracker.ceph.com/issues/9133

selinux policies
  http://tracker.ceph.com/issues/9931

gtest: update and/or move to submodule
  http://tracker.ceph.com/issues/9930

red hat: openstack + ceph CI testing for cinder/glance

[sage] formalize security reporting procedure for upstream ceph

[sage] survey: auth environments


If anyone wants to own any of these efforts, speak up :)

sage

