From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: Discuss: New default recovery config settings
Date: Sun, 31 May 2015 10:29:06 -0400
Message-ID: <CAOGLoJOZ2ua3UNdWSb+kTkcsm5PrxtSZgjro9HRvL6i4DJjtJg@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33805 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbbEaO3G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 10:29:06 -0400
Received: by oifu123 with SMTP id u123so85674024oif.1
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 07:29:06 -0700 (PDT)
In-Reply-To: <1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>

On Fri, May 29, 2015 at 5:47 PM, Samuel Just <sjust@redhat.com> wrote:
> Many people have reported that they need to lower the osd recovery config options to minimize the impact of recovery on client io.  We are talking about changing the defaults as follows:
>
> osd_max_backfills to 1 (from 10)
> osd_recovery_max_active to 3 (from 15)
> osd_recovery_op_priority to 1 (from 10)
> osd_recovery_max_single_start to 1 (from 5)
>
> We'd like a bit of feedback first though.  Is anyone happy with the current configs?  Is anyone using something between these values and the current defaults?  What kind of workload?  I'd guess that lowering osd_max_backfills to 1 is probably a good idea, but I wonder whether lowering osd_recovery_max_active and osd_recovery_max_single_start will cause small objects to recover unacceptably slowly.
>
> Thoughts?

When we enable explicit rebalancing, we set the parameters as such to
reduce the impact on client I/O:

osd_recovery_max_active = 1
osd_max_backfills = 1
osd_op_threads = 10
osd_recovery_op_priority = 1
osd_mon_report_interval_min = 30

See https://github.com/bloomberg/chef-bcpc/blob/master/cookbooks/bcpc/templates/default/ceph.conf.erb

Cheers.  -- justin
