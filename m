From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: Finding cores in ceph-helper is even more convoluted .....
Date: Fri, 11 Aug 2017 19:26:52 +0300
Message-ID: <20170811162651.GA13129@gmail.com>
References: <56f1b93d-7ec0-2515-e9cf-de5c3a659483@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34636 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdHKQ04 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Aug 2017 12:26:56 -0400
Received: by mail-lf0-f49.google.com with SMTP id g25so18258783lfh.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Aug 2017 09:26:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56f1b93d-7ec0-2515-e9cf-de5c3a659483@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 11, 2017 at 10:51:05AM +0200, Willem Jan Withagen wrote:

> Question is how to find out who generated the cores, and do they
> actually belong to the current test.

In FreeBSD case you can use procstat(1) to get process information
from the core.

E.g. `procstat -b core` will show path to the binary, `procstat -c core`
will show command line options, and `procstat -e core` will show
environment variables.

-- 
Mykola Golub
