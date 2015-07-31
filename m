From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian
 wheezy?
Date: Fri, 31 Jul 2015 12:57:37 -0400
Message-ID: <20150731165737.GB20239@linuxbox.com>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
 <20150731114807.00cfcf6c@ghroth.non.3dart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbGaQ5j (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jul 2015 12:57:39 -0400
Content-Disposition: inline
In-Reply-To: <20150731114807.00cfcf6c@ghroth.non.3dart.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mariusz Gronczewski <mariusz.gronczewski@efigence.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com

On 31/07/2015, Mariusz Gronczewski wrote:
> Well, Centos 6 will be supported to 2020, and centos 7 was released a
> year ago so I'd imagine a lot of people haven't migrated yet and
> migration process is nontrivial if you already did some modificiations
> to c6 (read: fix broken as fuck init scripts for few apps)

If I understand, nobody is proposing to stop supporting CentOS 6 in
Hammer. It makes perfect sense for the LTS release of Ceph to continue
supporting the LTS releases of distributions that were current when it
was released. But Jewel should only have to support RHEL 7 for its life
cycle.

This way newer releases of Ceph can take advantage of newer language,
library, and kernel features and people who need the stability and
assurance of an older, long-term support distribution can continue to
have a stable, long-term support release of Ceph to go with it.
