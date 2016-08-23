From: Loic Dachary <loic@dachary.org>
Subject: Re: should we remove autotools from master?
Date: Tue, 23 Aug 2016 16:19:38 +0200
Message-ID: <57BC5B7A.8050103@dachary.org>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60309 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757136AbcHWOVE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 10:21:04 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 5C70247B555
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 16:20:44 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Brad Hubbard <bhubbard@redhat.com>, Avner Ben Hanoch <avnerb@mellanox.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 23/08/2016 15:58, Sage Weil wrote:
> Should we remove the autotools stuff from master?
> 
> Yes:
> - It won't be maintained
> - It sucks
> - It confuses people and they use it by mistake
> - We'll find any build scripts etc that haven't been converted sooner 
> rather than later
> 
> No:
> - Other architectures might rely on it
> - It's possible some build scripts haven't been convert yet
> 
> I'm thinking yes?

I vote yes. The build scripts I know about are either converted or broken because autotools no longer works :-)

Cheers

> sage
> 
> 
> On Tue, 23 Aug 2016, Nathan Cutler wrote:
> 
>>> That's a different make-deb(s).sh
>>
>> Allow me to qualify that statement. This thread seems to be about
>>
>> https://github.com/ceph/ceph/blob/master/make-debs.sh
>>
>> while the "make-deb.sh" I am working on is
>>
>> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages/make-deb.sh
>>
>> which is used with the teuthology-openstack backend. However, I see the two
>> scripts are similar.
>>
>> In general, although the autotools stuff is still there in master, it is not
>> maintained and should not be expected to work (or continue to work). All build
>> infrastructure targeting master should be converted to cmake.
>>
>> Nathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
