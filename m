From: Sage Weil <sweil@redhat.com>
Subject: Re: Pool setting for recovery priority
Date: Wed, 16 Sep 2015 09:23:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net>
References: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-535576908-1442420590=:14342"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54445 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbbIPQXL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Sep 2015 12:23:11 -0400
In-Reply-To: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-535576908-1442420590=:14342
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 16 Sep 2015, GuangYang wrote:
> Hi Sam,
> As part of the effort to solve problems similar to issue #13104 (http://tracker.ceph.com/issues/13104), do you think it is appropriate to add some parameters to pool setting:
>    1. recovery priority of the pool - we have a customized pool recovery priority (like process's nice value) to favor some pools over others. For example, the bucket index pool is usually much much smaller but important to recover first (e.g. might affect write latency as like issue #13104).
>    2. pool level recovery op priority - currently we have a low priority for recovery op (by default it is 10 while client io's priority is 63), is it possible to have a pool setting to customized the priority on pool level.
> 
> The purpose is to give some flexibility in terms of favor some pools over others when doing recovery, in our case using radosgw, we would like to favor bucket index pool as that is on the write path for all requests.

I think this makes sense, and is analogous to

	https://github.com/ceph/ceph/pull/5922

which does per-pool scrub settings.  I think the only real question is 
whether pg_pool_t is the right place to keep piling these parameters in, 
or whether we want some unstructured key/value settings or something.

sage
--557981400-535576908-1442420590=:14342--
