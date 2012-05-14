From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/2] Distribute re-replicated
 objects evenly after OSD failure
Date: Mon, 14 May 2012 08:52:01 -0600
Message-ID: <4FB11C11.8020504@sandia.gov>
References: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1205121646040.21796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:48378 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab2ENOy7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 10:54:59 -0400
In-Reply-To: <Pine.LNX.4.64.1205121646040.21796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@dreamhost.com, ceph-devel@vger.kernel.org

On 05/12/2012 05:51 PM, Sage Weil wrote:
> Hey Jim,
>
> These both look like reasonable changes.  And it's great to see they fix
> behavior for you.
>
> I'm not going to merge them yet, though.  We're just kicking off a CRUSH
> refresh project next week that will include some testing framework to more
> thoroughly validate the quality of the output, and also take a more
> holistic look at all what the algorithm is doing and see what we can
> improve.

I really didn't expect you'd merge them right away -- I knew you had
this CRUSH effort coming, so my goal was to get these to you so you
could evaluate them as part of that push.

> Most likely these changes will be included, but revving the
> mapping algorithm is going to be tricky for forward/backward
> compatibility, and we'd like to get it all in at once.  (And/or come up
> with a better way to deal with mismatched versions...)

Yep, I completely ignored the version compatibility issue -
I didn't have any clever ideas on how to handle it.

Also, FWIW I'm running with the patch below on top of the
previous two - I think it helps avoid giving up too early
in clusters where many OSDs have gone down/out, but I haven't
done enough testing on it yet to quantify.

>
> Thanks!

Hey, thanks for taking at look!

> sage


-- Jim

---
ceph: retry CRUSH map descents from root a little longer before falling back to exhaustive search

The exhaustive search isn't as exhaustive as we'd like if the
CRUSH map is several levels deep, so try a few more times
to find an "in" device during "spread re-replication around"
mode.  This makes it less likely we'll give up when the
storage cluster has many failed devices.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
  src/crush/mapper.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/crush/mapper.c b/src/crush/mapper.c
index 698da55..39e9c5d 100644
--- a/src/crush/mapper.c
+++ b/src/crush/mapper.c
@@ -306,7 +306,7 @@ static int crush_choose(const struct crush_map *map,
  	int item = 0;
  	int itemtype;
  	int collide, reject;
-	const unsigned int orig_tries = 5; /* attempts before we fall back to search */
+	const unsigned int orig_tries = 10; /* attempts before we fall back to search */

  	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d\n", recurse_to_leaf ? "_LEAF" : "",
  		bucket->id, x, outpos, numrep);
@@ -440,7 +440,7 @@ reject:
  					else if (flocal <= in->size + orig_tries)
  						/* exhaustive bucket search */
  						retry_bucket = 1;
-					else if (ftotal < 20)
+					else if (ftotal <= orig_tries + 15)
  						/* then retry descent */
  						retry_descent = 1;
  					else
-- 
1.7.8.2


