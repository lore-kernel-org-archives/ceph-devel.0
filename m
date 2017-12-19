From: Casey Bodley <cbodley@redhat.com>
Subject: Re: coming in boost 1.66
Date: Tue, 19 Dec 2017 13:56:22 -0500
Message-ID: <23b03cec-760d-5e32-2232-dfa6b90396f0@redhat.com>
References: <07a75940-72c6-8510-459b-4f4a0ad43d4b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:42805 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdLSS4Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Dec 2017 13:56:25 -0500
Received: by mail-qt0-f176.google.com with SMTP id g9so25435828qth.9
        for <ceph-devel@vger.kernel.org>; Tue, 19 Dec 2017 10:56:25 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id r9sm10115933qtf.82.2017.12.19.10.56.23
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2017 10:56:23 -0800 (PST)
In-Reply-To: <07a75940-72c6-8510-459b-4f4a0ad43d4b@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


On 11/27/2017 11:03 AM, Casey Bodley wrote:
> There are a couple of interesting changes in the upcoming boost 1.66 
> release, based on the work-in-progress release notes: 
> http://www.boost.org/users/history/in_progress.html
>
> - the Beast library was accepted into boost earlier this year, and 
> 1.66 will be its first release. We're currently including it in a 
> submodule, so we'll need to come up with a strategy to transition.
> - the Asio library is getting "interface changes to reflect the 
> Networking TS" (which is awesome!) but we might see some compilation 
> failures in radosgw as a result.
>
> Now that we have the tooling to build specific boost versions, how do 
> people feel about forcing the update to 1.66 once we've got it tested? 
> This could avoid the extra work needed to a) maintain the beast 
> submodule alongside boost's, and b) work around any hypothetical api 
> breakage in asio. Once 1.66 is out, we'll have a better idea how much 
> work that actually requires, but I wanted to float the idea ahead of 
> time.
>
> Casey

Boost 1.66 was released yesterday! The boost::beast changes were minimal 
(only one function name changed), but the changes to boost::asio were 
extensive and necessitated major changes to my PR for librados bindings 
at https://github.com/ceph/ceph/pull/19054. So I'm still proposing that 
we pin our boost dependency at 1.66 to avoid #ifdefs and build hackery 
to continue supporting earlier versions. That PR includes the cmake 
changes to do this, though I'm happy to pull those into a separate PR if 
necessary.

Casey
