From: Casey Bodley <cbodley@redhat.com>
Subject: Re: coming in boost 1.66
Date: Wed, 20 Dec 2017 15:50:30 -0500
Message-ID: <e2e0c6c0-9bc5-a5a4-f8bb-a766e5f3dcb3@redhat.com>
References: <07a75940-72c6-8510-459b-4f4a0ad43d4b@redhat.com>
 <23b03cec-760d-5e32-2232-dfa6b90396f0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33708 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbdLTUud (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Dec 2017 15:50:33 -0500
Received: by mail-qt0-f172.google.com with SMTP id e2so30009836qti.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Dec 2017 12:50:32 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id q63sm5357648qke.41.2017.12.20.12.50.30
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 12:50:31 -0800 (PST)
In-Reply-To: <23b03cec-760d-5e32-2232-dfa6b90396f0@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 12/19/2017 01:56 PM, Casey Bodley wrote:
>
> On 11/27/2017 11:03 AM, Casey Bodley wrote:
>> There are a couple of interesting changes in the upcoming boost 1.66 
>> release, based on the work-in-progress release notes: 
>> http://www.boost.org/users/history/in_progress.html
>>
>> - the Beast library was accepted into boost earlier this year, and 
>> 1.66 will be its first release. We're currently including it in a 
>> submodule, so we'll need to come up with a strategy to transition.
>> - the Asio library is getting "interface changes to reflect the 
>> Networking TS" (which is awesome!) but we might see some compilation 
>> failures in radosgw as a result.
>>
>> Now that we have the tooling to build specific boost versions, how do 
>> people feel about forcing the update to 1.66 once we've got it 
>> tested? This could avoid the extra work needed to a) maintain the 
>> beast submodule alongside boost's, and b) work around any 
>> hypothetical api breakage in asio. Once 1.66 is out, we'll have a 
>> better idea how much work that actually requires, but I wanted to 
>> float the idea ahead of time.
>>
>> Casey
>
> Boost 1.66 was released yesterday! The boost::beast changes were 
> minimal (only one function name changed), but the changes to 
> boost::asio were extensive and necessitated major changes to my PR for 
> librados bindings at https://github.com/ceph/ceph/pull/19054. So I'm 
> still proposing that we pin our boost dependency at 1.66 to avoid 
> #ifdefs and build hackery to continue supporting earlier versions. 
> That PR includes the cmake changes to do this, though I'm happy to 
> pull those into a separate PR if necessary.
>
> Casey

It looks like part of updating the default boost version in cmake is to 
mirror that boost tarball on download.ceph.com (iirc this was because of 
sourceforge downtime). Could someone with access please upload a copy of 
https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.bz2 
so that it's available under download.ceph.com/qa/? You can see 
https://github.com/ceph/ceph/pull/19054/files#r157844349 for the 
relevant cmake logic.

Thanks,
Casey
