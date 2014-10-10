From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Request for comments
Date: Fri, 10 Oct 2014 11:22:12 -0500
Message-ID: <CAMzumdaE+pPP2RzRhDrfsV1LjNAqQuM3qHQ5rB37ffsHFaySdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:44475 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaJJQWN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 12:22:13 -0400
Received: by mail-yk0-f171.google.com with SMTP id 79so1792894ykr.16
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 09:22:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When reading code for libcephfs.cc (giant branch) it wasn't apparent
to me for the lines 95 and lines 101 what the return values was
expected from the function calls init and mount other than 0.

It was only after tracing a bit of code did I see that error code such
as: -ENOENT and -EEXIST could be returned as well.

It would be awesome if comments were added for these functions to show
what the expected return values are going to be for these functions.

Thanks,

almightybeeij
