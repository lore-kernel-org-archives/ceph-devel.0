From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Question about the implementation of bucket_straw_choose in src/crush/mapper.c
Date: Thu, 29 Mar 2012 17:16:01 +0800
Message-ID: <CALwGbP+0xWC=-zZYdx_D6ikgEq6NRYYfweEDn7z5WceCypPRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36853 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab2C2JQC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Mar 2012 05:16:02 -0400
Received: by iagz16 with SMTP id z16so2769793iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Mar 2012 02:16:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone, i'm proceeding reading source code of crush

i'm reading src/crush/mapper.c which is describing the core
implementation of crush alg.
in reading function bucket_straw_choose, i compare the implementation
with the idea written in the thesis and have some problem
understanding it.

in the thesis, it said that the length of straw should multiply the
weight of bucket item so that heavier items are more likely to be
selected.
in bucket_straw_choose, i see bucket->straws multiplying the hash value only.

next, i referred to crush.h to take a look at the data structure of
crush_bucket_straw, and found two members named 'straws' and
'item_weights'.

i just don't know whether 'weight' and 'straw' in the implementation
mean the same thing as in thesis. if so, why item_weights is not used
in bucket_straw_choose.

Thanks.
