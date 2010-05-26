From: Sage Weil <sage@newdream.net>
Subject: Re: [wiki] debian package setup error
Date: Tue, 25 May 2010 19:48:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005251946160.24496@cobra.newdream.net>
References: <1274841548.11302.7.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33216 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759071Ab0EZCpG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 22:45:06 -0400
In-Reply-To: <1274841548.11302.7.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Asias He <asias.hejun@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 26 May 2010, Asias He wrote:
> Can anybody update the wiki page[1] for debian package setup.
>
> From:
> deb http://ceph.newdream.net/debian/ lenny ceph-testing
> deb-src http://ceph.newdream.net/debian/ lenny ceph-testing
> To:
> deb http://ceph.newdream.net/debian/ testing ceph-testing
> deb-src http://ceph.newdream.net/debian/ testing ceph-testing

Keep in mind that the first 'lenny' portion refers to the distribution the 
packages are built for (lenny, squeeze, sid or stable, testing, unstable) 
and the second bit refers to which ceph source branch is built.  Each 
branch is built for each distribution.  ceph-stable is the last release, 
ceph-testing is the release+fixes, and ceph-unstable is the bleeding edge.  
Mix and match!

sage
