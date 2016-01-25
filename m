From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 10:08:46 +0100
Message-ID: <56A5E61E.80705@digiware.nl>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com>
 <20160119162902.GA21358@ultraspiritum.redhat.com>
 <1522288191.15295456.1453404176015.JavaMail.zimbra@redhat.com>
 <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com>
 <56A368C1.8000508@digiware.nl>
 <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com>
 <20160123215543.GA8011@ultraspiritum.redhat.com>
 <56A4BB20.1040305@digiware.nl> <56A4C8D2.6020303@digiware.nl>
 <20160125000337.GA19230@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:34015 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669AbcAYJJA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 04:09:00 -0500
In-Reply-To: <20160125000337.GA19230@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Erwan Velu <evelu@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 25-1-2016 01:03, Adam C. Emerson wrote:
> On 24/01/2016, Willem Jan Withagen wrote:
>> Not to irritate, but I just updated my copy of ceph:master and I could
>> not find any trace of a reference to CLOCK_MONOTONIC_FAST, so it has to
>> be in any of the WIPs ??
> 
> I had meant that there was an abstraction there, rather than that we had
> CLOCK_MONOTONIC_FAST already. But, does:
> 
> https://github.com/ceph/ceph/pull/7340
> 
> Work under your system/seem a sane way of doing it?

That is 99,5% of what I had in my WIP.
The difference is that I matched it on __linux__ and  __FreeBSD__, but
yours is definitely even better, since it if-then-else on what is really
under observation.
I would comment the last section: the #else with a remark that you
select POSIX if nothing else, but that POSIX is more/unneeded accurate
and slow.

--WjW



