From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Sat, 23 Jan 2016 15:20:47 -0500 (EST)
Message-ID: <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com> <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com> <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com> <20160119162902.GA21358@ultraspiritum.redhat.com> <1522288191.15295456.1453404176015.JavaMail.zimbra@redhat.com> <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com> <56A368C1.8000508@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:52927 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbcAWUUw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jan 2016 15:20:52 -0500
In-Reply-To: <56A368C1.8000508@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Erwan Velu <evelu@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Willem,

Agree.  The c++ notations and our declarations using them do centralize all this.  I don't know if we're actually defining anything equivalent to the coarse/fast clocks (it seems like a good idea, and I assumed we would), and it's straightforward to do.

(Adam may have, already.)

Matt

----- Original Message -----
> From: "Willem Jan Withagen" <wjw@digiware.nl>
> To: "Erwan Velu" <evelu@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Saturday, January 23, 2016 6:49:21 AM
> Subject: Re: About ceph_clock_now()
> 
> On 22-1-2016 17:00, Erwan Velu wrote:
> > Hey,
> > 
> > I've been able to continue this work and updated by branch accordingly.
> > I understand the benefit of using the ceph_time work but I feel that it
> > makes the change pretty verbose for a not a so big change (CLOCK_REALTIME
> > vs CLOCK_MONO).
> > 
> > This imply a change of all utime_t and makes the computations a little bit
> > more complex to read.
> > 
> > Does it worth the time spent on it ? If yes, I don't have any issue
> > continuing this way.
> > I'm pretty new to the project and would like to make the best PR as
> > possible.
> > So your insights on the under-work patch would be very helpful.
> 
> Erwan,
> 
> It would be real useful if references to CLOCK_(MONOTONIC|REALTIME)_*
> are centralised in one place (or at least as little as possible).
> And perhaps wrapped in simple function.
> 
> Reason is that CLOCK_*_COARSE are linux specific.
> 
> POSIX only has CLOCK_*, without the COARSE.
> FreeBSD has the CLOCK_*_FAST variant which equals the COARSE objective.
> (less accuracy, more speed)
> 
> So I've wrapped the code in a
> #if defined(__linux__)
> #	USE the COARSE variant
> #elif defined(__FreeBSD__)
> #	USE the FAST variant
> #else
> # 	Use the POSIX version as fallback
> #endif
> 
> Thanx,
> --WjW
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
