From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: scoping daemon-helper replacement effort
Date: Fri, 29 Jul 2016 12:39:01 -0600
Message-ID: <CALqRxCxfJu4XBB=uSWX0FGk7=WPDv2twQgvOoUbqLGvda=3k1g@mail.gmail.com>
References: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
 <579B8A76.7020606@redhat.com> <CAKPXa=aHDPjiz4oG7Tvd_CtoNbvVmi=Da3T5FQirO9jCPJCpWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33835 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcG2SjD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 14:39:03 -0400
Received: by mail-vk0-f53.google.com with SMTP id s189so60389380vkh.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 11:39:02 -0700 (PDT)
In-Reply-To: <CAKPXa=aHDPjiz4oG7Tvd_CtoNbvVmi=Da3T5FQirO9jCPJCpWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 11:22 AM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
> If we just have to worry about systemd it would be much simpler compared to
> supporting various previous initd systems(14.04/7.0 etc). changes can
> affect only jewel+ branches.

Right, the Upstart stuff for Trusty would be a sticking point, but I'm
not too worried about that for now, since this is a ways' off.

Everybody should be moving to Jessie and Xenial, right? :)

> I still see some challenges here, some of the code in ceph_manager.py
> does pretty fast killing and revive of osd's, I think that would be possible
> with systemd and also generally KILL of process wont work since systemd
> will end up restart the process based on its config, So those cases have
> to be rewritten.

That's a good point about systemd automatically restarting the
daemons, that will need more scrutiny.

I see ceph_manager.py doing stuff like:

  self.ctx.daemons.get_daemon('osd', osd, self.cluster).stop()

and from teuthology/orchestra/daemon.py , the "stop()" method there
just calls close() on the daemon's stdin. From what Josh said, stdin
is simply there to keep the daemon alive for the duration of the test,
so this ceph_manager.py code is effectively like sending a TERM or
KILL signal.

In other words, I think there's no relevant difference between what
ceph_manager.py does to kill daemons today, and what "systemctl stop
ceph-osd@..." would do? That would solve the automatic restart
concern.

- Ken
