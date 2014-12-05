From: Nigel Williams <nigel.d.williams@gmail.com>
Subject: Re: [ceph-users] experimental features
Date: Sat, 6 Dec 2014 08:46:44 +1100
Message-ID: <CACSYr9SGNtpt82-9FW7NS2bJ5NDn+xqKb60QsW1zdNTYpaPXmw@mail.gmail.com>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34305 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaLEVqp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 16:46:45 -0500
Received: by mail-la0-f43.google.com with SMTP id s18so912057lam.16
        for <ceph-devel@vger.kernel.org>; Fri, 05 Dec 2014 13:46:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Sat, Dec 6, 2014 at 4:36 AM, Sage Weil <sweil@redhat.com> wrote:
> - enumerate experiemntal options we want to enable
>...
>   This has the property that no config change is necessary when the
> feature drops its experimental status.

It keeps the risky options in one place too so easier to spot.

> In all of these cases, we can also make a point of sending something to
> the log on daemon startup.  I don't think too many people will notice
> this, but it is better than nothing.

Perhaps change the cluster health status to FRAGILE? or AT_RISK?
