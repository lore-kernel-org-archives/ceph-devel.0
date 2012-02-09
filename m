From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Questions about OSD recovery
Date: Thu, 9 Feb 2012 09:28:39 -0800
Message-ID: <CAORUGqAb2zieQOfRnPHC+hEdK32txGqPGUWquLPUxJP0ZGUwMg@mail.gmail.com>
References: <CANExM-NCijMZX89Bp6wOGkLmkqKeqiqhnMJ8VKKN_QSQXnm7LA@mail.gmail.com>
 <4F333A0C.7080902@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59537 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab2BIR3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2012 12:29:00 -0500
Received: by werb13 with SMTP id b13so1416434wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2012 09:28:59 -0800 (PST)
In-Reply-To: <4F333A0C.7080902@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 8, 2012 at 19:14, Josh Durgin <josh.durgin@dreamhost.com> wrote:
> It's possible to do what the current repair code does
> automatically, but this would be a bad idea since it just takes
> the first osd (with primary before replicas) to have the object
> as authoritative, and copies it to all the relevant osds. If the
> primary has a corrupt copy, this corruption will spread to other
> osds. In your case, since you removed the object entirely, repair
> could correct it.

At the risk of saying the obvious.. If you have >=3 copies, you could
hash them all, and let the majority decide which is the "good" copy.

An admin could do this manually, just deleting the bad one and letting
scrub repair it, and later on we might be able to automate it.

I'm not sure if Dynamo's/Cassandra's anti-entropy feature does this,
or if it's a simple "master overwrites slaves", and I realize the
multi-party communication is sort of hard to coordinate, but it's
definitely possible. I loves me some Merkle trees.

Of course, there might be cases where e.g. all 3 replicas have
different content.

In many ways, getting a hash stored alongside is object is
significantly better, and might be a better route to go -- our objects
are big enough, as opposed to typical Dynamo/Cassandra cells that are
often smaller than a sha1.
