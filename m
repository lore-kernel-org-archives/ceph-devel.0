From: Wido den Hollander <wido@widodh.nl>
Subject: Re: 'log dir' directive respected no longer?
Date: Thu, 25 Aug 2011 09:12:07 +0200
Message-ID: <1314256327.3223.37.camel@wido-laptop>
References: <CAN4=B2mqHxzhDLh9R_yzstsuCcaBCK78MeZZFomzCkWowUqbdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:41510 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab1HYHMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 03:12:10 -0400
In-Reply-To: <CAN4=B2mqHxzhDLh9R_yzstsuCcaBCK78MeZZFomzCkWowUqbdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On Wed, 2011-08-24 at 23:16 -0700, Brian Chrisman wrote:
> I've noticed the 'log dir' directive in my ceph.conf no longer tells
> logs where to go.
> Am I missing something?

You probably are. The 'log dir' directive has become obsolete a few
versions back (not sure which one though).

There have been some discussions about this on IRC:
* http://irclogs.ceph.widodh.nl/index.php?date=2011-04-05
* http://irclogs.ceph.widodh.nl/index.php?date=2011-04-14

Anyway, stick with 'log file = /var/log/ceph/$name.$id.log', that should
work.

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


