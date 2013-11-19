From: Gregory Farnum <greg@inktank.com>
Subject: Monitor upgrade issue when running "ceph osd pool set ..." commands
Date: Mon, 18 Nov 2013 18:19:25 -0800
Message-ID: <CAPYLRzgn7EaC28ePFentZiZqbhv15ruoL=Dy2JXmCHPmj5yzVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40488 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3KSCT1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 21:19:27 -0500
Received: by mail-wi0-f178.google.com with SMTP id hj6so1596182wib.5
        for <ceph-devel@vger.kernel.org>; Mon, 18 Nov 2013 18:19:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

All,

We've just discovered an issue that impacts some users running any of
the "ceph osd pool set" family of commands while some of their
monitors are running Dumpling and some are running Emperor. Doing so
can result in the commands being interpreted incorrectly and your
cluster being accidentally misconfigured (eg, accidentally setting
extremely large pg_num values).

The solution is simple: don't run "ceph osd pool set" commands while
your monitors are running different versions. We will have a point
release out in the next few days to resolve this issue. For more
information, you can refer to http://tracker.ceph.com/issues/6796.

Relatedly, I'm proud to announce this issue was discovered by our
automated upgrade testing and we have not seen reports of it from any
users. Thank you to our dedicated Q/A developers and testers! :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
