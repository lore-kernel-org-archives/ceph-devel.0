From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: No lock on RBD allow several mount on different servers...
Date: Sun, 12 Aug 2012 01:50:05 +0200
Message-ID: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61937 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752887Ab2HKXu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 11 Aug 2012 19:50:26 -0400
Received: by lagy9 with SMTP id y9so1486594lag.19
        for <ceph-devel@vger.kernel.org>; Sat, 11 Aug 2012 16:50:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys,

With RBD images, the theory makes possible to mount them multiple
times on different servers, of course **no one** wants that. If you
care about the consistency of your data :D
I was wondering if ceph has any lock ability on the RBD device like
DRBD does with secondary resource. Apparently not, I was able to mount
an image on multiple server and wrote data on both.

Is this an incoming feature?

I don't really know the difficulty level that this kind of feature
implies, but it would be nice to have it.

Cheers!
