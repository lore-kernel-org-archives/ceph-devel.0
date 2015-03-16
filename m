From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: xio messenger is not building by default
Date: Mon, 16 Mar 2015 12:33:49 -0400 (EDT)
Message-ID: <1205925764.32.1426523629379.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <5507055E.6010109@redhat.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3519 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbbCPQd6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Mar 2015 12:33:58 -0400
In-Reply-To: <5507055E.6010109@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Somnath Roy <Somnath.Roy@sandisk.com>

Hi,

Yes, agree.  We do depend on librdmacm!

Matt

----- "Ken Dreyer" <kdreyer@redhat.com> wrote:

> On 03/16/2015 10:20 AM, Matt W. Benjamin wrote:
> > Hi,
> > 
> > Arent OFED dependencies already packaged?  I assumed that only
> Accelio would
> > be a submodule.
> > 
> 
> Thanks for pointing that out. It's in Fedora as libibverbs-devel, and
> it's in Debian as libibverbs-dev. So you're right, Accelio is the
> only
> one to be packaged.
> 
> Looking at configure.ac, does README.xio need to be updated to
> mention
> librdmacm?
> 
> - Ken

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
