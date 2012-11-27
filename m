From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: chooseleaf_descend_once
Date: Tue, 27 Nov 2012 11:28:50 -0700
Message-ID: <50B50662.2040002@sandia.gov>
References: <50B4255B.10509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:44872 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab2K0S3M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 13:29:12 -0500
In-Reply-To: <50B4255B.10509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: caleb miles <caleb.miles@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Caleb,

On 11/26/2012 07:28 PM, caleb miles wrote:
> Hello all,
>
> Here's what I've done to try and validate the new chooseleaf_descend_once tunable first described in commit f1a53c5e80a48557e63db9c52b83f39391bc69b8 in the wip-crush branch of ceph.git.
>
> First I set the new tunable to it's legacy value, disabled,
>
> tunable choose_local_tries 0
> tunable choose_local_fallback_tries 0
> tunable choose_total_tries 50
> tunable chooseleaf_descend_once 0
>
> The map contains one thousand osd devices contained in one hundred hosts with the following data rule
>
> rule data {
> ruleset 0
> type replicated
> min_size 1
> max_size 10
> step take default
> step chooseleaf firstn 0 type host
> step emit
> }
>
> I then simulate the creation of one million placement groups using the crushtool
>
> $ crushtool -i hundred.map --test --min-x 0 --max-x 999999 --num-rep 3 --output-csv --weight 120 0.0 --weight 121 0.0 --weight 122 0.0 --weight 123 0.0 --weight 124 0.0 --weight 125 0.0 --weight 125 0.0 --weight 150 0.0 --weight 151 0.0 --weight 152 0.0 --weight 153 0.0 --weight 154 0.0 --weight 155 0.0 --weight 156 0.0 --weight 180 0.0 --weight 181 0.0 --weight 182 0.0 --weight 183 0.0 --weight 184 0.0 --weight 185 0.0 --weight 186 0.0
>
> with the majority of devices in three hosts marked out. Then in (I)Python
>
> import scipy.stats as s
> import matplotlib.mlab as m
>
> data = m.csv2rec("data-device_utilization.csv")
> s.chisquare(data['number_of_objects_stored'], data['number_of_objects_expected'])
>
> which will output
>
> (122939.76474477499, 0.0)
>
> so that the chi squared value is 122939.795 and the p value is, rounded to, 0.0 and the observed placement distribution statistically differs from a uniform distribution. Repeating with the new tunable set to
>
> tunable chooseleaf_descend_once 1
>
> I obtain the following result
>
> (998.97643161876761, 0.32151775131589833)
>
> so that the chi squared value is 998.976 and the p value is 0.32 and the observed placement distribution is statistically identical to the uniform distribution at the five and ten percent confidence levels, higher as well of course. The p value is the probability of obtaining a chi squared value more extreme than the statistic observed. Basically, from my rudimentary understanding of probability theory, that if you obtain a p value p < P then reject the null hypothesis, in our case that the observed placement distribution is drawn from the uniform distribution, at the P confidence level.
>

Cool.  Thanks for doing these tests.

Is there any point to doing a third test, with

tunable chooseleaf_descend_once 0

and no devices marked out, but in all other respects
the same as the above two tests?

I would expect the results for that case and the last
case you tested to be essentially identical in the degree
of uniformity, but is it worth verifying?

-- Jim

> Caleb
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


