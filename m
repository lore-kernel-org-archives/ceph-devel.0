From: Sage Weil <sage@newdream.net>
Subject: kerberos / AD requirements, blueprint
Date: Thu, 16 Oct 2014 12:57:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54201 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaJPT5M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 15:57:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: daniel.vanderster@cern.ch, abartlet@catalyst.net.nz

I started to write up a blueprint for kerberos / LDAP / AD support:

	https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD_authn%2F%2Fauthz

In case it isn't clear from that document, I only sort of know what I'm 
talking about here.  (This is largely based on what I managed to retain 
from a conversation with Andrew, but I suspect I got some of it wrong.)

For anyone working in environments where kerberos is in use, I am *very* 
interested in hearing what your requirements are for your environment.  In 
particular, are you using AD or LDAP or something else?  How do you expect 
RBAC to work for you?

We'll definitely have a slot for this at the upcoming CDS, but anything we 
can hash out before then will make that conversation more productive.

Thanks!
sage

