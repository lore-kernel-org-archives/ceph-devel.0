From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: What would a good OSD node hardware configuration look like?
Date: Wed, 7 Nov 2012 09:17:28 +0100
Message-ID: <CAJH6TXgRUUZ5h9gB_Zi-31aMj0r00HCjZ8jRZZCGd8_LSXaBqw@mail.gmail.com>
References: <5097F3BD.2000904@conversis.de>
	<50985677.6090708@inktank.com>
	<50987AB9.9030905@conversis.de>
	<50996548.1030602@inktank.com>
	<5099BAEB.3060905@conversis.de>
	<509A0F35.2000801@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61377 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2KGIR3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 03:17:29 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so734054eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 00:17:28 -0800 (PST)
In-Reply-To: <509A0F35.2000801@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

2012/11/7 Wido den Hollander <wido@widodh.nl>:
> Except that SSDs will mainly fail due to the amount of write cycles they had
> to endure.
>
> So in RAID-1 your SSDs will fail at almost the same time.
>
> With for example 8 OSDs in a server you better spread them out 50/50 over
> two SSDs.

But the OS should be installed on SSD, to allow the use of the whole
SATA/SAS disk as OSDs.
Without RAID-1 between SSDs, a disk failure will result it the whole node down.
