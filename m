From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Separating clients data
Date: Wed, 17 Aug 2011 09:47:20 -0700
Message-ID: <CAORUGqCk9SnOLGaz=iS7rABYdEHMrXamOCF1JdHPHJaP_vcREQ@mail.gmail.com>
References: <CAGqxmDOGnrRPgyRFBW28f6zm7Fy-mrhSbBERceZD=KeU3P4GvA@mail.gmail.com>
 <CAORUGqCz=ba9HuJCc4FEqFq87S0xW0Jxqz2szBsPd-w4wZnsjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33670 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab1HQQrl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 12:47:41 -0400
Received: by yie30 with SMTP id 30so895041yie.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2011 09:47:40 -0700 (PDT)
In-Reply-To: <CAORUGqCz=ba9HuJCc4FEqFq87S0xW0Jxqz2szBsPd-w4wZnsjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Maciej_Ga=C5=82kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

2011/8/17 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> This seems to be possible with Ceph as it is now, but it is definitely
> not the normal setup. As in, test carefully and understand you're
> going off the beaten path.

This feature combo is now in the tracker as
http://tracker.newdream.net/issues/1401

Summarizing the IRC conversation that came up after the initial email:

- MISSING functionality: nothing currently prevents customerA from
running find /customerB and seeing all the file metadata, or even
root@customerA from running rm -rf /customerB; the pool access control
only protects the file contents, and if the uids overlap, the files
are really considered to have the same owner

- there's also a concept of "auid" that may be relevant; it is used
for e.g. noting rados pool owners, and can be used in the caps to do a
bit of abstraction like 'read and write any pool with owner=my_auid',
instead of needing to list the pools explicitly
