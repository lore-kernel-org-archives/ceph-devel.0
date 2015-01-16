From: Lipeng Wan <lipengwan86@gmail.com>
Subject: Is there any way to collect object-level I/O access traces in Ceph?
Date: Fri, 16 Jan 2015 14:28:45 -0500
Message-ID: <CAJqA8gsUn19CDswyeYiQj9Ex0vaQeybvBVDOx3nG2w70_esCAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:41758 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014AbbAPT2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 14:28:46 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so10302970ykp.11
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 11:28:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear all,

Does Ceph provide a way to collect object-level I/O access traces?
Specifically, can we collect the traces to record how many times each
object has been accessed (read, write, etc.) during a fixed period of
time?

Thanks!
LW
