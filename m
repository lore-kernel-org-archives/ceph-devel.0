From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: XioMessenger (RDMA) Performance results
Date: Tue, 18 Mar 2014 20:31:54 -0400 (EDT)
Message-ID: <833318366.162.1395189114645.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <5328AD47.1090707@inktank.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3795 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757904AbaCSAcF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Mar 2014 20:32:05 -0400
In-Reply-To: <5328AD47.1090707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>, Eyal Salomon <esalomon@mellanox.com>, Yaron Haviv <yaronh@mellanox.com>

Hi Mark,

----- "Mark Nelson" <mark.nelson@inktank.com> wrote:

> 
> Very nice!  were you just writing to memory on the backend?

These are just passing 64K message payloads across the sender/receiver,
it's a message-passing workload comparison only.

> 
> Mark
> 
> >
> > Regards, Yaron
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
