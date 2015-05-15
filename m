From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: master vs. next
Date: Fri, 15 May 2015 11:23:09 +0100
Message-ID: <5555C90D.9030402@suse.de>
References: <5555B1E9.3010003@suse.cz> <CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47472 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbbEOKXL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 May 2015 06:23:11 -0400
In-Reply-To: <CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/15/2015 10:48 AM, Ilya Dryomov wrote:
> On Fri, May 15, 2015 at 11:44 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> I'm a newcomer to the ceph project. SubmittingPatches says to target
>> next for bugfixes and master for features. Beyond that I only have the
>> vaguest notion of what the next branch is for and how patches get moved
>> back and forth between master and next. Can anyone comment?
> 
> next is development release branch (while firefly, hammer, etc are
> stable release branches).  Bugfix PRs are submitted against next, next
> is periodically merged into master.  In fact anybody can merge next
> into master at any time to get the fix merged into next in master.
> (Not the other way around - fixes are not supposed to go into master and
> then be cherry-picked into next.)  After the development release is
> cut, next is reset to master.
> 
> I'm sure others will correct me if I missed something.
> 

I think Ilya is right about this.

As I recall from the last time someone patiently explained this to me,
the workflow is as follows:

1. dev cycle begins
  - features go to master

2. dev cycle ends
  - next is branched off of master
  - next will be the next dev release to be released once it's ready
  - bugfixes go into 'next', 'next' is feature frozen
  - 'next' is frequently merged into master

There's an overlap between the current dev cycle and the last dev cycle.
 As we are testing the last dev cycle and preparing the release, work
for the current dev cycle targets master -- not next, unless it's for
bugs from the previous release.

Anyway, maybe I got something wrong here (hopefully not all of it!), but
I tend to simply target master when it's a feature and 'next' if it's an
old bug.

  -Joao

