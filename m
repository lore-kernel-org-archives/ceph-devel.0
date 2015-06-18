From: Tamil Muthamizhan <tmuthami@redhat.com>
Subject: Re: VPS memory
Date: Thu, 18 Jun 2015 16:43:44 -0400 (EDT)
Message-ID: <2105655006.26303941.1434660224554.JavaMail.zimbra@redhat.com>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com> <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com> <alpine.DEB.2.00.1506172011510.23826@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:60491 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbbFRUns (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2015 16:43:48 -0400
In-Reply-To: <alpine.DEB.2.00.1506172011510.23826@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yuri Weinstein <yweinste@redhat.com>, sepia@ceph.com, ceph-devel@vger.kernel.org, Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>, Alfredo Deza <adeza@redhat.com>

sounds good!

----- Original Message -----
From: "Sage Weil" <sage@newdream.net>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: sepia@ceph.com, ceph-devel@vger.kernel.org, "Loic Dachary" <ldachary@redhat.com>, "Xinxin Shu" <xinxin.shu@intel.com>, "Alfredo Deza" <adeza@redhat.com>
Sent: Thursday, June 18, 2015 3:13:17 AM
Subject: VPS memory

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
