From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW Quota
Date: Thu, 7 Feb 2013 12:52:24 -0800
Message-ID: <CAC-hyiFiQnMmw-9GhzTsYAGsDKbPQRFEZf9XjRWuG-nfdKjXVg@mail.gmail.com>
References: <C4049E4484F13747B672D64B9C12C31328E0F747@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:54688 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759304Ab3BGUwZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 15:52:25 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so3397195iaz.16
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 12:52:24 -0800 (PST)
In-Reply-To: <C4049E4484F13747B672D64B9C12C31328E0F747@PWMAILM01.cscinfo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 7, 2013 at 11:21 AM, Holcombe, Christopher
<cholcomb@cscinfo.com> wrote:
> Does the RadosGW have the ability to limit how much data clients(users) can upload to it?  I'm looking for a way to implement quotas in case someone decides to upload the world on my cluster and break it

Currently there is no way to do that. Due to the distributed nature of
the system, it's not an easy task. There's no single place that holds
the total size that a single client consume, and adding such a counter
would be a contention point and would have real performance impact.

I think the solution would be in relaxing the real-time quota
requirements. That is, there will be a system in place that will
periodically check and see how much data every user consumes, and if a
user passes a certain threshold a flag will be set on its account.
Then when that user will try to write some more data it'll be denied.
When that user remove some data, its status will be rechecked in order
to be able to clear that flag when needed. In any case, the periodic
check will also need to check flagged users, in order to take care of
racy removals.

If anyone wants to tackle this issue I'd be happy to assist.

Yehuda
