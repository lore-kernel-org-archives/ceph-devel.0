From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Ideas for new ceph-mgr service
Date: Wed, 13 Jan 2016 16:15:36 -0500
Message-ID: <20160113211536.GA26123@ultraspiritum.redhat.com>
References: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com>
 <156637337.14721161.1452700430079.JavaMail.zimbra@redhat.com>
 <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com>
 <56969124.4040604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbcAMVPi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 16:15:38 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 1961F6E772
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 21:15:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56969124.4040604@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: John Spray <jspray@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 13/01/2016, Mark Nelson wrote:
[snip]
> My gut instinct is to agree with Matt on this one, but I know the pain of
> trying to develop web services in C++ so I can't get too ornery about it.
> If there are ways to keep it C++ throughout without too much pain I'd
> advocate that route.
[snip]

If the main concern is the annoyance of writing web services, would it make
sense to use some widely supported binary protocol (Protocol Buffers, Flat
Buffers, Cap'n Proto, etc.) that can be implemented easily in C++ and is well
supported in Python and other languages?

If we /need/ HTTP and JSON specifically (presumably for someone hacking up
management software in a web browser's JavaScript runtime) could we have a
Python translator that just shovels messages from the binary protocol to the
HTTP JSON protocol and back?

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
