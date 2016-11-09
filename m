From: Loic Dachary <loic@dachary.org>
Subject: Re: master branch merges must pass unit tests
Date: Wed, 9 Nov 2016 10:29:38 +0100
Message-ID: <5822EC82.6080306@dachary.org>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
 <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49173 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbcKIJ3m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 04:29:42 -0500
In-Reply-To: <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org



On 09/11/2016 00:34, Sage Weil wrote:
> On Tue, 8 Nov 2016, Sage Weil wrote:
>> I enabled the github check that the unit tests pass in order to merge to 
>> master.  These tests still aren't completely reliable, but they're close, 
>> and we'll make better progress if we start enforcing it now.
> 
> I went a bit further and also checked the box requiring a review and 
> preventing pushes directly to master branch.  These are already uneforced 
> requirements so this shouldn't slow people down *except* that we need to 
> start using the new github 'review' feature that lets you explicitly 
> approve changes.
> 
> Again, the core developers can override these restrictions if necessary.
> 
> I haven't done anything to the stable branches, but we might want to do 
> the same thing there...

Good move :-) I will do the same for the stable branches.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
