From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk and 'make'
Date: Mon, 19 Sep 2016 07:54:40 +0200
Message-ID: <57DF7DA0.2050007@dachary.org>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57516 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757296AbcISFyp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 01:54:45 -0400
In-Reply-To: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 19/09/2016 02:40, Sage Weil wrote:
> I noticed that with the new cmake when I do a 'make' the ceph-disk target 
> isn't built.  And ctest will fail most of its unit tests.  It looks like 
> it is part of the 'tests' target, though.  Is it deliberate that a simple 
> 'make' doesn't build everything?

I think make should build it. I'll look into it.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
