From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Lots of misdirected client requests with 73984 PGs/pool
Date: Tue, 28 Aug 2012 16:01:11 -0600
Message-ID: <503D3FA7.2050603@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:33278 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab2H1WBj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 18:01:39 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1EE9AD2C869
	for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 16:01:36 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 16:01:25 -0600
Received: from mail.sandia.gov (exch01.sandia.gov [134.253.103.1] (may
 be forged)) by mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id
 q7SM1BQV015320 for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012
 16:01:11 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I was testing on 288 OSDs with pg_bits=8, for 73984 PGs/pool,
221952 total PGs.

Writing from CephFS clients generates lots of messages like this:

2012-08-28 14:53:33.772344 osd.235 [WRN] client.4533 172.17.135.45:0/1432642641 misdirected client.4533.1:124 pg 0.8b9d12d4 to osd.235 in e7, client e7 pg 0.112d4 features 262282

There's no trouble with 288 OSDs and pg_bits=7 (36992 PGs/pool).

This is all with current Linus master branch + ceph-client testing
branch, and master branch on the server side.

Does this have anything to do with old_pg_t AKA struct ceph_pg
only using 16 bits for the placement seed?

I'd about to start testing on 576 OSDs, and was hoping to use
pg_bits=7 to get more uniform data placement across OSDs.
My first step on that path was 288 OSDs with pg_bits=8.

Maybe I can't, or I have to just ignore the warnings, until
the kernel's libceph learns about 32-bit placement seeds?

Or maybe this 16-bit seed theory is all wrong, and something
else is going on?  If so, what more information is needed
to help sort this out?

Thanks -- Jim

