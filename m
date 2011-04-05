From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: Question about librados
Date: Tue, 05 Apr 2011 15:50:03 +0200
Message-ID: <inf6mb$ln4$1@dough.gmane.org>
References: <incab7$gnn$1@dough.gmane.org>	<BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>	<inedo0$3v2$1@dough.gmane.org> <BANLkTik1OakYf7aqeUd6AW=wVXB87T72eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41830 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab1DENu0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Apr 2011 09:50:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Q76eG-0008Bc-Ky
	for ceph-devel@vger.kernel.org; Tue, 05 Apr 2011 15:50:24 +0200
Received: from 233-250-103-145.static.glaslokaal.nl ([145.103.250.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 15:50:24 +0200
Received: from rutger by 233-250-103-145.static.glaslokaal.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 15:50:24 +0200
In-Reply-To: <BANLkTik1OakYf7aqeUd6AW=wVXB87T72eg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 04/05/2011 03:42 PM, Gregory Farnum wrote:
>
> Have you tried using the full make system (go to src dir,
> ./autogen.sh; ./configure; make)? All the required headers should get
> pulled in when you install the package, but they might not be in your
> default include paths.

No, I haven't tried compiling from source (yet). I did try the 
following, though

rutger@gonzo:~$ dpkg -S atomic_ops
dpkg-query: no path found matching pattern *atomic_ops*.

which made me conclude that I don't have the file. Probably a package 
thing; I'm using the

deb http://ceph.newdream.net/debian/ sid main

repository on Debian sid amd64.

Cheers,

Rutger


