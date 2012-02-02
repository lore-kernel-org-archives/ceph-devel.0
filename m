From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Thu, 2 Feb 2012 09:52:04 -0800
Message-ID: <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
	<4F29CDAA.408@sandia.gov>
	<CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
	<4F2AABF5.6050803@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53435 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078Ab2BBRwF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 12:52:05 -0500
Received: by iacb35 with SMTP id b35so3428414iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 09:52:04 -0800 (PST)
In-Reply-To: <4F2AABF5.6050803@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> I'm currently running 24 OSDs/server, one 1TB 7200 RPM SAS drive
> per OSD. =A0During a test I watch both OSD servers with both
> vmstat and iostat.
>
> During a "good" period, vmstat says the server is sustaining > 2 GB/s
> for multiple tens of seconds. =A0Since I use replication factor 2, th=
at
> means that server is sustaining > 500 MB/s aggregate client throughpu=
t,
> right? =A0During such a period vmstat also reports ~10% CPU idle.
>
> During a "bad" period, vmstat says the server is doing ~200 MB/s,
> with lots of idle cycles. =A0It is during these periods that
> messages stuck in the policy throttler build up such long
> wait times. =A0Sometimes I see really bad periods with aggregate
> throughput per server < 100 MB/s.
>
> The typical pattern I see is that a run starts with tens of seconds
> of aggregate throughput > 2 GB/s. =A0Then it drops and bounces around
> 500 - 1000 MB/s, with occasional excursions under 100 MB/s. =A0Then
> it ramps back up near 2 GB/s again.

Hmm. 100MB/s is awfully low for this theory, but have you tried to
correlate the drops in throughput with the OSD journals running out of
space? I assume from your setup that they're sharing the disk with the
store (although it works either way), and your description makes me
think that throughput is initially constrained by sequential journal
writes but then the journal runs out of space and the OSD has to wait
for the main store to catch up (with random IO), and that sends the IO
patterns all to hell. (If you can say that random 4MB IOs are
hellish.)
I'm also curious about memory usage as a possible explanation for the
more dramatic drops.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
