From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Building and Testing
Date: Tue, 22 Dec 2015 00:40:35 +0100
Message-ID: <56788DF3.3090205@digiware.nl>
References: <5676D2D9.5010600@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57324 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbbLUXtm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Dec 2015 18:49:42 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 09F27153430
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 00:49:40 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:d90b:d712:e383:d07f] (unknown [IPv6:2001:4cb8:3:1:d90b:d712:e383:d07f])
	by smtp.digiware.nl (Postfix) with ESMTP id 949D715340A
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 00:40:50 +0100 (CET)
In-Reply-To: <5676D2D9.5010600@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 20-12-2015 17:10, Willem Jan Withagen wrote:
> Hi,
>
> Most of the Ceph is getting there in the most crude and rough state.
> So beneath is a status update on what is not working for me jet.

> Further:
> A) unittest_erasure_code_plugin failes on the fact that there is a
> different error code returned when dlopen-ing a non existent library.
> load dlopen(.libs/libec_invalid.so): Cannot open
> ".libs/libec_invalid.so"load dlsym(.libs/libec_missing_version.so, _
> _erasure_code_init): Undefined symbol
> "__erasure_code_init"test/erasure-code/TestErasureCodePlugin.cc:88: Failure
> Value of: instance.factory("missing_version", g_conf->erasure_code_dir,
> profile, &erasure_code, &cerr)
>    Actual: -2
> Expected: -18

EXDEV is actually 18, so that part is correct.
But EXDEV is cross-device link error.

Where as the actual answer: -2 is factual correct:
#define ENOENT          2               /* No such file or directory */

So why is the test for EXDEV instead of ENOENT?
Could be a typical Linux <> FreeBSD thingy.

--WjW
