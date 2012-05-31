From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Question about libcephfs mounting mechanism
Date: Thu, 31 May 2012 13:35:56 +0900
Message-ID: <CAHwdYF15M3FuiQicZBqZThz63g6AVGYGEHFutXktx64XrWNyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.nap.gsic.titech.ac.jp ([131.112.222.51]:56027 "EHLO
	mail1.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750899Ab2EaEga (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 May 2012 00:36:30 -0400
Received: from 209.85.217.174 (209.85.217.174 [209.85.217.174])
	by mail1.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF15M3FuiQicZBqZThz63g6AVGYGEHFutXktx64XrWNyEQ@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 13:36:21 +0900
Received: by lbbgm6 with SMTP id gm6so544428lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 21:36:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear all,

I want to inquire on ceph's internal mounting mechanism. I am using
wip-java-cephfs API to access Ceph internal file system directly.
I want to create several threads that access cephFS simultaneously and
independently, i.e. the mounting in each thread is
independent from the other's, and there is no shared underlying data
structure. As far as I know, java-ceph does not use shared structure,
but I'm not so sure about the underlying code in libcephfs though. I'm
worried that it may be similar to Virtual File System layer, upon
which multiple threads can access concurrently but internally the
mounting point is shared. I hope somebody with experience with Ceph
can help me answer this question.

Thank you very much,

Best regards,
Nam Dang
Tokyo Institute of Technology
Tokyo, Japan
