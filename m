From: "Jim Schutt" <jaschut@sandia.gov>
Subject: lost bugfix in sync_requester_abort?
Date: Thu, 20 Jun 2013 09:13:56 -0600
Message-ID: <51C31C34.5080108@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:60973 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965153Ab3FTPOS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 11:14:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

A week or so ago you had a patch in your wip-mon branch
(now gone) called "mon: fix raw use of *_dout in sync_requester_abort()".
It seems that patch got dropped.

AFAICS, without that patch, sync_requester_abort() has different
behavior depending on the value of "debug mon".  In particular,
I believe the sync leader/provider won't get reset if debug mon
is less than 10.

Am I missing something, or was dropping that change unintended?

Thanks -- Jim

