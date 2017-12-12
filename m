From: Luis Henriques <lhenriques@suse.com>
Subject: Re: cephfs quotas
Date: Tue, 12 Dec 2017 09:13:17 +0000
Message-ID: <87shcgqpg2.fsf@suse.com>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
        <87d13lryvd.fsf@suse.com>
        <F5418457-9D67-4687-BE66-AF70650C9811@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdLLJNT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 Dec 2017 04:13:19 -0500
In-Reply-To: <F5418457-9D67-4687-BE66-AF70650C9811@redhat.com> (Zheng Yan's
        message of "Tue, 12 Dec 2017 10:27:36 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Jan Fajerski <jfajerski@suse.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, ceph-devel@vger.kernel.org

"Yan, Zheng" <zyan@redhat.com> writes:

>> On 12 Dec 2017, at 00:52, Luis Henriques <lhenriques@suse.com> wrote:
>> 
>> Hi,
>> 
>> [ and sorry for hijacking this old thread! ]
>> 
>> Here's a write-up of what I was saying earlier on the cephfs standup:
>> 
>> Basically, by using the ceph branch wip-cephfs-quota-realm branch[1] the
>> kernel client should have everything needed to implement client-side
>> enforced quotas (just like the current fuse client).  That branch
>> contains code that will create a new realm whenever a client sets a
>> quota xattr, and the clients will be updated with this new realm.
>> 
>> My first question would be: is there something on the kernel client to
>> handle this realms (a snaprealm) that is still missing?  As far as I
>> could understand from reading the code there's nothing missing -- it
>> should be possible to walk through the realms hierarchy as the kernel
>> client will always get the updated realms hierarchy from the MDS -- both
>> for snapshots and for this new 'quota realms'.  Implementing a 'quota
>> realms' PoC based on the RFC I sent out a few weeks ago shouldn't take
>> too long.  Or is there something obvious that I'm missing?
>> 
>
> For maintaining realm hierarchy on kclient, nothing is missing.

Awesome, that was my understanding as well.  Thanks a lot for
confirming!

Cheers,
-- 
Luis
