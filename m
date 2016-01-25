From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Sun, 24 Jan 2016 19:03:37 -0500
Message-ID: <20160125000337.GA19230@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com>
 <20160119162902.GA21358@ultraspiritum.redhat.com>
 <1522288191.15295456.1453404176015.JavaMail.zimbra@redhat.com>
 <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com>
 <56A368C1.8000508@digiware.nl>
 <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com>
 <20160123215543.GA8011@ultraspiritum.redhat.com>
 <56A4BB20.1040305@digiware.nl>
 <56A4C8D2.6020303@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbcAYADj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Jan 2016 19:03:39 -0500
Content-Disposition: inline
In-Reply-To: <56A4C8D2.6020303@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Erwan Velu <evelu@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 24/01/2016, Willem Jan Withagen wrote:
> Not to irritate, but I just updated my copy of ceph:master and I could
> not find any trace of a reference to CLOCK_MONOTONIC_FAST, so it has to
> be in any of the WIPs ??

I had meant that there was an abstraction there, rather than that we had
CLOCK_MONOTONIC_FAST already. But, does:

https://github.com/ceph/ceph/pull/7340

Work under your system/seem a sane way of doing it?

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
