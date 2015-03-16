From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: xio messenger is not building by default
Date: Mon, 16 Mar 2015 10:31:26 -0600
Message-ID: <5507055E.6010109@redhat.com>
References: <2079341836.20.1426522829406.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbbCPQbf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Mar 2015 12:31:35 -0400
In-Reply-To: <2079341836.20.1426522829406.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Somnath Roy <Somnath.Roy@sandisk.com>

On 03/16/2015 10:20 AM, Matt W. Benjamin wrote:
> Hi,
> 
> Arent OFED dependencies already packaged?  I assumed that only Accelio would
> be a submodule.
> 

Thanks for pointing that out. It's in Fedora as libibverbs-devel, and
it's in Debian as libibverbs-dev. So you're right, Accelio is the only
one to be packaged.

Looking at configure.ac, does README.xio need to be updated to mention
librdmacm?

- Ken
