From: Ricardo Rocha <rocha.porto@gmail.com>
Subject: collectd / graphite / grafana .. calamari?
Date: Fri, 23 May 2014 12:58:04 +1200
Message-ID: <CA+xPSVCDxfPNATq2_jZPACxPrp_fB=URRQC9AZRexe5UatA5=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:54360 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaEWA6G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 20:58:06 -0400
Received: by mail-vc0-f181.google.com with SMTP id hy4so2037653vcb.12
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 17:58:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi.

I saw the thread a couple days ago on ceph-users regarding collectd...
and yes, i've been working on something similar for the last few days
:)

https://github.com/rochaporto/collectd-ceph

It has a set of collectd plugins pushing metrics which mostly map what
the ceph commands return. In the setup we have it pushes them to
graphite and the displays rely on grafana (check for a screenshot in
the link above).

As it relies on common building blocks, it's easily extensible and
we'll come up with new dashboards soon - things like plotting osd data
against the metrics from the collectd disk plugin, which we also
deploy.

This email is mostly to share the work, but also to check on Calamari?
I asked Patrick after the RedHat/Inktank news and have no idea what it
provides, but i'm sure it comes with lots of extra sauce - he
suggested to ask in the list.

What's the timeline to have it open sourced? It would be great to have
a look at it, and as there's work from different people in this area
maybe start working together on some fancier monitoring tools.

Regards,
  Ricardo
