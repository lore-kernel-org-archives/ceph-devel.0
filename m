From: Damien Churchill <damoxc@gmail.com>
Subject: Re: Support for {fa,i}notify
Date: Mon, 11 Jul 2011 20:49:40 +0100
Message-ID: <CAFtEh-fy4ugqAyM+k2+bHwmpgp87DQfAo43VFUb-Tg61qeStBw@mail.gmail.com>
References: <CAFtEh-fEDJq++32EKMQdaFVXJk050eY59Hj_vxjqHosSDAZ3Xg@mail.gmail.com>
	<CAORUGqCG1RsvdW5n8zA6EZNxaTBjqs6U9vxrzu7GU179sgQ9kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53983 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab1GKTub (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 15:50:31 -0400
Received: by yxi11 with SMTP id 11so1651645yxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 12:50:30 -0700 (PDT)
In-Reply-To: <CAORUGqCG1RsvdW5n8zA6EZNxaTBjqs6U9vxrzu7GU179sgQ9kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 11 July 2011 17:33, Tommi Virtanen <tommi.virtanen@dreamhost.com> wrote:
> On Mon, Jul 11, 2011 at 05:15, Damien Churchill <damoxc@gmail.com> wrote:
>> I was wondering if there is plans for (or already is support for)
>> inotify or fanotify when using the Ceph filesystem? In my tests it
>> seemed to work okay locally but there weren't any notifications to
>> another machine in the cluster.
>
> The reason it works on the local machine is that the Linux VFS
> provides that feature directly, without really interacting with Ceph.
>
> I am not sure what it would take to support that feature in a
> distributed fashion (or whether that's even possible with the current
> kernel APIs), but I created a ticket requesting this feature:
> http://tracker.newdream.net/issues/1296
>
> If you wish to stay updated on the status of that feature, you can
> create a user account in the tracker and "watch" the ticket, then
> you'll be notified of any changes.
>

Excellent, thank you for your response.
