From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: radosgw: Files left over after deletion (even after the gc period/process)
Date: Thu, 30 May 2013 23:44:11 +0200
Message-ID: <CAF6-1L7WALtDVWoYy3cavxim8w76P69Xwh5X=iGzpBcHskAQHA@mail.gmail.com>
References: <CAF6-1L6pC8UqoFrqMzpZXKrZctwKELw_iKpHDtwvq6ZvRsx_FQ@mail.gmail.com>
	<CABBk=J-wEXMQMgmw4XEANEyNnYXZx2nePN8u7KfYsYFrs3ADqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:49313 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab3E3VoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 17:44:13 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so408771bkc.30
        for <ceph-devel@vger.kernel.org>; Thu, 30 May 2013 14:44:11 -0700 (PDT)
In-Reply-To: <CABBk=J-wEXMQMgmw4XEANEyNnYXZx2nePN8u7KfYsYFrs3ADqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> I opened ceph issue #5204 for this, and pushed a fix (on top of
> cuttlefish) to the wip-5204 branch.

Ok, great I'll give that a shot next week.

BTW, Is there a way to scan buckets to find objects that should no
longer be used ?

Cheers,

    Sylvain
