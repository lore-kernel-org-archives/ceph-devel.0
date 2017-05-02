From: Loic Dachary <loic@dachary.org>
Subject: Re: revisiting uneven CRUSH distributions
Date: Tue, 2 May 2017 18:16:17 +0200
Message-ID: <9e59a2e1-4aab-9c71-901c-379b537df517@dachary.org>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54532 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdEBQQW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 May 2017 12:16:22 -0400
Received: from mfilter39-d.gandi.net (mfilter39-d.gandi.net [217.70.178.170])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 8044DC5ABB
        for <ceph-devel@vger.kernel.org>; Tue,  2 May 2017 18:16:20 +0200 (CEST)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter39-d.gandi.net (mfilter39-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id QM_ImBNYsYCs for <ceph-devel@vger.kernel.org>;
        Tue,  2 May 2017 18:16:18 +0200 (CEST)
Received: from [192.168.3.6] (x55b4aabe.dyn.telefonica.de [85.180.170.190])
        (Authenticated sender: loic@dachary.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7CEDAC5AEB
        for <ceph-devel@vger.kernel.org>; Tue,  2 May 2017 18:16:18 +0200 (CEST)
In-Reply-To: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Greg raised the following problem today: what if, as a consequence of changing the weights, the failure of a host/rack (whatever the failure domain is) makes the cluster full ? For instance if you have racks 1, 2, 3 with "effective" weights .8, 1.1, 1 and you lose half of rack 3 then rack 2 is going to get a lot more of the data than rack 1 is.

In other words, getting an even distribution must not be done at the expense of the ability of the cluster to sustain the failure of at least one bucket in the failure domain. It is necessary to evaluate that before and after the optimization.

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
