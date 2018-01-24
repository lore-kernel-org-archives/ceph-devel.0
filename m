From: Sage Weil <sage@newdream.net>
Subject: Re: OSD recovery priority ?
Date: Wed, 24 Jan 2018 18:19:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801241818030.9589@piezo.novalocal>
References: <CAL2-6bLEx-C3H_7x+JGpJUzP=BTcL5TELi4RjVaf+q7FPms+uw@mail.gmail.com> <2721061c-b583-7ea5-8b44-b1d80aa58700@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1330643859-1516817982=:9589"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:59939 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964930AbeAXSTm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 13:19:42 -0500
In-Reply-To: <2721061c-b583-7ea5-8b44-b1d80aa58700@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>
Cc: Vincent Godin <vince.mlist@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1330643859-1516817982=:9589
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 24 Jan 2018, Piotr Dałek wrote:
> On 18-01-24 10:54 AM, Vincent Godin wrote:
> > I have a cluster in recovery state and i notice that few pgs are only
> > hold bye one OSD and a lot hold by two OSDs (pool configured with size
> > =3 & min=1). After few days, i'm surprised to see that the few pgs
> > hold only by one OSD are still there. It seems there is no high
> > priority for pg in critical state (1 on 3) compare to those in warn
> > state (2 on 3). Am i wrong or could it be a near feature ?
> > My Cluster is in Jewel 10.2.6
> 
> http://docs.ceph.com/docs/master/release-notes/#v10-2-7-jewel
> https://github.com/ceph/ceph/pull/13232 might be closest to what you need.
> You'd still need to bump up min_size to 2, though.

Note that there is also an issue in luminous where a lower-priority 
recovery may already be in progress when a higher-priority PG becomes 
ready to recovery, the low-priority PG is not preempted. This is fixed in 
master for mimic but the backport is nontrivial.

sage
--8323329-1330643859-1516817982=:9589--
