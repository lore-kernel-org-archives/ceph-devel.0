From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Questions about bucket algorithm and bucket choose
Date: Sun, 15 Apr 2012 14:12:02 +0800
Message-ID: <CALwGbPKqXyubH1O-cBoYm-LaJ86LR3QOzzd=mYyL8HESx1+13g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63509 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2DOGMD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Apr 2012 02:12:03 -0400
Received: by iagz16 with SMTP id z16so6021983iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 14 Apr 2012 23:12:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi everyone.

One question is about performance of bucket algorithms, it seems that
on every aspect, straw bucket is at least not worse than list bucket.
So does it mean we shall always use straw bucket instead of list
bucket?

I was browsing branch tree of ceph to trace back earlier versions of
the implementation. I noticed that crush_uniform_bucket_choose has
been significantly changed. I read the comment which said the original
method (seems to be described in the thesis) is not random enough and
has some bad behavior, but I don't know what kind of bad behavior is
that. For what reason a random permutation is a better choice?

Regards,
Sam
