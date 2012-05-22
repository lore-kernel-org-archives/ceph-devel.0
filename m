From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Huge MDS log crashing the cluster
Date: Tue, 22 May 2012 09:18:53 -0700
Message-ID: <CADvuQRFtccEPA4k7X8R-_gGvPzz6Zt13Za1buPjp_5ufY-zk4Q@mail.gmail.com>
References: <loom.20120522T130047-937@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64311 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab2EVQTO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 12:19:14 -0400
Received: by yhmm54 with SMTP id m54so5602884yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 09:19:13 -0700 (PDT)
In-Reply-To: <loom.20120522T130047-937@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 22, 2012 at 4:03 AM, Madhusudhana U
<madhusudhana.u.acharya@gmail.com> wrote:
> Hi,
> I have dedicated 10G space for /var partition. But, MDS log has filled the
> entire /var partition and my cluster is not responding. How shall I fix this?
> and what I need to make so that /var partition won't fill up again.
>
> Appreciate any solution/suggestion on this. My entire ceph cluster became
> unresponsive.

The default logrotate script installed by ceph.deb rotates log files
daily and preserves 7 days of logs. If your /var is tiny, or you have
heavy debugging turned on, you probably need to rotate more often and
retain fewer log files. Or, if you're not using the debs, you'll need
to provide some other means of rotating the log files.
