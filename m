From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Ann Arbor Team's Flexible I/O Proposals (Ceph Next)
Date: Fri, 15 Apr 2016 18:12:33 -0400
Message-ID: <20160415221233.GA6331@ultraspiritum.redhat.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
 <CANP1eJHFQXjkUogms3hqP=cqvt4GJZ62LMsmjp9d2JR+jf_j_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbcDOWMg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2016 18:12:36 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0CC4C062C90
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 22:12:35 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-112-25.phx2.redhat.com [10.3.112.25])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3FMCY8C008279
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 18:12:35 -0400
Content-Disposition: inline
In-Reply-To: <CANP1eJHFQXjkUogms3hqP=cqvt4GJZ62LMsmjp9d2JR+jf_j_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 15/04/2016, Milosz Tanski wrote:
[snip]
> As librados is today, it encapsulates it's own networking and event
> code. This is pretty frustrating to apps that already have their own
> eventloop that want to integrate it.

When you say integrating with an event loop, would being able to hand off a
function or object to asynchronous calls that would then use whatever mechanism
your event loop had for submitting events be sufficient?

I'm not sure what you mean by networking in this case. Some means for the
library to ask your client to set up or terminate a connection when it needs to
talk to an OSD or monitor?

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
