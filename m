From: John Spray <jspray@redhat.com>
Subject: Re: Would it make sense to require ntp
Date: Fri, 6 Nov 2015 12:26:17 +0000
Message-ID: <CALe9h7eP-vabaMCYuLuEUO2pME-cRfUHVrOFgkzRcZNqxL2ZbA@mail.gmail.com>
References: <563C7BB1.7030500@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33356 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031995AbbKFM0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 07:26:38 -0500
Received: by lbbkw15 with SMTP id kw15so50647443lbb.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 04:26:37 -0800 (PST)
In-Reply-To: <563C7BB1.7030500@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 6, 2015 at 10:06 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Ceph:
>
> Recently I encountered some a "clock skew" issue with 0.94.3. I have
> some small demo clusters in AWS. When I boot them up, in most cases the
> cluster will start in HEALTH_WARN due to clock skew on some of the MONs.
>
> I surmise that this is due to a race condition between the ceph-mon and
> ntpd systemd services. Sometimes ntpd.service starts *after* ceph-mon -
> in this case the MON sees a wrong/unsynchronized time value.
>
> Now, even though ntpd.service starts (and fixes the time value) very
> soon afterwards, the cluster remains in clock skew for a long time - but
> that is a separate issue. What I would like to ask is this:
>
> Is there any reasonable Ceph cluster node configuration that does not
> include running the NTP daemon?

Only if there is some other time service replacing it.  I don't really
know of anyone using alternative ntp daemons, but it's a possibility
to consider before introducing a hard dependency on ntpd.

> If the answer is "no", would it make sense to make NTP a runtime
> dependency and tell the ceph-mon systemd service to wait for
> ntpd.service before it starts?

Just waiting for the service is quick, but it doesn't achieve any
effect on the clock other than promising that it will be synced at
some point in the future.  Wouldn't we have to wait for time sync
rather than just waiting for the service?  That could take a while.

My hunch is that users wouldn't appreciate the mon blocking until
times were in sync, they'd probably prefer to go ahead and start up,
but raise a warning (like we currently do).

Given all that, maybe the question is actually: why do the mons stay
in the skew state for so long after the clocks are corrected?

John
