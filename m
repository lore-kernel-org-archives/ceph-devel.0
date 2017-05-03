From: Dan van der Ster <dan@vanderster.com>
Subject: Re: revisiting uneven CRUSH distributions
Date: Wed, 3 May 2017 19:59:26 +0200
Message-ID: <CABZ+qqkEyFOhk7mLjP65OQgBOwW5pinTpbTNeSDPHpsKv2AUmQ@mail.gmail.com>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
 <9e59a2e1-4aab-9c71-901c-379b537df517@dachary.org> <CABZ+qqmvMSy+A8uqwYBh24P0o9Kh6-T0Zi_H-__kqSoRAzokiQ@mail.gmail.com>
 <876ebcef-03b6-077c-8d58-9fe14c1480a9@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36042 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdECSAJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 14:00:09 -0400
Received: by mail-io0-f176.google.com with SMTP id p80so192663321iop.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 11:00:09 -0700 (PDT)
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com. [209.85.223.178])
        by smtp.gmail.com with ESMTPSA id k101sm9561761iod.39.2017.05.03.11.00.07
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 11:00:07 -0700 (PDT)
Received: by mail-io0-f178.google.com with SMTP id r16so192642737ioi.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 11:00:07 -0700 (PDT)
In-Reply-To: <876ebcef-03b6-077c-8d58-9fe14c1480a9@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, May 3, 2017 at 6:50 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 05/03/2017 11:35 AM, Dan van der Ster wrote:
>> On Tue, May 2, 2017 at 6:16 PM, Loic Dachary <loic@dachary.org> wrote:
>>> Greg raised the following problem today: what if, as a consequence of c=
hanging the weights, the failure of a host/rack (whatever the failure domai=
n is) makes the cluster full ? For instance if you have racks 1, 2, 3 with =
"effective" weights .8, 1.1, 1 and you lose half of rack 3 then rack 2 is g=
oing to get a lot more of the data than rack 1 is.
>>>
>>
>> Is this really a problem? In your example, the rack weights are
>> tweaked to correct the "rate" at which CRUSH is assigning PGs to each
>> rack. If you fail half of rack 3, then your effective weights will
>> continue to ensure that the moved PGs get equally assigned to racks 1
>> and 2.
>
> It should be possible to verify if the opimitization makes things worse i=
n case of a failure, just by running a simulation with every failure scenar=
io. If the worst scenario (i.e. the one with the highest overfull OSD) befo=
re optimization is better than the worst scenario after optimization, the o=
pimization can be discarded.
>

OK, worth verifying like you said.

>> On the other hand, one problem I see with your new approach is that it
>> does not address the secondary multi-pick problem, which is that the
>> ratio of 1st, 2nd, 3rd, etc... replicas/stripes is not equal for the
>> lower weighted OSDs.
>
> Note that in pools with less than 10,000 PGs the multi-pick problem does =
not happen: there are too few samples and the uneven distribution is domina=
ted by that problem.

OK perhaps you're right. The scenario I try to consider is for very
wide erasure coding -- say 8+4 or wider -- which has the same effect
as a size=3D12 replication pool.
I should use your simulator to provide real examples, I know.

>
> However, I think the proposed algorithm could also work by tweaking the w=
eights of each replica (but I only thought about it right now so...):
>
>   first pick uses the target weights, say 1 1 1 1 10, always
>   second pick uses the target weights the first time
>   run a simulation and lower the weight of the item that is the most over=
 full and increase the weight of the item that is the most under full
>   repeat until the distribution is even
>   do the same for the third pick etc.
>
> If we do that we have the desired property of a distribution that is stab=
le when we change the size of the pool. The key difference with the previou=
s approaches is that the weights are adjusted based on repeated simulations=
 instead of maths. For every pool know the exact value of each PG placed by=
 Ceph using CRUSH.
>
> Does that make sense or am I missing something ?

Sounds worth a try.

Thinking (on my toes) about this a bit more, assuming that this
iterative algorithm will bear fruit, I could imagine an interface
like:

ceph osd crush reweight-by-pg <bucket> <num iterations>

Each iteration does what you described: subtract a small amount of
(crush) weight from the fullest OSD, add that (crush) weight back to
the emptiest. [1]
On a production cluster with lots of data, the operator could minimize
data movement by invoking just a small number of iterations at once.
New clusters could run, say, a million iterations to quickly find the
optimal weights.

ceph-mgr could play a role by periodically invoking "ceph osd crush
reweight-by-pg" -- a cron of sorts -- or it could invoke that based on
some conditions related to cluster IO activity.

Other random question [2].

Cheers, Dan

[1] implementation question: do you plan to continue storing and
displaying the original crush weight (based on disk size), or would
this optimization algorithm overwrite that with the tuned value? IOW,
will we store/display "crush weight" and "effective crush weight"
separately?

[2] implementation question: could we store and use a unique
"effective crush weight" set for each pool, rather than just once for
the whole cluster? This way, newly created pools could be balanced
perfectly using this algorithm (involving zero data movement), and
legacy pools could be left imbalanced (to be slowly optimized over
several days/weeks).
