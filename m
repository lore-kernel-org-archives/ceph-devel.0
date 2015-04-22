From: Gregory Farnum <greg@gregs42.com>
Subject: Re: systemd unit files and multiple daemons
Date: Wed, 22 Apr 2015 15:26:28 -0700
Message-ID: <CAC6JEv_PkZf-5kHEExdOci=S1so3LXp3y39wQ6NFFuraO1W1gw@mail.gmail.com>
References: <55381938.7010600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38159 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbbDVW03 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Apr 2015 18:26:29 -0400
Received: by igbhj9 with SMTP id hj9so9691350igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2015 15:26:29 -0700 (PDT)
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com. [209.85.213.170])
        by mx.google.com with ESMTPSA id t41sm4013187ioe.5.2015.04.22.15.26.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2015 15:26:28 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so9691191igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2015 15:26:28 -0700 (PDT)
In-Reply-To: <55381938.7010600@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Wed, Apr 22, 2015 at 2:57 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> I could really use some eyes on the systemd change proposed here:
> http://tracker.ceph.com/issues/11344
>
> Specifically, on bullet #4 there, should we have a single
> "ceph-mon.service" (implying that users should only run one monitor
> daemon per server) or if we should support multiple "ceph-mon@" services
> (implying that users will need to specify additional information when
> starting the service(s)). The version in our tree is "ceph-mon@". James'
> work for Ubuntu Vivid is only "ceph-mon" [2]. Same thing for ceph-mds vs
> ceph-mds@.
>
> I'd prefer to keep Ubuntu downstream the same as Ceph upstream.
>
> What do we want to do for this?
>
> How common is it to run multiple monitor daemons or mds daemons on a
> single host?

For a real deployment, you shouldn't be running multiple monitors on a
single node in the general case. I'm not sure if we want to prohibit
it by policy, but I'd be okay with the idea.
For testing purposes (in ceph-qa-suite or using vstart as a developer)
it's pretty common though, and we probably don't want to have to
rewrite all our tests to change that. I'm not sure that vstart ever
uses the regular init system, but teuthology/ceph-qa-suite obviously
do!

For MDSes, it's probably appropriate/correct to support multiple
daemons on the same host. This can be either a fault tolerance thing,
or just a way of better using multiple cores if you're living on the
(very dangerous) edge.
-Greg
