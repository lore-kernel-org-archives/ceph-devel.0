From: John Spray <john.spray@inktank.com>
Subject: Re: collectd / graphite / grafana .. calamari?
Date: Fri, 23 May 2014 11:42:55 +0100
Message-ID: <CAGd4Wr2zag-Hjjrx+ZpfdLWtt6aKOCYiy12BTSbPC3TXbQz1kg@mail.gmail.com>
References: <CA+xPSVCDxfPNATq2_jZPACxPrp_fB=URRQC9AZRexe5UatA5=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34094 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbaEWKm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 May 2014 06:42:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so3932578pad.25
        for <ceph-devel@vger.kernel.org>; Fri, 23 May 2014 03:42:56 -0700 (PDT)
In-Reply-To: <CA+xPSVCDxfPNATq2_jZPACxPrp_fB=URRQC9AZRexe5UatA5=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Rocha <rocha.porto@gmail.com>
Cc: "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ricardo,

Let me share a few notes on metrics in calamari:
 * We're bundling graphite, and using diamond to send home metrics.
The diamond collector used in calamari has always been open source
[1].
 * The Calamari UI has its own graphs page that talks directly to the
graphite API (the calamari REST API does not duplicate any of the
graphing interface)
 * We also bundle the default graphite dashboard, so that folks can go
to /graphite/dashboard/ on the calamari server to plot anything custom
they want to.

It could be quite interesting hook in Grafana there in the same way
that we currently hook in the default graphite dashboard, as it
grafana definitely nicer and would give us a roadmap to influxdb (a
project I am quite excited about).

Cheers,
John

1. https://github.com/ceph/Diamond/commits/calamari

On Fri, May 23, 2014 at 1:58 AM, Ricardo Rocha <rocha.porto@gmail.com> wrote:
> Hi.
>
> I saw the thread a couple days ago on ceph-users regarding collectd...
> and yes, i've been working on something similar for the last few days
> :)
>
> https://github.com/rochaporto/collectd-ceph
>
> It has a set of collectd plugins pushing metrics which mostly map what
> the ceph commands return. In the setup we have it pushes them to
> graphite and the displays rely on grafana (check for a screenshot in
> the link above).
>
> As it relies on common building blocks, it's easily extensible and
> we'll come up with new dashboards soon - things like plotting osd data
> against the metrics from the collectd disk plugin, which we also
> deploy.
>
> This email is mostly to share the work, but also to check on Calamari?
> I asked Patrick after the RedHat/Inktank news and have no idea what it
> provides, but i'm sure it comes with lots of extra sauce - he
> suggested to ask in the list.
>
> What's the timeline to have it open sourced? It would be great to have
> a look at it, and as there's work from different people in this area
> maybe start working together on some fancier monitoring tools.
>
> Regards,
>   Ricardo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
