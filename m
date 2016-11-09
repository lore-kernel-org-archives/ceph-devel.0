From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: master branch merges must pass unit tests
Date: Wed, 9 Nov 2016 14:32:57 +0300
Message-ID: <61b91df6-3c19-65da-05c5-6f9cfb5cdbae@mirantis.com>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
 <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36365 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933552AbcKILdB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 06:33:01 -0500
Received: by mail-lf0-f42.google.com with SMTP id t196so162380968lff.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2016 03:33:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Sage,

looks like you made even stronger restrictions.

I'm unable to merge https://github.com/ceph/ceph/pull/11823 after 
approving the changes.

Thanks,
Igor

On 11/9/2016 2:34 AM, Sage Weil wrote:
> On Tue, 8 Nov 2016, Sage Weil wrote:
>> I enabled the github check that the unit tests pass in order to merge to
>> master.  These tests still aren't completely reliable, but they're close,
>> and we'll make better progress if we start enforcing it now.
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
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

