From: Nathan Cutler <ncutler@suse.cz>
Subject: try-restart on upgrade, and upgrade procedures in general
Date: Wed, 9 Sep 2015 10:48:21 +0200
Message-ID: <55EFF255.20001@suse.cz>
References: <55EFF135.4040706@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37052 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbbIIIsW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Sep 2015 04:48:22 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 75DB6ACE4
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2015 08:48:21 +0000 (UTC)
In-Reply-To: <55EFF135.4040706@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all:

I have been tinkering with the %preun and %postun scripts in
ceph.spec.in - in particular, the ones for the "ceph" and "ceph-radosgw"
packages.

Recently, as part of the "wip-systemd" effort, these snippets were
updated for compatibility with systemd. Since the "Upgrade procedures"
documentation[1] is going to have to be updated anyway, I hope we might
have a discussion on these upgrade procedures.

Based on my research and discussions to-date, it seems like there are
two camps:

The first camp says "upgrade should not touch running daemons;
restarting them should be left to the admin." This is closely related to
the idea that daemons should be upgraded and restarted individually:
i.e., mons first, then osds, etc.

The second camp says: "since the typical workflow for upgrading a
package in Linux distributions involves having the package itself
automatically restart running daemons, the Ceph package should do
this, too".

The first camp's position appears to be motivated primarily by a desire
to keep the cluster up and running during the upgrade, and minimize
disruption by proceeding "daemon by daemon".

The second camp's position is driven by distribution packaging
conventions and the fact that all the Ceph daemons and systemd units
(except RGW) are packaged together. This lends itself to a "node by
node" approach to upgrading, rather than "daemon by daemon". (Also,
since there is always a risk that an upgrade might cause an entire node
to fail, Ceph clusters need to be able to cope with an entire node going
offline for upgrade. This might even be an argument for *recommending*
"node by node" as an upstream-sanctioned upgrade procedure!)

It was suggested to me that a nice way to reconcile these two camps
would be to introduce an /etc/sysconfig/ceph (/etc/default/ceph) option,
which I have provisionally called CEPH_AUTO_RESTART_ON_UPGRADE. If this
option is set to "yes", the packaging scriptlet that is run on upgrade
would do a "systemctl try-restart" on all the systemd units in the
respective package. If it were not set, or set to any value other than
"yes", the current behavior would be preserved.

Opinions? Ideas?

So far, I have opened https://github.com/ceph/ceph/pull/5835 with the
RPM implementation.

[1] http://ceph.com/docs/master/install/upgrading-ceph/#upgrade-procedures

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
