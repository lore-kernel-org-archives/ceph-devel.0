From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Caught the first erroneous translated errorcode
Date: Tue, 20 Jun 2017 01:17:30 +0200
Message-ID: <75cdae8a-1e42-d13b-8046-cb5c7f24af2f@digiware.nl>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
 <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
 <20170619172916.GA27362@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25518 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752382AbdFSXRd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Jun 2017 19:17:33 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id B4F8343820
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 01:17:29 +0200 (CEST)
In-Reply-To: <20170619172916.GA27362@ultraspiritum.eng.arb.redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 19-6-2017 19:29, Adam C. Emerson wrote:
> On 17/06/2017, John Spray wrote:
>> Somewhat related perhaps: people running cephfs on ARM recently had
>> this problem, for that case the solution was simply to define in Ceph
>> some constants that mirror the linux ones, see commit 88d2da5e9.
> 
> We may wish to consider using std::error_code for Ceph's internal
> error stuff rather than trying to shoehorn everything into the POSIX +
> Whatever Linux Defines error codes. That way we could have a lot more
> specificity and preserve the source of the error while still defining
> an equivalence (where appropriate) to POSIX-derived error conditions.
> 

Jesse also suggested using `std:error_code`, and although that would be
a "wire" neutral system. This would still require to identify the
locations where conversion needs to be done.

And as such I'm going to first focus on fixing my current problem. Once
that is done it is clear where to do it. Only then rework the how.
So this is going on the long list with nice to have.

--WjW

