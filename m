From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Wed, 13 Jan 2016 09:52:14 -0500 (EST)
Message-ID: <1643613416.14636131.1452696734454.JavaMail.zimbra@redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com> <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com> <20160112173248.GA8218@ultraspiritum.redhat.com> <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:36250 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbcAMOwP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 09:52:15 -0500
In-Reply-To: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Erwan Velu <evelu@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "Erwan Velu" <evelu@redhat.com>
> Cc: "Adam C. Emerson" <aemerson@redhat.com>, "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, January 13, 2016 8:48:00 AM
> Subject: Re: About ceph_clock_now()
> 

> > 
> > You mean we could switch some of ceph_clock_now() calls to ceph_time ?
> > We could use coarse_mono_clock to perform that.
> > 
> > If you agree that switching code like the one I'm speaking is valuable,
> > I can work on it.
> 
> That would be great!

Yes, ack.  A coordinated effort to propagate the new interfaces changes through the codebase would be of great help.

Matt

> 
> sage
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
