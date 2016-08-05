From: John Spray <jspray@redhat.com>
Subject: Switching on mds_bal_frag by default
Date: Fri, 5 Aug 2016 11:52:32 +0100
Message-ID: <CALe9h7fbSiDEf_AYKyOuDDwtDq_4-T1Dq4p0kieyAmZoMyHu8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33011 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965433AbcHEKwx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 06:52:53 -0400
Received: by mail-qk0-f177.google.com with SMTP id p74so259122479qka.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 03:52:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Patrick: can you try enabling fragmentation in the multimds tests so
that we have an idea if it's going to make them blow up before we
switch it on in master?

The multimds suites currently don't have the yaml fragments that
switch it on, and they'll probably be particularly vulnerable to any
issues it might throw up.

I think we should be switching mds_bal_frag on by default in Kraken,
it's been enabled in the fs suite for some time (although we're
currently taking it on faith that it's really being exercised
http://tracker.ceph.com/issues/16523)

John
