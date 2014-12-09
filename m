From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Is there any documents to describe the architecture of ceph unit
 test based on gtest
Date: Tue, 9 Dec 2014 12:52:01 -0800
Message-ID: <CAC6JEv9FP4ajg5qgiduGj46GWPAaO6ETJ3hSPQs=W7T5SG40RQ@mail.gmail.com>
References: <CALZt5jycKO4DQcSnRptWXiGKj3GJ+oqVvZZscppj+m4qOypDNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38366 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaLIUwD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Dec 2014 15:52:03 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so1349247iec.16
        for <ceph-devel@vger.kernel.org>; Tue, 09 Dec 2014 12:52:02 -0800 (PST)
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com. [209.85.223.170])
        by mx.google.com with ESMTPSA id t15sm1102150ioi.21.2014.12.09.12.52.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 12:52:01 -0800 (PST)
Received: by mail-ie0-f170.google.com with SMTP id rd18so1346148iec.29
        for <ceph-devel@vger.kernel.org>; Tue, 09 Dec 2014 12:52:01 -0800 (PST)
In-Reply-To: <CALZt5jycKO4DQcSnRptWXiGKj3GJ+oqVvZZscppj+m4qOypDNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 9, 2014 at 1:50 AM, Nicheal <zay11022@gmail.com> wrote:
> Hi, all
>
> Is any guideline that describes how to run the ceph unit test, and its
> basic architecture?

You can run them all by executing "make check [-j N]". The executables
run as part of that are specified in the makefiles throughout the
project structure (CHECK_programs or similar). For more on how the
gtest framework is set up, you should look at the gtest docs. ;)
-Greg
