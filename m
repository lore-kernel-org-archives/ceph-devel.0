From: John Spray <jspray@redhat.com>
Subject: Re: /var/lib/ceph/*/*/config
Date: Wed, 20 Jan 2016 10:42:07 +0000
Message-ID: <CALe9h7csaYPgL_SZtot9Y+idSJUxsL=e_QRaos+f_k51V0P6GA@mail.gmail.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35236 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934160AbcATKm3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 05:42:29 -0500
Received: by mail-lb0-f178.google.com with SMTP id bc4so2697406lbc.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jan 2016 02:42:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 19, 2016 at 3:15 PM, Sage Weil <sweil@redhat.com> wrote:
> I think we should add an optional 'config' file location to the config
> search path.  This would allow you to put customized options for an
> individual daemon in the daemon data directory.  Or, you could avoid
> putting a config in /etc/ceph entirely, so that the daemon data is
> completely self-contained on the device.  That would streamline boot disk
> failure (just reinstall OS and ceph package) or drive swaps between failed
> host hardware.
>
> What do you think?

Seems very reasonable.

In a related thought, I've been wishing that we could store a config
in the data directory for a different reason.  It would be nice if
daemons could self-set persistent configuration, so that we could make
options set over `tell` (optionally) persistent.  The idea is that if
a management tool wanted to e.g. configure log verbosity, it could do
it purely over ceph commands, rather than needing out-of-band (SSH)
access to modify files on disk (and to reconcile its changes with the
human-editable ceph.conf).

What if we had two (optional) config files in the data dir, one for
human consumption (to makes drive swaps and host rebuilds simpler),
and one machine generated for the daemon to update itself when
requested to remotely?

John
