From: David Disseldorp <ddiss@suse.de>
Subject: ceph-deploy: install bundled SES / openSUSE distribution packages
Date: Thu, 11 Jun 2015 19:37:47 +0200
Message-ID: <20150611193747.2cc6cfaa@plati.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40233 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbbFKRhu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Jun 2015 13:37:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Travis Rhoden <trhoden@gmail.com>, Owen Synge <osynge@suse.com>

Hi,

The ceph-deploy suse back-end currently pulls down and installs packages
from ceph.com. As we move to shipping Ceph with our own SES / openSUSE
media, I'd like to allow users to also install from the distribution
repositories using upstream ceph-deploy.

Use of bundled Red Hat distribution packages is currently possible via
the rhel back-end, which is enabled with hosts.get(@use_rhceph=true).
For SUSE based distributions, I'd like to proceed with one of the
following options:
1) Rename @use_rhceph to @use_bundled_ceph, and add new sles/opensuse
   back-ends.
2) Change the suse back-end install() function to always use
   distribution packages. The mirror_install(repo) logic triggered by
   --repo-url can continue to be used for installations from other (e.g.
   ceph.com) sources.
3) Pass a @bundled argument to the distro back-end install() function,
   and implement the conditional logic there.

Any thoughts / preferences? I'm leaning towards (2), given that
http://ceph.com/rpm-$release doesn't carry openSUSE or SLES packages for
recent releases.

Cheers, David
