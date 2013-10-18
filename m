From: "=?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?=" <llpamies@pamies.cat>
Subject: PGBackend: Multiple PG implementations.
Date: Fri, 18 Oct 2013 16:05:46 -0700
Message-ID: <CAKD2hyG6giBDQ0ue9hD723Eq0Bk+1rAKgb9NzdjHJBW5DoRxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44010 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757406Ab3JRXFs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 19:05:48 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so2099828oag.24
        for <ceph-devel@vger.kernel.org>; Fri, 18 Oct 2013 16:05:47 -0700 (PDT)
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com [2607:f8b0:4001:c03::22a])
        by mx.google.com with ESMTPSA id b5sm8620090obj.8.2013.10.18.16.05.46
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 16:05:46 -0700 (PDT)
Received: by mail-ie0-f170.google.com with SMTP id at1so7916354iec.29
        for <ceph-devel@vger.kernel.org>; Fri, 18 Oct 2013 16:05:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I was looking at the work done to re-architecture the OSD backend.
Since it seems that it allows now to have more than one PG
implementation I decided to subclass PG and PGBackend to create an
alternative implementation to ReplicatedPG and ReplicatedBackend.
However, I noticed a couple of problems:

* All methods in watch.h and watch.cc expect ReplicatedPG objects
instead of generic PG objects.
* New pools created in the OSDMonitor are created as replicated pools
(g_pool_t::TYPE_REP). This is a hardcoded value.

I made a few changes to solve these two issues that allowed me to have
more than one PG implementation running without problems. You can find
the changes here:

https://github.com/ceph/ceph/pull/744

Are these changes useful for the re-architecture of the OSD ?

PS: Implementing and running an alternative PG requires other changes
in the CrushCompiler and other header files.

Best,
Lluis
