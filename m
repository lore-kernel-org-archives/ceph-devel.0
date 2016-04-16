From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: OSD set partitioning
Date: Fri, 15 Apr 2016 20:52:58 -0400
Message-ID: <20160416005257.GA6911@ultraspiritum.redhat.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
 <1382159806.12350948.1460765279854.JavaMail.zimbra@redhat.com>
 <CAFdRU72-CyuFRodb-HoNrBHWZRV7Xj4Ki-yHvxHPKAZeZ213Wg@mail.gmail.com>
 <69053371.12352935.1460766884621.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbcDPAxB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2016 20:53:01 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C1EE80083
	for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2016 00:53:00 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-112-25.phx2.redhat.com [10.3.112.25])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3G0qwFQ015277
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 20:52:59 -0400
Content-Disposition: inline
In-Reply-To: <69053371.12352935.1460766884621.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 15/04/2016, Shinobu Kinjo wrote:
> Does multiple masters you mentioned here mean logical OSDs running in
> one osd process described in # Interfaces #?

Those are two separate things. When I refer to 'multiple masters' I'm speaking
of the monitor service.

Currently, Ceph has a single set of monitors that acts as a group. One is the
master and the rest replicate all changes made by the master.

Here, we propose having several groups of monitors, each group with its own
master. Every group would be responsible for some subset of OSDs, determined by
partitioning the space of OSD ids up between them.

Each LogicalOSD would be tracked separately in the map. You should, in
principle, be able to back up an LogicalOSD's store, move it to another machine,
and load it into a process with a different set of LogicalOSDs the same way you
can, now, move one ceph-osd process from one physical machine to another.


-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
