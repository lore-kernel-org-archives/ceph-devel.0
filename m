From: Abhishek Lekshmanan <alekshmanan@suse.de>
Subject: Re: needs-backport label on github/ceph/ceph
Date: Wed, 23 Aug 2017 18:29:19 +0200
Message-ID: <87fuciqmcg.fsf@suse.com>
References: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com> <CALe9h7cvEeD27eyL8rMTsbfwzXvX20RebMSDkBm+=F0kKzVBMA@mail.gmail.com> <7f97669a-f05d-328b-a854-25f749742ccb@suse.cz> <CAJE9aOM=312hvBs9LjZXSBj9YgwaYbZ3F+RWoQTbFrpTGTm97Q@mail.gmail.com> <87mv6qqt4h.fsf@suse.com> <9abaad60-9318-8362-209d-2b92c49c438f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41291 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbdHWQ3V (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 23 Aug 2017 12:29:21 -0400
In-Reply-To: <9abaad60-9318-8362-209d-2b92c49c438f@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, kefu chai <tchaikov@gmail.com>
Cc: John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Nathan Cutler <ncutler@suse.cz> writes:

>> Can we ensure that we always have a tracker issue when there is a
>> pending backport label, makes it easier to track these.
>
> I thought the whole idea was to make a "fast-track" backporting process 
> which would not require a tracker for each backport. With the 
> understanding that it would only be used early in the release cycle. If 
> a backport is "fast-tracked" the merging developer would be responsible 
> for doing and merging the cherry-picks.
>
> If there is a tracker, of course, then the normal workflow would apply 
> regardless of the presence/absence of this "needs-backport" tag.

Sure makes sense, sorry, didn't see Sage's mail (until after I sent
mine), yeah it does make sense for until the first backport release or
so for using this tag.

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
