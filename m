From: Ken Dreyer <ken.dreyer@inktank.com>
Subject: Re: Fixes for missing and replicated files in ceph.spec.in
Date: Tue, 4 Mar 2014 20:32:29 -0700
Message-ID: <CAOpHjdDdk+qHtiOa660JbEOgUKrfa4i0Asa3tT-om0fL3ow_jA@mail.gmail.com>
References: <CABAwU-ZCSVbkLUOvZBd8=+uHD1L6tVS5iAkpDNUS0_myP5Xndw@mail.gmail.com>
 <CAOpHjdDFygeaDfzOrB5HDOLc1tp-yvmBsnuvhYKKCDYcSWU0ww@mail.gmail.com>
 <alpine.DEB.2.00.1402211247430.17314@cobra.newdream.net> <CAOpHjdAvLm=+fv4FODtt75usc=+A9fWv9eXfsEE72cph7qYFgg@mail.gmail.com>
 <CABAwU-bG=v1Jxy3DoknGhEOX4cMZX32ruLw6DUpFayV1c6DKWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:54289 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155AbaCEDcu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Mar 2014 22:32:50 -0500
Received: by mail-vc0-f171.google.com with SMTP id le5so453591vcb.16
        for <ceph-devel@vger.kernel.org>; Tue, 04 Mar 2014 19:32:49 -0800 (PST)
In-Reply-To: <CABAwU-bG=v1Jxy3DoknGhEOX4cMZX32ruLw6DUpFayV1c6DKWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 21, 2014 at 9:25 PM, huang jun <hjwsm1989@gmail.com> wrote:
> we can also use test_* instead of listing all test_xx  files while
> building debian package

This works in my basic testing. Pull request submitted here:
https://github.com/ceph/ceph/pull/1371

- Ken
