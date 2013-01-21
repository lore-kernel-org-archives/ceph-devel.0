From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: ceph replication and data redundancy
Date: Mon, 21 Jan 2013 13:08:42 +0000
Message-ID: <50FD3DDA.6060502@inktank.com>
References: <CAFSDvD0ouu-YwStP_RyOUj2K3vdiOBCZJR_PO8os5-x2cAMfsQ@mail.gmail.com> <50FC2967.6080207@widodh.nl> <48C16807A78A464DA590FC8010B37632@inktank.com> <CAFSDvD1M-7ZJWR=PQBZwkEWOM9ijQ0ManWPGrKBZTPvOWrb4KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:48838 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab3AUNIw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 08:08:52 -0500
Received: by mail-la0-f54.google.com with SMTP id gw10so5191373lab.41
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 05:08:51 -0800 (PST)
In-Reply-To: <CAFSDvD1M-7ZJWR=PQBZwkEWOM9ijQ0ManWPGrKBZTPvOWrb4KQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ulysse 31 <ulysse31@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On 01/21/2013 08:14 AM, Ulysse 31 wrote:
> Hi everybody,
>
> In fact, i found searching the doc on section "adding/removing a
> monitor", infos about the paxos system used for quorum establishment.
> Following the documentation, in a catastrophy scenario, i need to
> remove the other monitors configured on the other buildings.
> For better efficiency, i think i'll keep 1 monitor per building, and,
> if two other building fails, i will delete those two monitors from the
> configuration in order to access data again.
> I'll simulate that and see if it goes well.
> Thanks for your help and advices.

If you are set on that approach, you could just as well add a third 
monitor on one of the buildings (whichever you feel to be more 
resilient), and cut down the chances of an unavailable cluster if the 
other fails.

It doesn't solve your problem, but if the building with just one monitor 
fails, your cluster will still be available; if it's the other way 
around, you could do the manual recovery just the same anyway.

   -Joao

