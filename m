From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Discuss: New default recovery config settings
Date: Fri, 29 May 2015 18:16:06 -0400
Message-ID: <CANP1eJGsZGADNr14ueS0tc-WsPoM=y7gZ_p047JE8mOWoyM0+w@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35574 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbE2WQI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2015 18:16:08 -0400
Received: by lbbuc2 with SMTP id uc2so56859136lbb.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2015 15:16:07 -0700 (PDT)
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
> -Sam

Sam I was thinking about this recently. We recently recently we ended
up hitting a recovery story & a scrub storm both happened at a time of
high client activity. While changing the defaults down will make these
kinds of disruptions less likely to occur, it also makes recovery
(rebalancing) very slow. What I'd like to see

What I would be happy to see is more of a QOS style tunable along the
lines of networking traffic shaping. Where can guarantee a minimum
amount of recovery "load" (and I say it in quotes since there's more
the one resource involved) when the cluster is busy with client IO. Or
vice versa there's a minimum amount of client IO that's guaranteed.
Then when there's lower periods of client activity the recovery (and
other background work) can proceed at full speed. Many workloads are
cyclical or seasonal (in the statistics term of it, eg. intra/infra
day seasonality).

QOS style managment should lead to a more dynamic system where we can
maximize available utilization, minimize disruptions, and not play
wack-a-mole with many conf knobs. I'm aware that this is much harder
to implement but thankfully there's a lot of literature,
implementation and practical experience out there to draw upon.

- Milosz

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
