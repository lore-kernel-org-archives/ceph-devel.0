From: Marcel Lauhoff <lauhoff@uni-mainz.de>
Subject: Re: Started developing a deduplication feature
Date: Fri, 8 Apr 2016 17:01:24 +0200
Message-ID: <871t6gkuuz.fsf@uni-mainz.de>
References: <8737r5w89m.fsf@uni-mainz.de> <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com> <87wpodv99m.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate-02.zdv.uni-mainz.de ([134.93.178.246]:25088 "EHLO
	mailgate-02.zdv.uni-mainz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932725AbcDHPBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 11:01:33 -0400
In-Reply-To: <87wpodv99m.fsf@uni-mainz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi list,
short recap of the dedup topic from the CDM on Wednesday:


The main change from the original mail is not to add a PG backend, but
rather use Object Redirects (Tiering v2).
Another backend would have to implement its own replication for
recipes and increase the OSD code base just for dedup. Redirects are
useful beyond deduplication.


The CAS pool design was refined: An object class should handle the ref
counting and content addressing. The pool should also only
allow access through this object class to prevent collisions with
regular objects and support immutable objects.


There was also the idea of client-side deduplication by using metadata
that clients like RGW store. This would save the additional round trip
that object redirects add.


I'll be working on the CAS pool first, since there
is ongoing refactoring in the ReplicatedPG code base. I'll work out a
more detailed design document for the CAS pool soon.


~irq0
--
Marcel Lauhoff
Mail: lauhoff@uni-mainz.de
XMPP: mlauhoff@jabber.uni-mainz.de
