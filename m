From: Mandell Degerness <mandell@pistoncloud.com>
Subject: monitor start up question
Date: Wed, 25 Jul 2012 16:27:30 -0700
Message-ID: <CA+jddaNP94kr8=K175Qk7PkMY=NEM_a+67XxNMZ1TAFUn4etaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39254 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab2GYX1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jul 2012 19:27:31 -0400
Received: by vcbfk26 with SMTP id fk26so1124843vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 16:27:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a cluster has been shut down and then re-started, how do the
monitors know what the cluster fsid is?  Is it stored somewhere?

I would like to be able to verify, before starting a monitor on a
given server, if an existing monitor directory belongs to the current
cluster or to a previous cluster incarnation.  With the OSDs, I can
just check the cluster_fsid file.

Regards,
Mandell Degerness
