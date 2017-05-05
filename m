From: Loic Dachary <loic@dachary.org>
Subject: Re: revisiting uneven CRUSH distributions
Date: Fri, 5 May 2017 16:49:03 +0200
Message-ID: <32dc2dd1-2259-f982-d356-dd27f003f3b1@dachary.org>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38422 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdEEOtI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 May 2017 10:49:08 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by relay7-d.mail.gandi.net (Postfix) with ESMTPS id 37CD03806
        for <ceph-devel@vger.kernel.org>; Fri,  5 May 2017 16:49:06 +0200 (CEST)
Received: from mfilter44-d.gandi.net (mfilter44-d.gandi.net [217.70.178.175])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 2106EA80BE
        for <ceph-devel@vger.kernel.org>; Fri,  5 May 2017 16:49:06 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter44-d.gandi.net (mfilter44-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 7n7qXBLeuLzz for <ceph-devel@vger.kernel.org>;
        Fri,  5 May 2017 16:49:04 +0200 (CEST)
Received: from [192.168.3.6] (x4e347038.dyn.telefonica.de [78.52.112.56])
        (Authenticated sender: loic@dachary.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EF6E3A80D7
        for <ceph-devel@vger.kernel.org>; Fri,  5 May 2017 16:49:03 +0200 (CEST)
In-Reply-To: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

The proposed algorithm fixes the probability bias when we have 7 rooms defined as the failure domain and one of them is bigger than the others (six with weight 10, one with weight 20), each hosting about 50,000 PGs. Before optimization we have:

             ~id~     ~weight~  ~objects~  ~over/under used %~
~name~                                                        
cloud6-1434    -7  1000.239929      39529             5.395913
cloud6-1463    -8  1000.239929      39466             5.227936
cloud6-1432    -5  1000.079895      39378             5.010104
cloud6-1430    -3  1000.079895      39232             4.620763
cloud6-1431    -4  1000.079895      39207             4.554095
cloud6-1433    -6  1000.079895      39112             4.300756
cloud6-1429    -2  2000.000000      64076           -14.556796

Worst case when a failure happens:

        ~over used %~
~type~               
device      10.120912
room         7.507467
root         0.000000

after optimization we have:

             ~id~  ~weight~  ~objects~  ~over/under used %~
~name~                                                     
cloud6-1463    -8   1000.24      37648                 0.38
cloud6-1434    -7   1000.24      37560                 0.15
cloud6-1430    -3   1000.08      37531                 0.08
cloud6-1429    -2   2000.00      75028                 0.05
cloud6-1432    -5   1000.08      37506                 0.02
cloud6-1433    -6   1000.08      37463                -0.10
cloud6-1431    -4   1000.08      37264                -0.63

Worst case when a failure happens:

        ~over used %~
~type~               
device           4.31
room             2.66
root             0.00

This is encouraging and I'll add more test cases including the crush maps I have. If anyone has an atypical crushmap to share, it would be great to add it to the list ;-)

Cheers

P.S. The corresponding code to run these tests is at http://libcrush.org/dachary/python-crush/commits/wip-fix-2

On 04/30/2017 04:15 PM, Loic Dachary wrote:
> Hi,
> 
> Ideally CRUSH distributes PGs evenly on OSDs so that they all fill in
> the same proportion. If an OSD is 75% full, it is expected that all
> other OSDs are also 75% full.
> 
> In reality the distribution is even only when more than 100,000 PGs
> are distributed in a pool of size 1 (i.e. no replication).
> 
> In small clusters there are a few thousands PGs and it is not enough
> to get an even distribution. Running the following with
> python-crush[1], shows a 15% difference when distributing 1,000 PGs on
> 6 devices. Only with 1,000,000 PGs does the difference drop under 1%.
> 
>   for PGs in 1000 10000 100000 1000000 ; do
>     crush analyze --replication-count 1 \
>                   --type device \
>                   --values-count $PGs \
>                   --rule data \
>                   --crushmap tests/sample-crushmap.json
>   done
> 
> In larger clusters, even though a greater number of PGs are
> distributed, there are at most a few dozens devices per host and the
> problem remains. On a machine with 24 OSDs each expected to handle a
> few hundred PGs, a total of a few thousands PGs are distributed which
> is not enough to get an even distribution.
> 
> There is a secondary reason for the distribution to be uneven, when
> there is more than one replica. The second replica must be on a
> different device than the first replica. This conditional probability
> is not taken into account by CRUSH and would create an uneven
> distribution if more than 10,000 PGs were distributed per OSD[2]. But
> a given OSD can only handle a few hundred PGs and this conditional
> probability bias is dominated by the uneven distribution caused by the
> low number of PGs.
> 
> The uneven CRUSH distributions are always caused by a low number of
> samples, even in large clusters. Since this noise (i.e. the difference
> between the desired distribution and the actual distribution) is
> random, it cannot be fixed by optimizations methods.  The
> Nedler-Mead[3] simplex converges to a local minimum that is far from
> the optimal minimum in many cases. Broyden–Fletcher–Goldfarb–Shanno[4]
> fails to find a gradient that would allow it to converge faster. And
> even if it did, the local minimum found would be as often wrong as
> with Nedler-Mead, only it would go faster. A least mean squares
> filter[5] is equally unable to suppress the noise created by the
> uneven distribution because no coefficients can model a random noise.
> 
> With that in mind, I implemented a simple optimization algorithm[6]
> which was first suggested by Thierry Delamare a few weeks ago. It goes
> like this:
> 
>     - Distribute the desired number of PGs[7]
>     - Subtract 1% of the weight of the OSD that is the most over used
>     - Add the subtracted weight to the OSD that is the most under used
>     - Repeat until the Kullback–Leibler divergence[8] is small enough
> 
> Quoting Adam Kupczyk, this works because:
> 
>   "...CRUSH is not random proces at all, it behaves in numerically
>    stable way.  Specifically, if we increase weight on one node, we
>    will get more PGs on this node and less on every other node:
>    CRUSH([10.1, 10, 10, 5, 5]) -> [146(+3), 152, 156(-2), 70(-1), 76]"
> 
> A nice side effect of this optimization algorithm is that it does not
> change the weight of the bucket containing the items being
> optimized. It is local to a bucket with no influence on the other
> parts of the crushmap (modulo the conditional probability bias).
> 
> In all tests the situation improves at least by an order of
> magnitude. For instance when there is a 30% difference between two
> OSDs, it is down to less than 3% after optimization.
> 
> The tests for the optimization method can be run with
> 
>    git clone -b wip-fix-2 http://libcrush.org/dachary/python-crush.git
>    tox -e py27 -- -s -vv -k test_fix tests/test_analyze.py
> 
> If anyone think of a reason why this algorithm won't work in some
> cases, please speak up :-)
> 
> Cheers
> 
> [1] python-crush http://crush.readthedocs.io/
> [2] crush multipick anomaly http://marc.info/?l=ceph-devel&m=148539995928656&w=2
> [3] Nedler-Mead https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead_method
> [4] L-BFGS-B https://docs.scipy.org/doc/scipy-0.18.1/reference/optimize.minimize-lbfgsb.html#optimize-minimize-lbfgsb
> [5] Least mean squares filter https://en.wikipedia.org/wiki/Least_mean_squares_filter
> [6] http://libcrush.org/dachary/python-crush/blob/c6af9bbcbef7123af84ee4d75d63dd1b967213a2/tests/test_analyze.py#L39
> [7] Predicting Ceph PG placement http://dachary.org/?p=4020
> [8] Kullback–Leibler divergence https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
