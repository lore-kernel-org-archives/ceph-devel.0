From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: How to make systemd unit files work in all supported distros?
Date: Mon, 8 Feb 2016 15:55:56 -0700
Message-ID: <CALqRxCwzm-SB6j6VRzHzt+eefLbCB5cjuurP1mnHGAZ_Exjy2g@mail.gmail.com>
References: <56B86372.4020600@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33790 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbcBHWz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 17:55:57 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so152789301wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 14:55:56 -0800 (PST)
In-Reply-To: <56B86372.4020600@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Which executables are different? Fedora's pretty flexible about this;
I'm sure we could ship ceph-disk in /usr/bin if it lets us align with
SUSE or whatever.

- Ken

On Mon, Feb 8, 2016 at 2:44 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> In master we currently have an issue with the systemd unit files in that
> they contain hard-coded paths that are specific to RH/CentOS/Fedora. Other
> distros can and do have the executables in different places.
>
> I opened a bug[1] for this, but before I go off trying to fix it I would
> like to solicit your feedback on the following possible approaches I came up
> with (and/or "turn me on" to a different approach):
>
> (1) Rely on PATH. Basically, instead of running executables directly, run
> them by "/bin/sh -c", which summons the system PATH to help find the
> executables. See https://github.com/ceph/ceph/pull/6803 for an example of
> this.
>
> (2) Set environment variables in /etc/sysconfig/ceph. Systemd has an
> EnvironmentFile directive which reads environment variables from a file. If
> this were pointed to /etc/sysconfig/ceph (as it is in several unit files
> already), we could set the distro-specific parts of the paths there and
> write the paths similar to how we do it in the spec file.
>
> (3) Generate unit files at build time. In this approach, the unit files
> would exist in the source tree as templates (e.g. ceph-osd@.service.in) and
> these would get transformed into the "real" unit files at build time. The
> ceph-detect-init utility could be used to determine the distro and the
> Makefile logic would then fill in the templates as needed for the distro.
>
> Of these three approaches, only (3) would seem to be general enough to work
> nicely for all distros. (For example, EnvironmentFile will need to be set to
> /etc/default/ceph on Debianesque systems and there is no obvious way to set
> *this* path as an environment variable.)
>
> Any thoughts on this? Thanks in advance!
>
> [1] http://tracker.ceph.com/issues/14687
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
