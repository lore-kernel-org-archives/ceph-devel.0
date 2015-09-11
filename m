From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: pet project: OSD compatible daemon
Date: Fri, 11 Sep 2015 10:08:41 -0400 (EDT)
Message-ID: <1005119049.15552536.1441980521113.JavaMail.zimbra@redhat.com>
References: <55EFF1A6.9060201@dachary.org> <CAFdRU728GucijsJgcw+do9dp=JLx6KpLvr42apUU1vrgxLT7Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34595 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbIKOJo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 10:09:44 -0400
In-Reply-To: <CAFdRU728GucijsJgcw+do9dp=JLx6KpLvr42apUU1vrgxLT7Ug@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

What I'm thinking of is to use fluentd to get log with
quite human-readable format.

Is it same of what you are thinking of?

Shinobu

----- Original Message -----
=46rom: "Shinobu" <shinobu.kj@gmail.com>
To: skinjo@redhat.com
Sent: Friday, September 11, 2015 6:16:18 PM
Subject: Fwd: pet project: OSD compatible daemon

---------- Forwarded message ----------
=46rom: Loic Dachary <loic@dachary.org>
Date: Wed, Sep 9, 2015 at 5:45 PM
Subject: pet project: OSD compatible daemon
To: Ceph Development <ceph-devel@vger.kernel.org>


Hi Ceph,

I would like to try to write an OSD compatible daemon, as a pet project=
, to
learn Go and better understand the message flow. I suspect it may also =
be
useful for debug purposes but that's not my primary incentive.

Has anyone tried something similar ? If so I'd happily contribute inste=
ad
of starting something from scratch.

Cheers

P.S. Since it's a pet project it's likely to take months before there i=
s
any kind of progress ;-)

--
Lo=C3=AFc Dachary, Artisan Logiciel Libre




--=20
Email:
 - shinobu@linux.com <shinobu@linux.com>
Blog:
 - Life with Distributed Computational System based on OpenSource
<http://i-shinobu.hatenablog.com/>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
