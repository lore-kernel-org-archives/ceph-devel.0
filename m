From: Casey Bodley <cbodley@redhat.com>
Subject: coming in boost 1.66
Date: Mon, 27 Nov 2017 11:03:45 -0500
Message-ID: <07a75940-72c6-8510-459b-4f4a0ad43d4b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:37783 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbdK0QDs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Nov 2017 11:03:48 -0500
Received: by mail-qt0-f177.google.com with SMTP id d15so39667680qte.4
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 08:03:48 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id q26sm20181777qkl.77.2017.11.27.08.03.46
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 08:03:46 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

There are a couple of interesting changes in the upcoming boost 1.66 
release, based on the work-in-progress release notes: 
http://www.boost.org/users/history/in_progress.html

- the Beast library was accepted into boost earlier this year, and 1.66 
will be its first release. We're currently including it in a submodule, 
so we'll need to come up with a strategy to transition.
- the Asio library is getting "interface changes to reflect the 
Networking TS" (which is awesome!) but we might see some compilation 
failures in radosgw as a result.

Now that we have the tooling to build specific boost versions, how do 
people feel about forcing the update to 1.66 once we've got it tested? 
This could avoid the extra work needed to a) maintain the beast 
submodule alongside boost's, and b) work around any hypothetical api 
breakage in asio. Once 1.66 is out, we'll have a better idea how much 
work that actually requires, but I wanted to float the idea ahead of time.

Casey
