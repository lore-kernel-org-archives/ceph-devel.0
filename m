From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Redmine problem
Date: Wed, 8 Nov 2017 23:50:36 +0100
Message-ID: <40f46081-c90b-cadc-771a-28f305923581@suse.cz>
References: <7f49bc39-c717-273e-c2d2-adade2df172e@suse.cz>
 <e83efaf2-e811-df08-ccf5-84ec516e7131@redhat.com>
 <8e167ff1-f62a-6ce1-6674-16d98284a866@suse.cz>
 <d67aad8c-5c9a-d967-edc4-b56ec40185f3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60019 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbdKHWui (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Nov 2017 17:50:38 -0500
In-Reply-To: <d67aad8c-5c9a-d967-edc4-b56ec40185f3@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Galloway <dgallowa@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <loic@dachary.org>

> Can you share the script without the API key and maybe some timestamps
> so I can check out the logs?

The Redmine bits of the script are in this file: 
http://ceph-workbench.dachary.org/root/ceph-workbench/blob/master/ceph_workbench/wbredmine.py

I first started seeing this at around 11:40 a.m. CET (10:40 UTC) and it 
was happening all afternoon - the script would run for some time and 
then fail with the same error, but not at the same spot. Sometimes it 
would process 10 or 20 pending backport issues, other times it would get 
through more.

I just ran it again and it completed twice in a row without error, so I 
guess it was a transient issue. Timestamp after completing the second run:

$ date --utc
Wed Nov  8 22:48:34 UTC 2017

Thanks for looking into it.

Nathan
