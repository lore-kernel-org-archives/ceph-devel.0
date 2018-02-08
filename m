From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: Translating raw capacity to real data capacity in statfs
Date: Thu, 8 Feb 2018 14:03:21 -0500
Message-ID: <B1A3AABC-9D9A-4BAC-B94D-B85BD96A8B7C@redhat.com>
References: <D738D819-6452-41E3-AEED-D0EF5EB5B689@icloud.com>
 <CAAM7YA=41Zx2PT=_Rc2UY61NSUZUEp_cgP3abLuHFBioPMu-fg@mail.gmail.com>
 <alpine.DEB.2.11.1802081309540.15996@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:42985 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHTDY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 14:03:24 -0500
Received: by mail-yw0-f175.google.com with SMTP id u17so3373121ywg.9
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 11:03:24 -0800 (PST)
Received: from douglass-mbp-2.lan (96-33-254-202.static.kgpt.tn.charter.com. [96.33.254.202])
        by smtp.gmail.com with ESMTPSA id c13sm219183ywm.74.2018.02.08.11.03.22
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 11:03:22 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1802081309540.15996@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>



> On Feb 8, 2018, at 8:11 AM, Sage Weil <sage@newdream.net> wrote:
> 
> On Thu, 8 Feb 2018, Yan, Zheng wrote:
>> On Thu, Feb 8, 2018 at 10:47 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
>>> Hi Cepher,
>>> 
>>> Current statfs(2) in ceph kernel client provides raw capacity information of total/used/avail,
>>> but in the point of view of filesystem I think we actually more willing to see real data capacity instead of raw.
>>> 
>>> So I have a suggestion to translate raw capacity to real data capacity, it can be simply implemented by
>>> taking advantage of num.object_copies, the result may be not very accurate but still having reference significance.
>>> 
>> 
>> It's not that simple when there are multiple data pools.
> 
> I seem to remember someone (Doug or Jeff?) working on a patch that would 
> adjust the statfs result for a given directory based on the data pool and 
> the usual "max avail" style calculation that 'ceph df' uses per pool 
> (which is based on replication/ec multiplier and most-full osd)…?

I did that in: https://github.com/ceph/ceph/pull/16378 . This only works for the case where the filesystem uses a single data pool. In other cases, it falls back to the old behavior.

Cheers,
—Doug

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

