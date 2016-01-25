From: Erwan Velu <evelu@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 04:58:30 -0500 (EST)
Message-ID: <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com> <56A368C1.8000508@digiware.nl> <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com> <20160123215543.GA8011@ultraspiritum.redhat.com> <56A4BB20.1040305@digiware.nl> <56A4C8D2.6020303@digiware.nl> <20160125000337.GA19230@ultraspiritum.redhat.com> <56A5E61E.80705@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:42652 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446AbcAYJ6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 04:58:35 -0500
In-Reply-To: <56A5E61E.80705@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

>I would comment the last section: the #else with a remark that you
>select POSIX if nothing else, but that POSIX is more/unneeded accurate
>and slow.

I totally agree with your comment.
I'm pretty boring on that topic but keeping a well documented commit (in the commit message) that explains the following is very useful when reading a patch later.
- what was the issue
- how we fixed it
