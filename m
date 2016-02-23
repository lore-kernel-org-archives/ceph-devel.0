From: Joao Eduardo Luis <joao@suse.de>
Subject: 'mon_addr' vs 'public_addr'
Date: Tue, 23 Feb 2016 18:07:57 +0000
Message-ID: <56CC9FFD.2030801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53680 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131AbcBWSH7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Feb 2016 13:07:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, 'Gregory Farnum' <gfarnum@redhat.com>

Hi all,

does anyone remember the rationale behind not simply relying on
'public_addr' instead of 'mon_addr' for the monitors?

I keep coming back to this, and I keep thinking this must be an artefact
of some long-gone era, during which public_addr maybe didn't exist? I
tried to backtrace its inception and ended up all the way in af870763
back from 2009, but the commit itself didn't help much.

Any thoughts?

  -Joao
