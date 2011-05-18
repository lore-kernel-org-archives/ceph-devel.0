From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 2/2] libceph: fix handle_timeout() racing with
 con_work()/try_write()
Date: Wed, 18 May 2011 14:27:59 -0600
Message-ID: <4DD42BCF.8070909@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
 <1305235954-9860-2-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1105161033150.12367@cobra.newdream.net>
 <4DD2F773.30508@sandia.gov>
 <Pine.LNX.4.64.1105171613120.30781@cobra.newdream.net>
 <Pine.LNX.4.64.1105171637300.30781@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:34249 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab1ERU2c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 16:28:32 -0400
In-Reply-To: <Pine.LNX.4.64.1105171637300.30781@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage Weil wrote:

> 
> I pushed a patch to the msgr_race branch that catches all four cases (I 
> think).  Does the fix make sense given what you saw?

Sorry, I haven't completed much testing; it took me a while
to figure out the fix needs this:

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9c0a9bd..b140dd3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2013,6 +2013,7 @@ done:
  	mutex_unlock(&con->mutex);
  done_unlocked:
  	con->ops->put(con);
+	return;

  fault:
  	mutex_unlock(&con->mutex);


Still testing....

Thanks -- Jim

> 
> Thanks!
> sage
> 

