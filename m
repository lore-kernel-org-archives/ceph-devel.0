From: Sage Weil <sage@newdream.net>
Subject: some lightweight process
Date: Thu, 12 Jan 2012 13:03:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201121139170.13761@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36668 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab2ALVDa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 16:03:30 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5341EBC60D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 13:03:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 29A15BC60D
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 13:03:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The team here in LA had a meeting yesterday about what we could do with 
our general development process to improve quality.  A number of things 
came out of that, most of it having to do with improving the testing/qa 
infrastructure and the general development process.  For the latter, the 
basic consensus was that any non-trivial change
 - should probably involve some design discussion,
 - should definitely involve some design review,
 - and there should be some code review before things hit the master branch.

My proposal for moving in that direction:

1- Non-trivial work should involve some initial ad hoc discussion, either 
   on list or in person.  This isn't strictly required, but the output 
   will generally be better if it is.

2- The design discussion should consider testability (in addition to 
   complexity, performance, etc.).  If subtle or complex functionality is 
   being added, there should be tests to thoroughly exercise it.

3- A summary of the design/change should go to the list for 
   review/discussion.  If it's simple enough that code is already ready, 
   skip to 5.  If not, we need to review the design and implementation and
   testing plans before significant work is invested.

4- Write code and tests.  Test.

5- Any new code should pass the unit tests and a teuthology smoke test (*)
   before being merged.  Ideally it should pass tests prior to final 
   review, but use your best judgement.

6- The code and summary should go to the list for review.  This can either 
   be a conventional patch series with a cover-letter, or an overview 
   accompanied by a link to a github branch.  In either case the 
   final design summary should be included in the email (or cover letter). 
   Review is then either inline (on list) or in the github comments.

7- Only after something is reviewed can it go to master.

* We're working on building an abbreviated 'smoke' suite that takes less 
time to run than the current 'regression' suite.

The key things we want out of this are:

 - testability always considered during design
 - design review, ideally by someone other than the (co-)designer.
 - greater transparency with the non-local and community people on what we 
   are working on, and why
 - testing as an integral part of the process

This is a bit of a shift for us (me especially :), so naturally it'll take 
some getting used to.  In particular, it's not clear what constitutes a 
sufficiently complex change that it requires review.  For now, let's use 
our best judgement.

The other piece of this is that, in order for this to work, people have to 
actually do the reviews promptly.  If you feel comfortable reviewing 
changes in a certain area, please do!

What do you think?

sage

