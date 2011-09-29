From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [PATCH v3] ceph: use kernel DNS resolver
Date: Thu, 29 Sep 2011 12:31:02 -0700 (PDT)
Message-ID: <540605577.50538.1317324662345.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAB2gnbXPZ1QghWkPtuf42oxD2JhXa4tdedvVvrM0ZTY7HPBW6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:56016 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab1I2TbD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 15:31:03 -0400
In-Reply-To: <CAB2gnbXPZ1QghWkPtuf42oxD2JhXa4tdedvVvrM0ZTY7HPBW6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I don't see this patch in master after my latest fetch. I was curious if this got yanked?

Thanks,
Noah

----- Original Message -----
From: "Noah Watkins" <noahwatkins@gmail.com>
To: "Sage Weil" <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, "LKML" <linux-kernel@vger.kernel.org>
Sent: Friday, September 23, 2011 12:40:12 PM
Subject: [PATCH v3] ceph: use kernel DNS resolver

Change ceph_parse_ips to take either names given as
IP addresses or standard hostnames (e.g. localhost).
The DNS lookup is done using the dns_resolver facility
similar to its use in AFS, NFS, and CIFS.

This patch defines CONFIG_CEPH_LIB_USE_DNS_RESOLVER
that controls if this feature is on or off.
