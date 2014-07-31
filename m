From: Daniel Hofmann <daniel@trvx.org>
Subject: Re: Forcing Ceph into mapping all objects to a single PG
Date: Thu, 31 Jul 2014 02:29:22 +0200
Message-ID: <53D98DE2.7080802@trvx.org>
References: <53CD93B4.6020500@trvx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trvx.org ([46.38.250.125]:44375 "EHLO mail.trvx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbaGaA3f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jul 2014 20:29:35 -0400
Received: from [192.168.1.115] (HSI-KBW-046-005-197-128.hsi8.kabel-badenwuerttemberg.de [46.5.197.128])
	by mail.trvx.org (Postfix) with ESMTPSA id 22EE41A254CB
	for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 02:29:33 +0200 (CEST)
In-Reply-To: <53CD93B4.6020500@trvx.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Follow up: I wrote a small Python script for evaluating the object to
placement mapping's quality. I'm using a Chi-Squared statistical
hypothesis test.

Here is the script and also an example output for a few rados benchmark
writes:

> https://gist.github.com/daniel-j-h/d7d87dfe5de3c5bbfd0f

Maybe you're interested in checking your cluster's mapping quality.

More on the method and the output's meaning:
> https://en.wikipedia.org/wiki/Chi-squared_test
> http://en.wikipedia.org/wiki/P-value

I'm still interested in a cluster-specific mapping as discussed in the
other mailinglist posts.

Cheers,
Daniel
