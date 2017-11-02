From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Additional backport labels and process improvements
Date: Thu, 2 Nov 2017 22:44:12 +0100
Message-ID: <33616246-099d-0bbc-f071-703733463e79@suse.cz>
References: <CAKPXa=Z3aXdwRz9OAniOLEpWkLtGUJHyLCTvm2y+n9u8PKXy7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53981 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934115AbdKBVoN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Nov 2017 17:44:13 -0400
In-Reply-To: <CAKPXa=Z3aXdwRz9OAniOLEpWkLtGUJHyLCTvm2y+n9u8PKXy7g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasu Kulkarni <vakulkar@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Vasu:

As I understand it, the "needs-backport" label is there to enable 
fast-tracking of luminous backports in the early phases of the 
release/maintenance cycle, not to replace the existing 
(tracker.ceph.com-based) backport tracking.

Having separate tracker issues for backports is essential to enable 
searching for backports in Redmine. For example, if you go to 
http://tracker.ceph.com/projects/ceph/issues and look over on the right 
you'll see the following links (among others):

CUSTOM QUERIES

     Backports: jewel
     Backports: jewel (pending)
     Backports: luminous
     Backports: luminous (pending)
     Backports: missing release

These are just some of the more common searches - plenty more are possible.

Further comments in-line, below.

On 11/02/2017 05:16 PM, Vasu Kulkarni wrote:
> When adding a important code or test fix to the master branch we have
> 'needs-backport' label,   can we add more labels that indicate what
> branch it needs to be backported as well eg "needs-jewel-backport" ,
> "needs-luminous-backport"

If anything, I would like to drop the "needs-backport" label after 
12.2.2 (and perhaps reinstate it when 13.2.0 is released).

> I have personally missed couple of test backports back to branches and
> added labels would help query results right from the github interface
> and make it easier for anyone to check if there are important
> backports missing.
 >
> Also I am +1 on NOT creating a new tracker for every backport, this
> seems redundant work, the original tracker can still be used with few
> additional fields to indicate "fixed in master", "fixed in jewel" etc.

That pretty much describes the previous backporting system, which IIRC 
did not work properly - many issues did not get backported because there 
was no way to separately track backports or query them.

Rather than creating additional work, the whole system is geared toward 
_reducing_ work for developers. Ideally, developer work is reduced to:

1. flagging bugfixes for backporting, by filling out the "Backport" field
2. change the bug status to "Pending Backport" when the master PR is merged.

That's all. The backporting team takes care of the rest, unless we find 
the backport is not easy to cherry-pick and we need to ask for your 
help. In any case, developers should definitely not need to create the 
backport tracker issues. That is automated (by ceph-workbench) and 
members of the backporting team run the script semi-regularly (ping us 
if you need it done sooner rather than later). Maybe we should look into 
running the script via cronjob. . .

HTH,
Nathan
