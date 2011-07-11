From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Support for {fa,i}notify
Date: Mon, 11 Jul 2011 09:33:02 -0700
Message-ID: <CAORUGqCG1RsvdW5n8zA6EZNxaTBjqs6U9vxrzu7GU179sgQ9kQ@mail.gmail.com>
References: <CAFtEh-fEDJq++32EKMQdaFVXJk050eY59Hj_vxjqHosSDAZ3Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40694 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab1GKQdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 12:33:24 -0400
Received: by eyx24 with SMTP id 24so1412393eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 09:33:23 -0700 (PDT)
In-Reply-To: <CAFtEh-fEDJq++32EKMQdaFVXJk050eY59Hj_vxjqHosSDAZ3Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 11, 2011 at 05:15, Damien Churchill <damoxc@gmail.com> wrote:
> I was wondering if there is plans for (or already is support for)
> inotify or fanotify when using the Ceph filesystem? In my tests it
> seemed to work okay locally but there weren't any notifications to
> another machine in the cluster.

The reason it works on the local machine is that the Linux VFS
provides that feature directly, without really interacting with Ceph.

I am not sure what it would take to support that feature in a
distributed fashion (or whether that's even possible with the current
kernel APIs), but I created a ticket requesting this feature:
http://tracker.newdream.net/issues/1296

If you wish to stay updated on the status of that feature, you can
create a user account in the tracker and "watch" the ticket, then
you'll be notified of any changes.
