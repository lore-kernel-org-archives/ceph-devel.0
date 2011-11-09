From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:22:59 -0800 (PST)
Message-ID: <459545171.47237.1320873779453.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAF3hT9BGbAVrFhZuXYGw7Qfaed4O_E=TGKOAyX4vQkre_a-XeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:43083 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1KIVW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:22:59 -0500
In-Reply-To: <CAF3hT9BGbAVrFhZuXYGw7Qfaed4O_E=TGKOAyX4vQkre_a-XeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

----- Original Message -----
> From: "Gregory Farnum" <gregory.farnum@dreamhost.com>
> 
> I can't imagine anybody needing location data inside of a fast path,
> in any case. So it probably shouldn't matter, and for any bizarre case
> where it does we can probably expect a certain level of knowledge!
> -Greg

Interestingly, Hadoop's start-up phase a big time sink. With 64 MB blocks
and a 1 TB data set, we'd make something like 16,000 calls to get block
location data which is serialized with the start of the job.

-Noah
