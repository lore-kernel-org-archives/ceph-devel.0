From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: needs-backport label on github/ceph/ceph
Date: Wed, 23 Aug 2017 17:59:27 +0200
Message-ID: <9abaad60-9318-8362-209d-2b92c49c438f@suse.cz>
References: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com>
 <CALe9h7cvEeD27eyL8rMTsbfwzXvX20RebMSDkBm+=F0kKzVBMA@mail.gmail.com>
 <7f97669a-f05d-328b-a854-25f749742ccb@suse.cz>
 <CAJE9aOM=312hvBs9LjZXSBj9YgwaYbZ3F+RWoQTbFrpTGTm97Q@mail.gmail.com>
 <87mv6qqt4h.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932100AbdHWP73 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Aug 2017 11:59:29 -0400
In-Reply-To: <87mv6qqt4h.fsf@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <alekshmanan@suse.de>, kefu chai <tchaikov@gmail.com>
Cc: John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Can we ensure that we always have a tracker issue when there is a
> pending backport label, makes it easier to track these.

I thought the whole idea was to make a "fast-track" backporting process 
which would not require a tracker for each backport. With the 
understanding that it would only be used early in the release cycle. If 
a backport is "fast-tracked" the merging developer would be responsible 
for doing and merging the cherry-picks.

If there is a tracker, of course, then the normal workflow would apply 
regardless of the presence/absence of this "needs-backport" tag.

Right?

Nathan
