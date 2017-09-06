From: Sage Weil <sage@newdream.net>
Subject: Re: admin_socket question
Date: Wed, 6 Sep 2017 13:14:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709061313530.16664@piezo.novalocal>
References: <CAO=rSOu+f9rcy=mTv0hk4PSDkyiphN5vJDnQ=nz+_RTfVNF7DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51225 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbdIFNO5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Sep 2017 09:14:57 -0400
In-Reply-To: <CAO=rSOu+f9rcy=mTv0hk4PSDkyiphN5vJDnQ=nz+_RTfVNF7DQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Cuzner <pcuzner@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 6 Sep 2017, Paul Cuzner wrote:
> Hi,
> 
> One of the users of cephmetrics has seen issues where the response to
> perf dump requests against an osd seems to hang. (issue #91 -
> https://github.com/ceph/cephmetrics/issues/91)
> 
> When I looked at the admin_command function in ceph[1], it looks to me
> that the socket interaction is defaulting to blocking mode? So if
> there is a delay in responding, the caller will see this hanging
> behaviour that was described in the issue.
> 
> If blocking mode is being used, can anyone explain why this is
> preferred over a non-blocking approach with 'select'?

The queries are generally very short running so there is little value in 
making them asynchronous.

In this case, it sounds like the OSD was hung for some other reason, 
though, so that a thread was holding a lock longer than it should, 
causing the command to hang.

Do you know what command was hung, or whether other commands were issued 
before it?

sage
