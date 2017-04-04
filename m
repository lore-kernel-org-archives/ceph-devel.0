From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: How best to integrate dmClock QoS library into ceph codebase
Date: Tue, 4 Apr 2017 09:32:35 -0400
Message-ID: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753080AbdDDNc4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 09:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A185C80F8F
        for <ceph-devel@vger.kernel.org>; Tue,  4 Apr 2017 13:32:55 +0000 (UTC)
Received: from ovpn-116-163.phx2.redhat.com (ovpn-116-163.phx2.redhat.com [10.3.116.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9723A7EE66
        for <ceph-devel@vger.kernel.org>; Tue,  4 Apr 2017 13:32:52 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In our work to improve QoS with ceph, we implemented the dmClock algorithm (see: https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf).

The algorithm is implemented as a general library that could be used in ceph and in other projects unrelated to ceph. To do this the dmClock library code makes use of C++ templates. On the server side, the key class takes template parameters to describe the type of a request and the type of a client identifier. On the client side, the key class takes a template parameter for the type of a server identifier.

You can find the library here:

   https://github.com/ceph/dmclock

The question is how best to integrate this library with ceph code in our git repo into the future.

There are three obvious options:

   1. Keep dmClock as a separate repo and incorporate it into ceph as a git submodule.
   2. Keep dmClock as a separate repo and incorporate it into ceph as a git subtree.
   3. Move the code into the ceph tree and stop maintaining as a generalized library.

Both git submodules and git subtrees have their own set of challenges; neither is perfect. Many have weighed in their relative advantages and disadvantages (https://www.google.com/search?q=git+submodule+subtree).

I’m inclined to keep it separate (option 1 or 2) so that others might use it in other projects.

When I started the integration, Sam recommended that it be maintained as a subtree. So that’s how it’s implemented in my not-yet-merged branch. The key challenges have been with rebases that include the commit in which the subtree was added and with pushing code changes back to the library. Since relatively few would likely be doing these types of ops, perhaps option 2 might be easiest. Currently our git PR process has an automated check for "Unmodifed Submodules". I’m guessing we’d likely want a similar check for changes in subtree code.

An argument for making it a submodule is that ceph already uses submodules and ceph developers are familiar with working with (and around) them.

But perhaps others would like to weigh in.

Thanks,

Eric