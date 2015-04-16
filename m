From: Patrick McGarry <pmcgarry@redhat.com>
Subject: Ceph.com
Date: Thu, 16 Apr 2015 11:28:55 -0400
Message-ID: <CAAZbbf3dnrjC3Y=vODZAsX=K6fhKC9OjOS051s5BnW_gbC67yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36774 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbDPP24 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 11:28:56 -0400
Received: by obbeb7 with SMTP id eb7so45434847obb.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 08:28:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

Hey cephers,

As most of you have no doubt noticed, ceph.com has been having
some...er..."issues" lately. Unfortunately this is some of the
holdover infrastructure stuff from being a startup without a big-boy
ops plan.

The current setup has ceph.com sharing a host with some of the nightly
build stuff to make it easier for gitbuilder tasks (that also build
the website doc) to coexist. Was this smart? No, probably not. Was is
the quick-and-dirty way for us to get stuff rolling when we were tiny?
Yep.

So, now that things are continuing to grow (website traffic load,
ceph-deploy key requests, number of simultaneous builds) we are
hitting the end of what one hard-working box can handle. I am in the
process of moving ceph.com to a new host so that build explosions wont
slag things like Ceph Day pages and the blog, but the doc may lag
behind a bit.

Hopefully since I'm starting with the website it wont hose up too many
of the other tasks, but bear with us while we split routing for a bit.
If you have any questions please feel free to poke me. Thanks.

-- 

Best Regards,

Patrick McGarry
Director Ceph Community || Red Hat
http://ceph.com  ||  http://community.redhat.com
@scuttlemonkey || @ceph
