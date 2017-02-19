From: Loic Dachary <loic@dachary.org>
Subject: Re: Matrix method for placing PGs on weighted item buckets
Date: Sun, 19 Feb 2017 19:36:25 +0100
Message-ID: <b4af7492-0f32-66cc-81a5-bd5c26eb7017@dachary.org>
References: <CABZ+qq=nB-Agw6Vc8wSrTiDTjcL8n2GWwpnqpbCJ4cX+BGtrvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50746 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBSSgd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Feb 2017 13:36:33 -0500
In-Reply-To: <CABZ+qq=nB-Agw6Vc8wSrTiDTjcL8n2GWwpnqpbCJ4cX+BGtrvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dan,

On 02/13/2017 09:38 PM, Dan van der Ster wrote:
> Hi,
> 
> At the risk of distracting from the other thread, I wanted to
> demonstrate a totally orthogonal solution to selecting replica sets
> across weighted item buckets. The idea comes from Alberto, in cc.

I find that very creative (but I'm easily impressed, because I'm not so good at maths ;-).

> This approach has the advantage that it generates exact solutions --
> but I don't know if it is too different from CRUSH to be usable, or if
> it meets the placement stability constraints we have in Ceph.

That would also be my concern since there does not seem to be any relation between disks. Unless you can make it so the matrix is populated so that it does not change much when a disk is added / removed ? But even in this case, would it mean the PG weights you find lead to low data movement ? I don't see how that can be implemented other than with a walk of the cluster map.

My 2cts

> First, I'll describe the method, then I'll demonstrate with a couple examples.
> 
> # Method
> 
> Consider a weighted set of N items (e.g. OSDs, hosts, racks), across
> which we want to choose S replica sets (i.e. PGs), of R replicas each.
> 
> Generate the list of all (N choose R) possible item combinations.
> 
> Construct matrix A as follows:
>    - The first N rows are the sums of the contributions of each
> replica set to each item. E.g. if item 0 receives 1 unit of data from
> PG 0, 1 unit of data from PG 1, and 0 units of data from all other
> PGs, then row 0 would be [1, 1, 0, ... , 0]
>    - The subsequent rows are generated as additional constraints, as
> needed, below.
> 
> Construct the matrix B which contains the N item weights followed by
> additional constraints, as needed, from below.
> 
> At this point, if A is not square, then we must add constraints.
> AFAICT, this requires a heuristic. Some example constraints we can add
> are:
>   - a = 1, when we are sure that the first replica set must be non-zero
>   - i = j, when the weights in replica set i equal the weights in replica set j
> 
> Solve the set of linear equations A x = B, where x is the weighted
> probability of each replica set.
> 
> Now for the placement, loop until you have S PGs:
>   - choose one replica set from the weighted list of all OSD combinations.
>   - shuffle the chosen replica set
>   - add to the list of chosen replica sets
> 
> # Example 1: 4 OSDs, 3 replicas
> 
> We have four OSDs with IDs [0,1,2,3] and weights [3,3,3,1]. We need
> R=3 replicas in each of 100000 PGs.
> 
> We generate the list of all possible OSD combinations:
> [(0, 1, 2), (0, 1, 3), (0, 2, 3), (1, 2, 3)]
> 
> A =
> [[ 1.  1.  1.  0.]
>  [ 1.  1.  0.  1.]
>  [ 1.  0.  1.  1.]
>  [ 0.  1.  1.  1.]]
> 
> (Note that each OSD combination is represented as a column in A.)
> 
> B = [3.0, 3.0, 3.0, 1.0]
> 
> (Note that A is already square, so no further constraints are needed.
> This simple case occurs when (N choose R) == N).
> 
> Now we solve to get the OSD combination weights:
> x = [ 2.33333333  0.33333333  0.33333333  0.33333333]
> 
> Finally, we observe the resulting PG distribution:
> 
> PGs per OSD:    {0: 90016, 1: 90134, 2: 89907, 3: 29943}
>   Replica 0: {0: 29700, 1: 30200, 2: 30150, 3: 9950}
>   Replica 1: {0: 30121, 1: 30172, 2: 29765, 3: 9942}
>   Replica 2: {0: 30195, 1: 29762, 2: 29992, 3: 10051}
> 
> which matches the ideal distribution.
> 
> # Example 2: 4 OSDs, 2 replicas
> 
> We have four OSDs with IDs [0,1,2,3] and weights [3,3,3,1]. We need
> R=2 replicas in each of 100000 PGs.
> 
> We generate a list of all possible OSD combinations:
> [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]
> 
> A =
> [[ 1.  1.  1.  0.  0.  0.]
>  [ 1.  0.  0.  1.  1.  0.]
>  [ 0.  1.  0.  1.  0.  1.]
>  [ 0.  0.  1.  0.  1.  1.]
>  [ 1.  0.  0.  0.  0.  0.]
>  [ 1. -1.  0.  0.  0.  0.]]
> 
> (Note that the OSD combinations are represented in the first four rows
> of each column).
> 
> B = [3.0, 3.0, 3.0, 1.0, 1.0, 0.0]
> 
> (Note that the last two rows in A and last two values in B are
> constraints added by heuristic. In this case I decided that the
> replica set (0,1) should be included with weight = 1, and that replica
> sets (0,1) and (0,2) should occur with equal frequency).
> 
> Solving to get the PGs weights:
> x = [ 1.  1.  1.  2.  0.  0.]
> 
> Finally, selecting the PGs using x we observe:
> 
> PGs per OSD:    {0: 60100, 1: 59826, 2: 60052, 3: 20022}
>   Replica 0: {0: 30094, 1: 29664, 2: 30263, 3: 9979}
>   Replica 1: {0: 30006, 1: 30162, 2: 29789, 3: 10043}
> 
> which matches the ideal distribution.
> 
> # Prototyping
> 
> I've prototyped this in python here:
>   https://gist.github.com/cernceph/ac273d5846ae8cdd6b5abd4e0574ec55
> 
> Try tweaking the OSD weights and replica number at the top of the
> script to see how it works. But note that it is quite trivial to
> create an unsolvable layout.
> 
> # Discussion
> 
> This approach provides exact solutions to the Ceph PG distribution
> problem, but (a) usually requires additional heuristic constraints
> that I haven't solved in general, and (b) requires that an exact
> solution exists, e.g. the algorithm will break for impossible layouts,
> such as 3 replicas across OSDs weighted [3,3,2].
> 
> Issue (a) probably has a good solution -- it just needs more thought
> and testing.
> Issue (b) can probably be solved by decreasing the effective size of
> the largest items until a solution is possible.
> 
> Lastly, I haven't at all evaluated the stability of this approach when
> the cluster layout changes slightly.
> 
> Thanks!
> 
> Dan
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
