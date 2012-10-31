From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 22:58:31 +0100
Message-ID: <CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
	<CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58449 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760833Ab2JaV6c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:58:32 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so746296eaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 14:58:31 -0700 (PDT)
In-Reply-To: <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

2012/10/31 Tren Blackburn <tren@eotnetworks.com>:
> Unless you're using btrfs which writes to the journal and osd fs
> concurrently, if you lose the journal device (such as due to a
> reboot), you've lost the osd device, requiring it to be remade and
> re-added.

I don't understood.
Loosing a journal, will result in the whole OSD lost?

AFAIK, Ceph will write to journal. After this write it will return an "OK".
After that, the journal is wrote (in background) to a disk, so,
loosing a journal should result in loosing that portion of data, not
the whole osd.

Now, in case of 3 replicated nodes, ceph will write the same data at
the same time to the three journals? If yes, loosing a single
journal/osd should not result in loss of data, because the same data
are still on other 2 nodes. In this case, should be possible to use a
tmpfs as journal and using the replica as redundancy.
