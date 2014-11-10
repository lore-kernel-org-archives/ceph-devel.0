From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Pull requests : speed up the reviews
Date: Mon, 10 Nov 2014 11:07:56 -0800
Message-ID: <CAC6JEv_xbv54VoFfU+6rOKS7ytR7TbzJM3NZSk_sVKjpDEyQFA@mail.gmail.com>
References: <545E53B5.3070600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46018 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbaKJTH6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 14:07:58 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so9479217ieb.8
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 11:07:57 -0800 (PST)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id w7sm5150250igl.7.2014.11.10.11.07.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 11:07:56 -0800 (PST)
Received: by mail-ig0-f174.google.com with SMTP id hn18so17153614igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 11:07:56 -0800 (PST)
In-Reply-To: <545E53B5.3070600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Nov 8, 2014 at 9:32 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> In the past few weeks the number of pending pull requests grew from around 20 to over 80. The good thing is that there are more contributions, the problem is that it requires more reviewers. Ceph is not the only project suffering from this kind of problem and attending the OpenStack summit last week reminded me that the sooner it is addressed the better.
>
> After a few IRC discussions some ideas came up and my favorite is that every developer paid full time to work on Ceph dedicates a daily 15 minutes time slot, time boxed, to review pull requests. Timeboxing is kind of frustrating because some reviews require more. It basically means one has to focus on the pull request for ten minutes at most and take five minutes to write a useful comment that helps the author moving forward. But it also is the only way to make room for a daily activity with no risk of postponing it because something more urgent came up.
>
> What do you think ?

This is something I've already been thinking about a bit for different
reasons. Historically we've had a very informal and organic approach
to review management.
When reviews first started, each developer went and sought out
somebody they felt was appropriate to review the code change. As the
team grew and we started to get more external contributions, this
basically meant that every review funneled through the tech leads:
leads selected reviewers for self-written code and then for every
other PR either reviewed it or explicitly passed it off to a competent
reviewer. Code which didn't fit into a clear lead category were
handled by Sage or occasionally somebody else (*self-aggrandizing
cough*). This used to work, but we're seeing its limitations as we
grow.
At the moment it's a particular concern because Sage and Sam have been
focused on the Giant release, I've been slowly but ruthlessly pruning
off activities like community review in the service of cephfs fsck
(and John and Zheng's productivity!), and we're getting a *lot* more
PRs of substance than we used to.

So we need a new system (or to be more proactive about our existing
informal system) for managing reviews. I think there are a few things
that a review process needs to address:
1) New PRs need to get an appropriate amount of commentary quickly.
2) PRs need to be reviewed by a competent developer prior to merge.
3) Reviewing needs to scale.

An "appropriate amount of commentary" obviously depends on the nature
of the review: we want to be more proactive with new contributors;
small but important patches should be handled more quickly than
long-term major features; a patch which isn't reviewable for style
reasons doesn't need the line-by-line attention of something that we
would like to merge ASAP.
The identity of a "competent developer" varies a lot across different
parts of the project, but I think this might be the key issue: there
are a lot of things where the pool of already-qualified people is only
one or two deep.

I suppose one way of handling this might be to ask everybody to
dedicate a small amount of time to reviews (as you suggest), but to
emphasize PR management as much as doing the actual review.
1) If you don't have assigned PRs, look at the unassigned PRs from
oldest to newest, and based on the target area assign it to the person
you think most appropriate.after doing basic due diligence for issues
that you can handle (ie, the feature is something you don't know is
inappropriate; skimming the code doesn't make you cry; etc)
2) Manage any reviews assigned to you:
  2a) if you're the wrong target, assign it to somebody more appropriate
  2b) If you're the right target but are trying to get somebody else
acquainted with the code base, maybe assign it to them
  2c) assign priorities based on importance and age
3) review PRs in appropriate order at the level they deserve, and then
either merge or assign it back to the author

In particular, this clearly assigns responsibility for a PR to an
individual. It lets people offload as necessary, and gives feedback to
contributors quickly even if that feedback is just "we appreciate your
submission and it is in somebody's queue". It lets people contribute
to the PR process even if there isn't something they feel qualified to
review directly. And it doesn't emphasize the time spent reviewing so
much as the act of moving a PR through the stages of merging. (A
15-minute timebox might sound great, but trust me we have lots of PRs
that would never make it into the code base if they were done in
15-minute chunks.)

Obviously this is also not a very formal process, but I think maybe if
we start approaching things this way it will help move stuff through
the pipeline faster. Based on Sage's sudden enthusiasm for assigning
PR owners I think he might agree...?
-Greg
