From: Sage Weil <sage@newdream.net>
Subject: Re: /var/lib/ceph/*/*/config
Date: Wed, 27 Jan 2016 09:59:35 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601270956260.6524@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com> <CACJqLyaMC-UaAhTnzCeUqPCoY3HcoqLwHg3tpWW0H-+6AN6C7Q@mail.gmail.com> <alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49895 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555AbcA0O7Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 09:59:24 -0500
In-Reply-To: <alpine.DEB.2.11.1601191144150.28274@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Loic pointed out that adding a new config file that is overrides/combines 
with the global config makes our already-complicated config infrastructure 
even more so.  And it turned out to be more complicated to implement than 
I'd hoped.  On the other hand, I think there are valid use-cases for a 
global config, e.g.:

 - most config on the osd disk itself
 - /etc/ceph/ceph.conf containing crush_location and mon_host

...and with a single config I'm not sure how we'd get the datacenter 
location set properly.

Anyway, I have two versions implemented.  The first just adds 
$data_dir/config to the search pathh:

	https://github.com/ceph/ceph/pull/7377

The second adds the extra_config infrastructure.  It's just the last patch 
that is different:

	https://github.com/ceph/ceph/pull/7378

Comments?
sage
