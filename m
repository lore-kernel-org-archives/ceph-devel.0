From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Backporting from Infernalis and c++11
Date: Tue, 15 Sep 2015 10:11:39 +0200
Message-ID: <55F7D2BB.2050403@suse.cz>
References: <55F7C70B.4000308@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59570 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbbIOILm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Sep 2015 04:11:42 -0400
In-Reply-To: <55F7C70B.4000308@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

> With Infernalis Ceph move to c++11 (and CMake), we will see more conflicts when backporting bug fixes to Hammer. 

Good point, Loic!

> Any ideas you may have to better deal with this would be most welcome.

A couple thoughts pop into mind.

When I joined the project, I was told that doing backports is a good way
to get into the codebase, and after some months I can confirm that this
is true.

Loic has literally bent over backwards to help me along the way, and
thanks to that I have made some progress. Still, the factor determining
whether a backport is trivial or non-trivial is often my own
"cluenessness".

I would suggest to developers that they keep backporting in the back of
their mind as they design and implement bugfixes. Will the backport be
doable even by a relatively inexperienced backporter? Is there a way to
make it easier on the backporter?

I would suggest that it is in the developers' best interest to make a
little extra effort in this direction, as it will reduce the
probability of the backporter asking them for help later ;-)

Regards

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
