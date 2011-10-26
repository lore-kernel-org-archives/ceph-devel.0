From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: ceph/hadoop benchmarking
Date: Wed, 26 Oct 2011 15:41:02 -0700 (PDT)
Message-ID: <2039347197.5499.1319668862176.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAORUGqBe-xdQ1bwifcN3kQEZ=0a72tkHsFU9TqXHvvED7DpS=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:41116 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab1JZWlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 18:41:03 -0400
In-Reply-To: <CAORUGqBe-xdQ1bwifcN3kQEZ=0a72tkHsFU9TqXHvvED7DpS=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>



----- Original Message -----
> From: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
>
> From my experience with Hadoop, the CLASSPATH approach seems
> definitely good enough, and gives us more flexibility.

I think that maybe the only thing that wouldn't work in this case
is integration into the Hadoop test harness. Other than that it
should work. Maybe there is a way to integrate?

-Noah
