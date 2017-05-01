From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: revisiting uneven CRUSH distributions
Date: Mon, 1 May 2017 19:15:36 +0200
Message-ID: <c2237c5e-165e-20be-1c9e-c239d8792c37@profihost.ag>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:42410 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750822AbdEARVE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 May 2017 13:21:04 -0400
In-Reply-To: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

That sounds amazing! Is there any chance this will be backported to jewel?

Greets,
Stefan

Am 30.04.2017 um 16:15 schrieb Loic Dachary:
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
