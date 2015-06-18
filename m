From: Sage Weil <sage@newdream.net>
Subject: VPS memory
Date: Wed, 17 Jun 2015 20:13:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506172011510.23826@cobra.newdream.net>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com> <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57742 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbbFRDNS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 23:13:18 -0400
In-Reply-To: <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "sepia@ceph.com" <sepia@ceph.com>, ceph-devel@vger.kernel.org, Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>, Alfredo Deza <adeza@redhat.com>

On Wed, 17 Jun 2015, Yuri Weinstein wrote:
> - upgrade/dumpling-firefly-x (to hammer)(distros) - runs out of memory on vps and unreliable

How about we

- half the number of vps's per node.
- double the default ram per vps instance
- double the cpu?

It'll mean lower test throughput, but (hopefully) reliable test results.  
Given the amount of time we waste sifting through noisy results that seems 
like a better path?

sage
