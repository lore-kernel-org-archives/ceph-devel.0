From: Samuel Just <sjust@redhat.com>
Subject: Discuss: New default recovery config settings
Date: Fri, 29 May 2015 17:47:13 -0400 (EDT)
Message-ID: <1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:41154 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbbE2VrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2015 17:47:13 -0400
In-Reply-To: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>

Many people have reported that they need to lower the osd recovery config options to minimize the impact of recovery on client io.  We are talking about changing the defaults as follows:

osd_max_backfills to 1 (from 10)
osd_recovery_max_active to 3 (from 15)
osd_recovery_op_priority to 1 (from 10)
osd_recovery_max_single_start to 1 (from 5)

We'd like a bit of feedback first though.  Is anyone happy with the current configs?  Is anyone using something between these values and the current defaults?  What kind of workload?  I'd guess that lowering osd_max_backfills to 1 is probably a good idea, but I wonder whether lowering osd_recovery_max_active and osd_recovery_max_single_start will cause small objects to recover unacceptably slowly.

Thoughts?
-Sam
