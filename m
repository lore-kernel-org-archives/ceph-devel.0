From: Nathan Cutler <ncutler@suse.cz>
Subject: Would it make sense to require ntp
Date: Fri, 6 Nov 2015 11:06:41 +0100
Message-ID: <563C7BB1.7030500@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35551 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1033130AbbKFKGn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Nov 2015 05:06:43 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 1F2A4AC27
	for <ceph-devel@vger.kernel.org>; Fri,  6 Nov 2015 10:06:22 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph:

Recently I encountered some a "clock skew" issue with 0.94.3. I have
some small demo clusters in AWS. When I boot them up, in most cases the
cluster will start in HEALTH_WARN due to clock skew on some of the MONs.

I surmise that this is due to a race condition between the ceph-mon and
ntpd systemd services. Sometimes ntpd.service starts *after* ceph-mon -
in this case the MON sees a wrong/unsynchronized time value.

Now, even though ntpd.service starts (and fixes the time value) very
soon afterwards, the cluster remains in clock skew for a long time - but
that is a separate issue. What I would like to ask is this:

Is there any reasonable Ceph cluster node configuration that does not
include running the NTP daemon?

If the answer is "no", would it make sense to make NTP a runtime
dependency and tell the ceph-mon systemd service to wait for
ntpd.service before it starts?

Thanks and regards

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
