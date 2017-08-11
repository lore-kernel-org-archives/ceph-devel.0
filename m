From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Finding cores in ceph-helper is even more convoluted .....
Date: Fri, 11 Aug 2017 18:43:45 +0200
Message-ID: <f922b266-ad37-2203-7b56-587c5103b6f0@digiware.nl>
References: <56f1b93d-7ec0-2515-e9cf-de5c3a659483@digiware.nl>
 <20170811162651.GA13129@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50695 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752703AbdHKQnv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Aug 2017 12:43:51 -0400
In-Reply-To: <20170811162651.GA13129@gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <to.my.trociny@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11-8-2017 18:26, Mykola Golub wrote:
> On Fri, Aug 11, 2017 at 10:51:05AM +0200, Willem Jan Withagen wrote:
> 
>> Question is how to find out who generated the cores, and do they
>> actually belong to the current test.
> 
> In FreeBSD case you can use procstat(1) to get process information
> from the core.
> 
> E.g. `procstat -b core` will show path to the binary, `procstat -c core`
> will show command line options, and `procstat -e core` will show
> environment variables.

Thanx for the pointer. I keep forgetting that procstat exists, let alone
what it can do.

Perhaps one of these will help to determine if any of the cores is
actually part of the current test, which different from just knowing
it's name and things. Could be that the environment gives enough to do
some selection on it.

It is going to rain a lot during the weekend. So probably will have some
toy time to spare.

--WjW



