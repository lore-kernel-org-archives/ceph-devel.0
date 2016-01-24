From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: About ceph_clock_now()
Date: Sun, 24 Jan 2016 12:53:04 +0100
Message-ID: <56A4BB20.1040305@digiware.nl>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
 <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com>
 <20160119162902.GA21358@ultraspiritum.redhat.com>
 <1522288191.15295456.1453404176015.JavaMail.zimbra@redhat.com>
 <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com>
 <56A368C1.8000508@digiware.nl>
 <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com>
 <20160123215543.GA8011@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:12082 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbcAXLxf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Jan 2016 06:53:35 -0500
In-Reply-To: <20160123215543.GA8011@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Erwan Velu <evelu@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 23-1-2016 22:55, Adam C. Emerson wrote:
> On 23/01/2016, Matt Benjamin wrote:
>> Hi Willem,
>>
>> Agree.  The c++ notations and our declarations using them do centralize all this.  I don't know if we're actually defining anything equivalent to the coarse/fast clocks (it seems like a good idea, and I assumed we would), and it's straightforward to do.
>>
>> (Adam may have, already.)
> 
> We do. We can switch out ceph::coarse_mono_clock for BSD's FAST MONO CLOCK or on
> systems that don't have a coarse/fast option, just fall back to CLOCK_MONOTONIC
> easily.
> 
Cool,

Last time I tried a testrun after catching up to HEAD, I got quite a few
compiletime errors.
Guess I've got to catch up again.

--WjW

