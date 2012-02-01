From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 0/6] Understanding delays due to throttling under
 very heavy write load
Date: Wed,  1 Feb 2012 08:54:22 -0700
Message-ID: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:38998 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab2BAQMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 11:12:35 -0500
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 177A517A6AA
	for <ceph-devel@vger.kernel.org>; Wed,  1 Feb 2012 08:55:15 -0700 (MST)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 1 Feb 2012 08:54:57 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Hi,

FWIW, I've been trying to understand op delays under very heavy write
load, and have been working a little with the policy throttler in hopes of
using throttling delays to help track down which ops were backing up.
Without much success, unfortunately.

When I saw the wip-osd-op-tracking branch, I wondered if any of this
stuff might be helpful.  Here it is, just in case.

-- Jim

Jim Schutt (6):
  msgr: print message sequence number and tid when receiving message
    envelope
  common/Throttle: track sleep/wake sequences in Throttle, report them
    for policy throttler
  common/Throttle: throttle in FIFO order
  common/Throttle: FIFO throttler doesn't need to signal waiters when
    max changes
  common/Throttle: make get() report number of waiters on entry/exit
  msg: log Message interactions with throttler

 src/common/Throttle.h      |   75 +++++++++++++++++++++++++++++++-------------
 src/msg/Message.h          |   71 +++++++++++++++++++++++++++++++++++------
 src/msg/SimpleMessenger.cc |   22 +++++++++---
 3 files changed, 129 insertions(+), 39 deletions(-)


