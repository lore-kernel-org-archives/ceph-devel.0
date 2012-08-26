From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: About sparse images
Date: Sun, 26 Aug 2012 20:11:53 +0200
Message-ID: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60315 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab2HZSMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 14:12:15 -0400
Received: by lbbgj3 with SMTP id gj3so2097381lbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 11:12:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all!

I know that ceph images (rbd) are sparse. It's good but I have some
interrogations about the ceph -s (-w) output. Let's say your create a
10G image, map it, format it and mount it. Finally you filled up the
entire space available. You notice that the 'data' and 'used' space
had grown. Now delete the content of your image but **not** this
image, not now. You notice that nothing changed from the ceph output,
it's not surprising because of the sparse capability. At this point of
time  the output from the command ceph is neither right nor wrong. It
only shows the space used by the sparse image, but it doesn't mean
that you have 'real' data in it, just a simple object allocation. It's
not so relevant, the only solution is to remove the image (obviously).
My feeling is that we should be careful about the ceph's output, it's
not a good indicator for 'real' data. Ok Ceph won't replace a
monitoring system but I'll be happy to trust the ceph output at 100%
:)

I would appreciate some reactions about that :)

Thank you in advance.

Cheers!
