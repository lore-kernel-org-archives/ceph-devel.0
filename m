From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: 0.31
Date: Sun, 10 Jul 2011 16:24:59 +0300
Message-ID: <4E19A82B.6020001@ufm.su>
References: <4E19837D.7030702@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:60447 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384Ab1GJNZD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Jul 2011 09:25:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 29493600485
	for <ceph-devel@vger.kernel.org>; Sun, 10 Jul 2011 16:25:01 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vEEjwBHbb49 for <ceph-devel@vger.kernel.org>;
	Sun, 10 Jul 2011 16:25:01 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id F2B9E600484
	for <ceph-devel@vger.kernel.org>; Sun, 10 Jul 2011 16:25:00 +0300 (EEST)
In-Reply-To: <4E19837D.7030702@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi again.

I start to fear.

After deleting one of file I got:

2011-07-10 16:23:00.062754   log 2011-07-10 16:22:51.410099 mds0 
10.5.51.230:6800/24957 5 : [ERR] loaded dup inode 1000000a5e9 [2,head] 
v244 at 
/dcvolia/amanda/state/servers/index/ticket.dcv/_/20110708000502_7.gz, 
but inode 1000000a5e9.head v1011 already exists at ~mds0/stray0/1000000a5e9

P.S. What is it?

2011-07-10 16:21:51.188911   log 2011-07-10 16:21:50.024355 mds0 
10.5.51.230:6801/24695 11 : [ERR] unmatched fragstat size on single 
dirfrag 600, inode has f(v5 m2011-07-10 16:21:50.023759 21=18+3), 
dirfrag has f(v5 m2011-07-10 16:21:50.023759 1=1+0)
2011-07-10 16:21:51.188911   log 2011-07-10 16:21:50.024373 mds0 
10.5.51.230:6801/24695 12 : [ERR] unmatched rstat rbytes on single 
dirfrag 600, inode has n(v5 rc2011-07-10 16:21:50.023759 b12892122 
21=18+3), dirfrag has n(v5 rc2011-07-10 16:21:50.023759 1=1+0)

WBR,
     Fyodor.

