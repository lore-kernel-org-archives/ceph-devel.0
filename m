From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] mds: drop unused find_ino_dir
Date: Wed, 18 Dec 2013 13:23:22 -0800
Message-ID: <CAPYLRzghpQ=tRuW2x8x-aX6jHUj3SOgiqWj74JhBugPWsA98-w@mail.gmail.com>
References: <orppovagjz.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34714 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab3LRVXX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 16:23:23 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so207102qcy.12
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 13:23:22 -0800 (PST)
In-Reply-To: <orppovagjz.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage applied this in commit f5d32a33d25a5f9ddccadb4c3ebbd5ccd211204f; thanks!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Tue, Dec 17, 2013 at 3:00 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> I was looking at inconsistencies in xattrs in my OSDs, and found out
> that only old dirs had the user.ceph.path attribute set.  Trying to
> figure out what this was about, I noticed the code that set this
> attribute was still present, but it was not called anywhere.  I decided
> to clean up the attribute from my cluster, and to wipe out the code that
> used to set it.  Here's the resulting patch.
>
>
>
> --
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
>
