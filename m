From: =?UTF-8?B?QsOhcmEgQW7EjWluY292w6E=?= <bara@redhat.com>
Subject: [Ceph Doc Conventions] ObjectStore, FileStore, BlueStore x Object
 Store, File Store, Blue Store
Date: Thu, 8 Dec 2016 12:12:59 +0100
Message-ID: <13e0f1cc-5b25-6b05-65fb-66b961eafe7c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbcLHLWe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Dec 2016 06:22:34 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A048C04B30E
        for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2016 11:13:02 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Federico Lucifredi <flucifre@redhat.com>, Neil Levine <nlevine@redhat.com>
Cc: ceph-docs <ceph-docs@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Ceph-release-team <ceph-release-team@redhat.com>

Dear all,

the Ceph documentation team is currently developing Ceph documentation 
conventions and we ran into the following question:

What is the preferred spelling of various stores?

I saw that the Ceph community mainly uses FileStore and BlueStore 
[1][2]. However, we have Object Store in our guidelines[3] and we'd 
prefer to use it that way. Based on this logic it should be File Store 
and Blue Store.

What spelling would you prefer? Is it ok to move from FileStore and 
BlueStore to File Store and Blue Store in the official downstream docs?

Please feel free to include anyone else who might be interested in this 
topic.

Cheers,

Bara

[1] 
http://www.sebastien-han.fr/blog/2013/12/02/ceph-performance-interesting-things-going-on/
[2] http://www.sebastien-han.fr/blog/2016/03/21/ceph-a-new-store-is-coming/
[3] 
https://gitlab.cee.redhat.com/ccs-internal-documentation/glossary-of-terms-and-conventions-for-product-documentation/merge_requests/28/diffs
(disclaimer - still WIP and many things are missing. Please free to 
comment if you have any feedback. We will definitely share the final 
version with you to get your ack. I personally believe that Ceph docs 
conventions is something that we really need to achieve consistency in 
our docs and to improve them.)

-- 
Bara Ancincova
Technical Writer
Customer Content Services
IRC nick: bara

Red Hat Czech, s.r.o.
Purkynova 99
612 45 Brno, Czech Republic
