From: Marcel Lauhoff <lauhoff@uni-mainz.de>
Subject: Re: An Evaluation of Object Name Hashing
Date: Tue, 26 Jan 2016 19:40:41 +0100
Message-ID: <87r3h4gp5i.fsf@uni-mainz.de>
References: <87a8obhr88.fsf@uni-mainz.de> <alpine.DEB.2.11.1601120831470.27580@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate-01.zdv.uni-mainz.de ([134.93.178.241]:41006 "EHLO
	mailgate-01.zdv.uni-mainz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903AbcAZSkt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Jan 2016 13:40:49 -0500
In-Reply-To: <alpine.DEB.2.11.1601120831470.27580@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


Hi!

Sage Weil <sage@newdream.net> writes:
> On Tue, 12 Jan 2016, Marcel Lauhoff wrote:
>>
>> I wrote an article on my website with the analysis, changes to the
>> source and how I ran the tests:
>>
>>   http://irq0.org/articles/ceph/object_name_hashing
>
> The interesting thing to me is the error bars for linux prefix (the
> right-most set of bars on the last graph).  They range is significantly
> wider than rjenkins + prefix (ranging from 2.1TiB to 4.0TiB (vs 2.3-3.7ish
> for the others).  The reason we switched away from the linux dcache hash
> (it was the original choice) is because it is very weak.  I suspect that
> even if you look at the average + standard deviation it hides some of the
> badness; looking at 99th or 99.9th percentile, or simply a plot of the osd
> utilization distribution, will show that there are more low- and high-
> utilization outliers.

I rerun the tests and included Adler-32, CRC32, MD5 and SHA-1 (MD5 and
SHA-1 truncated to 32 bit). I updated the article.

In summary: Adler-32 does not work. MD5 and SHA-1 are OK. CRC32 as good
as RJenkins, maybe even slightly better.

~marcel

--
Marcel Lauhoff
