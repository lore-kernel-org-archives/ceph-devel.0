From: "Curtis C." <serverascode@gmail.com>
Subject: Where to run ceph for openstack
Date: Thu, 9 Aug 2012 19:33:23 -0600
Message-ID: <CAJ_JamA4XjMN816Gbk79FPApLXywwAzA0utWUtu+icpB2Cx97g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52129 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2HJBdX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 21:33:23 -0400
Received: by obbuo13 with SMTP id uo13so1480344obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 18:33:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

My workplace is considering deploying Ceph for OpenStack block storage
to try to provide volume and vm migration.

Immediately I decided, perhaps wrongly, that this meant a dedicated
Ceph cluster of physical servers. But a colleague suggested that
perhaps it would be better to run Ceph on the compute nodes instead of
a distinct, separate cluster.

Is one of these a more appropriate solution (in a perfect world)? Or
is this a half-dozen one way, six the other type situation?

I can definitely understand trying to make compute and storage generic
and plentiful by keeping them on the same node. But I also feel like
it's ok to split things out sometimes too.

Any thoughts, suggestions, or reference architecture pointers?

Thanks for any help,
Curtis.
