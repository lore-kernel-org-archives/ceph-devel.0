From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Hard to debug problem with ceph_erasure_code
Date: Fri, 1 Apr 2016 11:34:16 +0200
Message-ID: <56FE4098.8000209@digiware.nl>
References: <56FD5A15.1080507@digiware.nl> <20160401051205.GA29567@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:40585 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbcDAJep (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Apr 2016 05:34:45 -0400
In-Reply-To: <20160401051205.GA29567@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 1-4-2016 07:12, Mykola Golub wrote:
> On Thu, Mar 31, 2016 at 07:10:45PM +0200, Willem Jan Withagen wrote:
> 
>> Does anybody have suggestions as how to track/debug this?
> 
> valgrind?
> 

Yup, tried that one, but it is sort of hard to find an intermittent
erroneous write. I tried --track-addr=<addr of m_exp_len> But most of
the time it is only written  at exact the code line it is supposed to be
written. So no info there.

So perhaps I need a different set of tests?

On average I need about 600 runs to catch one SIGSEGV.

BTW: tried it on 2 FreeBSD systems, and on both the behaviour is
identical. So it has got to be the code. And since 65000 runs on Linux
give no errors, it is also typical for the combo
FreeBSD/Clang/FreeBSD-packages.

--WjW

