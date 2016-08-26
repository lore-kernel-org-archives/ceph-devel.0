From: Sage Weil <sweil@redhat.com>
Subject: new boost
Date: Fri, 26 Aug 2016 18:42:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbcHZSmt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Aug 2016 14:42:49 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B24AC05678C
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2016 18:42:49 +0000 (UTC)
Received: from ovpn-112-75.phx2.redhat.com (ovpn-112-75.phx2.redhat.com [10.3.112.75])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7QIglXB030588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2016 14:42:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that we've transitioned to cmake, I'd like to resurrect the discussion 
about moving to a new version of boost.  I'm dying to use small_vector and 
flat_map.

IIRC, we have a few options:

1) boost as a submodule.  compile and link statically.
 - easy to maintain
 - no packaging impact
 - dev/build environment is not dependent on system install boost

2) build and package newer boost, build packages, and distribute with 
ceph.
 - distro folks won't lose their hats
 - bunch of packaging work
 - bunch of release repo building work (to ensure proper packages get 
included)
 - dev environments are awkward (need new boost installed on the system)

3) combination of 1 and 2
 - all of the work of 1 and 2
 - plus, extra cmake options to use either static or dynamic version

4) #1, with cmake smarts to let you choose the submodule or installed 
boost (and possibly autoselect system boost if it's new enough).

I'm prety firmly in the #1/#4 camp because I don't think that #2 brings 
any benefits that aren't political.  The main reason to use shared 
libraries is because distros/users can update it independently to fix bugs 
or (more importantly) security flaws.  However, in the case of boost, 
almost all of it exists in header code and is compiled statically, so the 
likelihood that a bug might be found that can be fixed by recompiling the 
dynamically linked portion is basically zero.

And it's a ton of extra work to build and distribute the shared libraries.

One other note from the previous thread:

'bcp' can be used to extra subcomponents of the library to compile 
statically.  Matt found this tended to snowball and there was some risk of 
conflicting with an installed boost.  And building the whole thing was 
less than a minute anyway?

How should we proceed?  And who wants to take this on?
sage
