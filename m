From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, runtimes for seperate tests.
Date: Thu, 3 Dec 2015 15:12:46 +0100
Message-ID: <56604DDE.2010501@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl> <5660106F.90202@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:21425 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbbLCOM5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 09:12:57 -0500
In-Reply-To: <5660106F.90202@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On 3-12-2015 10:50, Willem Jan Withagen wrote:
> On 2-12-2015 22:10, Willem Jan Withagen wrote:
>
>> Running gmake check
>
> Now I start wondering how long certain tests are able to run:
>
> I've killed:
>       unittest_chain_xattr
> because it was running already voor 12 hours.
>
> And unittest_lfnindex is also running for > 20 minutes....
>
> Is there a way to specify something like a max runtime for these tests?
> So that I am able to run the testset repeatedly, to monitor regression
> once I start changing code.
>
> I saw Loic talk about some of the expected test runtimes.
> But having a better feeling per specific test would be useful in getting
> the test to progress

Excluded all rbd tests, and killed some of the processes that ran > 1200 
secs.
But below the results...

Need to figure the Makefiles out to exclude rbd testing.
And perhaps start a timelimit on running processes.

--WjW

============================================================================
Testsuite summary for ceph 10.0.0
============================================================================
# TOTAL: 119
# PASS:  87
# SKIP:  0
# XFAIL: 0
# FAIL:  32
# XPASS: 0
# ERROR: 0
============================================================================
See src/test-suite.log
Please report to ceph-devel@vger.kernel.org
============================================================================
