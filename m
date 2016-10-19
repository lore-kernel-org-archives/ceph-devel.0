From: Loic Dachary <loic@dachary.org>
Subject: Re: Upcoming 10.2.4
Date: Wed, 19 Oct 2016 11:52:06 +0200
Message-ID: <58074246.7030904@dachary.org>
References: <57FB7494.1010309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:57045 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941078AbcJSOTK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2016 10:19:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id A8F2847EDEE
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2016 11:52:42 +0200 (CEST)
In-Reply-To: <57FB7494.1010309@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Abhishek,

Unless I missed something, all backports that matter are now in the last round of testing[1]. If we're lucky all backports in the testing branch (jewel-backports) will be merged. Even if it's not the case I'll make sure at least all the urgent ones[2] are.

If the test infrastructure permits, I should be able to propose you to cut 10.2.4 early next week.

Cheers

[1] http://tracker.ceph.com/issues/17487#note-16
[2] http://tracker.ceph.com/projects/ceph/issues?query_id=96

On 10/10/2016 12:59, Loic Dachary wrote:
> Hi Abhishek,
> 
> Since you're now release manager, it is my understanding that we'll be asking you if the release should be cut or not. I updated the issue tracking the progress of 10.2.4 accordingly. This is a heads up to let you know we'll most likely ask that question for 10.2.4 some time next week ;-)
> 
> Cheers
> 
> [1] http://tracker.ceph.com/journals/diff/79457?detail_id=76318 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
