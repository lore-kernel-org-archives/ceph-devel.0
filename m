From: Brian Chrisman <brchrisman@gmail.com>
Subject: write completion strategy (ack/commit questions)
Date: Wed, 23 Mar 2011 11:14:22 -0700
Message-ID: <AANLkTimRxtTAbJ+DyzhEz=3khbv33oohvd6H8HywTeoV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55048 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab1CWSOY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 14:14:24 -0400
Received: by vxi39 with SMTP id 39so6346313vxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 11:14:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Regarding section 5.3 of this paper (section titled 'Data Safety')
http://www.usenix.org/events/osdi06/tech/full_papers/weil/weil_html/

I've had some discussions recently about what kind of data consistency
we can achieve.
From discussions on this list/IRC, it's clear that right now ceph,
with a reasonable crushmap, requires an on-disk write to each of two
nodes (either a journal or fs write is acceptable) before returning a
write completion.
The referred section suggests that there may be a way to have a client
notified of a write-to-cache-completion instead when the written data
is cached on two nodes (but not yet committed to disk) via the 'ack'.

If these acks aren't exposed/used at the ceph layer, are they exposed
via librbd, libceph, or librados?
