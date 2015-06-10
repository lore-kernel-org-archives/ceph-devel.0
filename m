From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Build RPMs from git
Date: Wed, 10 Jun 2015 11:22:56 -0600
Message-ID: <55787270.10101@redhat.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>	<581259457.12927282.1433946627668.JavaMail.zimbra@redhat.com> <CAANLjFprkpfMdCk5HKMtCt1r2y8Og+8p2b3BjgxsoYWynCV8oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbbFJRW6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Jun 2015 13:22:58 -0400
In-Reply-To: <CAANLjFprkpfMdCk5HKMtCt1r2y8Og+8p2b3BjgxsoYWynCV8oA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/10/2015 09:44 AM, Robert LeBlanc wrote:
> This is really helpful, I was able to figure out what was needed in a
> tarball manually, but this is what I was really looking for to create
> the tarball.
> 
> Is there anyway to skip this step like in the deb build for really
> fast builds? I guess if I don't have retar a dozen times to tweak
> something every time because I forgot to add something to the tarball,
> it won't be so bad...

There is a "make_dist.sh" script on master that is going to eventually
replace this "make dist-bzip2" step. It still requires you to repack a
whole new tarball, though.

Sorry I'm not very familiar with the way that the Debian builds straight
out of Git work. Reading through ceph-build.git and autobuild-ceph.git,
it's not using git-buildpackage. How are you doing it?

- Ken
