From: Sage Weil <sage@newdream.net>
Subject: Re: crush multipick anomaly
Date: Mon, 27 Mar 2017 13:39:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703271334070.10776@piezo.novalocal>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal> <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com> <alpine.DEB.2.11.1703072259520.24356@piezo.novalocal> <CAFdhnjeAdCgqS3N7yvZXEanEc8c_q2hR_HciUD2gdFGcRyaZXQ@mail.gmail.com>
 <649a0116-6f61-0470-69bd-41f64214ad5a@dachary.org> <6b063525-eeec-bdf6-a926-af2e9276f34b@dachary.org> <7f03d75d-0dc7-086e-6f43-5b2717588345@dachary.org> <CAFdhnjcs5sZbnDWXH6qJBge9WYR-Cr+svhr=YZ9hZJrDvo=vxg@mail.gmail.com> <0ad9fa05-fc1c-9bd9-d826-a1dae693b67d@dachary.org>
 <CAFdhnjdQSZZJJ0BUG45-QWUj6enr+0ZPpOxVjNhijzFPXL9==Q@mail.gmail.com> <alpine.DEB.2.11.1703251824460.10776@piezo.novalocal> <CAHMeWhHV=5u=QFggXFNMn2MzGLgQJ6nMnae+ZgK=MB5yYr1p9g@mail.gmail.com> <alpine.DEB.2.11.1703270228100.10776@piezo.novalocal>
 <1fd7676c-3b5c-31d0-a038-91b08f458e40@dachary.org> <CAHMeWhGuJnu2664VTxomQ-wJewBEPjRT_VGWH+g-v5k3ka6X5Q@mail.gmail.com> <CAHMeWhH2j8Ni9b10u+KY_Xum=a-mvRnUoL2F4tJNto5o-q65+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-930994217-1490621994=:10776"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49344 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdC0Nke (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Mar 2017 09:40:34 -0400
In-Reply-To: <CAHMeWhH2j8Ni9b10u+KY_Xum=a-mvRnUoL2F4tJNto5o-q65+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Kupczyk <akupczyk@mirantis.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-930994217-1490621994=:10776
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Mar 2017, Adam Kupczyk wrote:
> Hi,
> 
> My understanding is that optimal tweaked weights will depend on:
> 1) pool_id, because of rjenkins(pool_id) in crush
> 2) number of placement groups and replication factor, as it determines
> amount of samples
> 
> Therefore tweaked weights should rather be property of instantialized pool,
> not crush placement definition.
>
> If tweaked weights are to be part of crush definition, than for each
> created pool we need to have separate list of weights.
> Is it possible to provide clients with different weights depending on on
> which pool they want to operate?

As Loic suggested, you can create as many derivative hierarchies in the 
crush map as you like, potentially one per pool.  Or you could treat the 
sum total of all pgs as the interesting set, balance those, and get some 
OSDs doing a bit more of one pool than another.  The new post-CRUSH OSD 
remap capability can always clean this up (and turn a "good" crush 
distribution into a perfect distribution).

I guess the question is: when we add the explicit adjusted weight matrix 
to crush should we have multiple sets of weights (perhaps one for each 
pool), or simply have a single global set.  It might make sense to allow N 
sets of adjusted weights so that the crush users can choose a particular 
set of them for different pools (or whatever it is they're calculating the 
mapping for)..

sage


> 
> Best regards,
> Adam
> 
> On Mon, Mar 27, 2017 at 10:45 AM, Adam Kupczyk <akupczyk@mirantis.com> wrote:
> > Hi,
> >
> > My understanding is that optimal tweaked weights will depend on:
> > 1) pool_id, because of rjenkins(pool_id) in crush
> > 2) number of placement groups and replication factor, as it determines
> > amount of samples
> >
> > Therefore tweaked weights should rather be property of instantialized pool,
> > not crush placement definition.
> >
> > If tweaked weights are to be part of crush definition, than for each created
> > pool we need to have separate list of weights.
> > Is it possible to provide clients with different weights depending on on
> > which pool they want to operate?
> >
> > Best regards,
> > Adam
> >
> >
> > On Mon, Mar 27, 2017 at 8:45 AM, Loic Dachary <loic@dachary.org> wrote:
> >>
> >>
> >>
> >> On 03/27/2017 04:33 AM, Sage Weil wrote:
> >> > On Sun, 26 Mar 2017, Adam Kupczyk wrote:
> >> >> Hello Sage, Loic, Pedro,
> >> >>
> >> >>
> >> >> I am certain that almost perfect mapping can be achieved by
> >> >> substituting weights from crush map with slightly modified weights.
> >> >> By perfect mapping I mean we get on each OSD number of PGs exactly
> >> >> proportional to weights specified in crush map.
> >> >>
> >> >> 1. Example
> >> >> Lets think of PGs of single object pool.
> >> >> We have OSDs with following weights:
> >> >> [10, 10, 10, 5, 5]
> >> >>
> >> >> Ideally, we would like following distribution of 200PG x 3 copies = 600
> >> >> PGcopies :
> >> >> [150, 150, 150, 75, 75]
> >> >>
> >> >> However, because crush simulates random process we have:
> >> >> [143, 152, 158, 71, 76]
> >> >>
> >> >> We could have obtained perfect distribution had we used weights like
> >> >> this:
> >> >> [10.2, 9.9, 9.6, 5.2, 4.9]
> >> >>
> >> >>
> >> >> 2. Obtaining perfect mapping weights from OSD capacity weights
> >> >>
> >> >> When we apply crush for the first time, distribution of PGs comes as
> >> >> random.
> >> >> CRUSH([10, 10, 10, 5, 5]) -> [143, 152, 158, 71, 76]
> >> >>
> >> >> But CRUSH is not random proces at all, it behaves in numerically stable
> >> >> way.
> >> >> Specifically, if we increase weight on one node, we will get more PGs
> >> >> on
> >> >> this node and less on every other node:
> >> >> CRUSH([10.1, 10, 10, 5, 5]) -> [146(+3), 152, 156(-2), 70(-1), 76]
> >> >>
> >> >> Now, finding ideal weights can be done by any numerical minimization
> >> >> method,
> >> >> for example NLMS.
> >> >>
> >> >>
> >> >> 3. The proposal
> >> >> For each pool, from initial weights given in crush map perfect weights
> >> >> will
> >> >> be derived.
> >> >> This weights will be used to calculate PG distribution. This of course
> >> >> will
> >> >> be close to perfect.
> >> >>
> >> >> 3a: Downside when OSD is out
> >> >> When an OSD is out, missing PG copies will be replicated elsewhere.
> >> >> Because now weights deviate from OSD capacity, some OSDs will
> >> >> statistically
> >> >> get more copies then they should.
> >> >> This unevenness in distribution is proportional to scale of deviation
> >> >> of
> >> >> calculated weights to capacity weights.
> >> >>
> >> >> 3b: Upside
> >> >> This all can be achieved without changes to crush.
> >> >
> >> > Yes!
> >> >
> >> > And no.  You're totally right--we should use an offline optimization to
> >> > tweak the crush input weights to get a better balance.  It won't be
> >> > robust
> >> > to changes to the cluster, but we can incrementally optimize after that
> >> > happens to converge on something better.
> >> >
> >> > The problem with doing this with current versions of Ceph is that we
> >> > lose
> >> > the original "input" or "target" weights (i.e., the actual size of
> >> > the OSD) that we want to converge on.  This is one reason why we haven't
> >> > done something like this before.
> >> >
> >> > In luminous we *could* work around this by storing those canonical
> >> > weights outside of crush using something (probably?) ugly and
> >> > maintain backward compatibility with older clients using existing
> >> > CRUSH behavior.
> >>
> >> These canonical weights could be stored in crush by creating dedicated
> >> buckets. For instance the root-canonical bucket could be created to store
> >> the canonical weights of the root bucket. The sysadmin needs to be aware of
> >> the difference and know to add a new device in the host01-canonical bucket
> >> instead of the host01 bucket. And to run an offline tool to keep the two
> >> buckets in sync and compute the weight to use for placement derived from the
> >> weights representing the device capacity.
> >>
> >> It is a little bit ugly ;-)
> >>
> >> > OR, (and this is my preferred route), if the multi-pick anomaly approach
> >> > that Pedro is working on works out, we'll want to extend the CRUSH map
> >> > to
> >> > include a set of derivative weights used for actual placement
> >> > calculations
> >> > instead of the canonical target weights, and we can do what you're
> >> > proposing *and* solve the multipick problem with one change in the crush
> >> > map and algorithm.  (Actually choosing those derivative weights will
> >> > be an offline process that can both improve the balance for the inputs
> >> > we
> >> > care about *and* adjust them based on the position to fix the skew issue
> >> > for replicas.)  This doesn't help pre-luminous clients, but I think the
> >> > end solution will be simpler and more elegant...
> >> >
> >> > What do you think?
> >> >
> >> > sage
> >> >
> >> >
> >> >> 4. Extra
> >> >> Some time ago I made such change to perfectly balance Thomson-Reuters
> >> >> cluster.
> >> >> It succeeded.
> >> >> A solution was not accepted, because modification of OSD weights were
> >> >> higher
> >> >> then 50%, which was caused by fact that different placement rules
> >> >> operated
> >> >> on different sets of OSDs, and those sets were not disjointed.
> >> >
> >> >
> >> >>
> >> >> Best regards,
> >> >> Adam
> >> >>
> >> >>
> >> >> On Sat, Mar 25, 2017 at 7:42 PM, Sage Weil <sage@newdream.net> wrote:
> >> >>       Hi Pedro, Loic,
> >> >>
> >> >>       For what it's worth, my intuition here (which has had a mixed
> >> >>       record as
> >> >>       far as CRUSH goes) is that this is the most promising path
> >> >>       forward.
> >> >>
> >> >>       Thinking ahead a few steps, and confirming that I'm following
> >> >>       the
> >> >>       discussion so far, if you're able to do get black (or white) box
> >> >>       gradient
> >> >>       descent to work, then this will give us a set of weights for
> >> >>       each item in
> >> >>       the tree for each selection round, derived from the tree
> >> >>       structure and
> >> >>       original (target) weights.  That would basically give us a map
> >> >>       of item id
> >> >>       (bucket id or leave item id) to weight for each round.  i.e.,
> >> >>
> >> >>        map<int, map<int, float>> weight_by_position;  // position ->
> >> >>       item -> weight
> >> >>
> >> >>       where the 0 round would (I think?) match the target weights, and
> >> >>       each
> >> >>       round after that would skew low-weighted items lower to some
> >> >>       degree.
> >> >>       Right?
> >> >>
> >> >>       The next question I have is: does this generalize from the
> >> >>       single-bucket
> >> >>       case to the hierarchy?  I.e., if I have a "tree" (single bucket)
> >> >>       like
> >> >>
> >> >>       3.1
> >> >>        |_____________
> >> >>        |   \    \    \
> >> >>       1.0  1.0  1.0  .1
> >> >>
> >> >>       it clearly works, but when we have a multi-level tree like
> >> >>
> >> >>
> >> >>       8.4
> >> >>        |____________________________________
> >> >>        |                 \                  \
> >> >>       3.1                3.1                2.2
> >> >>        |_____________     |_____________     |_____________
> >> >>        |   \    \    \    |   \    \    \    |   \    \    \
> >> >>       1.0  1.0  1.0  .1   1.0  1.0  1.0  .1  1.0  1.0 .1   .1
> >> >>
> >> >>       and the second round weights skew the small .1 leaves lower, can
> >> >>       we
> >> >>       continue to build the summed-weight hierarchy, such that the
> >> >>       adjusted
> >> >>       weights at the higher level are appropriately adjusted to give
> >> >>       us the
> >> >>       right probabilities of descending into those trees?  I'm not
> >> >>       sure if that
> >> >>       logically follows from the above or if my intuition is
> >> >>       oversimplifying
> >> >>       things.
> >> >>
> >> >>       If this *is* how we think this will shake out, then I'm
> >> >>       wondering if we
> >> >>       should go ahead and build this weigh matrix into CRUSH sooner
> >> >>       rather
> >> >>       than later (i.e., for luminous).  As with the explicit
> >> >>       remappings, the
> >> >>       hard part is all done offline, and the adjustments to the CRUSH
> >> >>       mapping
> >> >>       calculation itself (storing and making use of the adjusted
> >> >>       weights for
> >> >>       each round of placement) are relatively straightforward.  And
> >> >>       the sooner
> >> >>       this is incorporated into a release the sooner real users will
> >> >>       be able to
> >> >>       roll out code to all clients and start making us of it.
> >> >>
> >> >>       Thanks again for looking at this problem!  I'm excited that we
> >> >>       may be
> >> >>       closing in on a real solution!
> >> >>
> >> >>       sage
> >> >>
> >> >>
> >> >>
> >> >>
> >> >>
> >> >>       On Thu, 23 Mar 2017, Pedro López-Adeva wrote:
> >> >>
> >> >>       > There are lot of gradient-free methods. I will try first to
> >> >>       run the
> >> >>       > ones available using just scipy
> >> >>       >
> >> >>
> >> >> (https://docs.scipy.org/doc/scipy-0.18.1/reference/optimize.html).
> >> >>       > Some of them don't require the gradient and some of them can
> >> >>       estimate
> >> >>       > it. The reason to go without the gradient is to run the CRUSH
> >> >>       > algorithm as a black box. In that case this would be the
> >> >>       pseudo-code:
> >> >>       >
> >> >>       > - BEGIN CODE -
> >> >>       > def build_target(desired_freqs):
> >> >>       >     def target(weights):
> >> >>       >         # run a simulation of CRUSH for a number of objects
> >> >>       >         sim_freqs = run_crush(weights)
> >> >>       >         # Kullback-Leibler divergence between desired
> >> >>       frequencies and
> >> >>       > current ones
> >> >>       >         return loss(sim_freqs, desired_freqs)
> >> >>       >    return target
> >> >>       >
> >> >>       > weights = scipy.optimize.minimize(build_target(desired_freqs))
> >> >>       > - END CODE -
> >> >>       >
> >> >>       > The tricky thing here is that this procedure can be slow if
> >> >>       the
> >> >>       > simulation (run_crush) needs to place a lot of objects to get
> >> >>       accurate
> >> >>       > simulated frequencies. This is true specially if the minimize
> >> >>       method
> >> >>       > attempts to approximate the gradient using finite differences
> >> >>       since it
> >> >>       > will evaluate the target function a number of times
> >> >>       proportional to
> >> >>       > the number of weights). Apart from the ones in scipy I would
> >> >>       try also
> >> >>       > optimization methods that try to perform as few evaluations as
> >> >>       > possible like for example HyperOpt
> >> >>       > (http://hyperopt.github.io/hyperopt/), which by the way takes
> >> >>       into
> >> >>       > account that the target function can be noisy.
> >> >>       >
> >> >>       > This black box approximation is simple to implement and makes
> >> >>       the
> >> >>       > computer do all the work instead of us.
> >> >>       > I think that this black box approximation is worthy to try
> >> >>       even if
> >> >>       > it's not the final one because if this approximation works
> >> >>       then we
> >> >>       > know that a more elaborate one that computes the gradient of
> >> >>       the CRUSH
> >> >>       > algorithm will work for sure.
> >> >>       >
> >> >>       > I can try this black box approximation this weekend not on the
> >> >>       real
> >> >>       > CRUSH algorithm but with the simple implementation I did in
> >> >>       python. If
> >> >>       > it works it's just a matter of substituting one simulation
> >> >>       with
> >> >>       > another and see what happens.
> >> >>       >
> >> >>       > 2017-03-23 15:13 GMT+01:00 Loic Dachary <loic@dachary.org>:
> >> >>       > > Hi Pedro,
> >> >>       > >
> >> >>       > > On 03/23/2017 12:49 PM, Pedro López-Adeva wrote:
> >> >>       > >> Hi Loic,
> >> >>       > >>
> >> >>       > >>>From what I see everything seems OK.
> >> >>       > >
> >> >>       > > Cool. I'll keep going in this direction then !
> >> >>       > >
> >> >>       > >> The interesting thing would be to
> >> >>       > >> test on some complex mapping. The reason is that
> >> >>       "CrushPolicyFamily"
> >> >>       > >> is right now modeling just a single straw bucket not the
> >> >>       full CRUSH
> >> >>       > >> algorithm.
> >> >>       > >
> >> >>       > > A number of use cases use a single straw bucket, maybe the
> >> >>       majority of them. Even though it does not reflect the full range
> >> >>       of what crush can offer, it could be useful. To be more
> >> >>       specific, a crush map that states "place objects so that there
> >> >>       is at most one replica per host" or "one replica per rack" is
> >> >>       common. Such a crushmap can be reduced to a single straw bucket
> >> >>       that contains all the hosts and by using the CrushPolicyFamily,
> >> >>       we can change the weights of each host to fix the probabilities.
> >> >>       The hosts themselves contain disks with varying weights but I
> >> >>       think we can ignore that because crush will only recurse to
> >> >>       place one object within a given host.
> >> >>       > >
> >> >>       > >> That's the work that remains to be done. The only way that
> >> >>       > >> would avoid reimplementing the CRUSH algorithm and
> >> >>       computing the
> >> >>       > >> gradient would be treating CRUSH as a black box and
> >> >>       eliminating the
> >> >>       > >> necessity of computing the gradient either by using a
> >> >>       gradient-free
> >> >>       > >> optimization method or making an estimation of the
> >> >>       gradient.
> >> >>       > >
> >> >>       > > By gradient-free optimization you mean simulated annealing
> >> >>       or Monte Carlo ?
> >> >>       > >
> >> >>       > > Cheers
> >> >>       > >
> >> >>       > >>
> >> >>       > >>
> >> >>       > >> 2017-03-20 11:49 GMT+01:00 Loic Dachary <loic@dachary.org>:
> >> >>       > >>> Hi,
> >> >>       > >>>
> >> >>       > >>> I modified the crush library to accept two weights (one
> >> >>       for the first disk, the other for the remaining disks)[1]. This
> >> >>       really is a hack for experimentation purposes only ;-) I was
> >> >>       able to run a variation of your code[2] and got the following
> >> >>       results which are encouraging. Do you think what I did is
> >> >>       sensible ? Or is there a problem I don't see ?
> >> >>       > >>>
> >> >>       > >>> Thanks !
> >> >>       > >>>
> >> >>       > >>> Simulation: R=2 devices capacity [10  8  6 10  8  6 10  8
> >> >>       6]
> >> >>       > >>>
> >> >>
> >> >> ------------------------------------------------------------------------
> >> >>       > >>> Before: All replicas on each hard drive
> >> >>       > >>> Expected vs actual use (20000 samples)
> >> >>       > >>>  disk 0: 1.39e-01 1.12e-01
> >> >>       > >>>  disk 1: 1.11e-01 1.10e-01
> >> >>       > >>>  disk 2: 8.33e-02 1.13e-01
> >> >>       > >>>  disk 3: 1.39e-01 1.11e-01
> >> >>       > >>>  disk 4: 1.11e-01 1.11e-01
> >> >>       > >>>  disk 5: 8.33e-02 1.11e-01
> >> >>       > >>>  disk 6: 1.39e-01 1.12e-01
> >> >>       > >>>  disk 7: 1.11e-01 1.12e-01
> >> >>       > >>>  disk 8: 8.33e-02 1.10e-01
> >> >>       > >>> it=    1 jac norm=1.59e-01 loss=5.27e-03
> >> >>       > >>> it=    2 jac norm=1.55e-01 loss=5.03e-03
> >> >>       > >>> ...
> >> >>       > >>> it=  212 jac norm=1.02e-03 loss=2.41e-07
> >> >>       > >>> it=  213 jac norm=1.00e-03 loss=2.31e-07
> >> >>       > >>> Converged to desired accuracy :)
> >> >>       > >>> After: All replicas on each hard drive
> >> >>       > >>> Expected vs actual use (20000 samples)
> >> >>       > >>>  disk 0: 1.39e-01 1.42e-01
> >> >>       > >>>  disk 1: 1.11e-01 1.09e-01
> >> >>       > >>>  disk 2: 8.33e-02 8.37e-02
> >> >>       > >>>  disk 3: 1.39e-01 1.40e-01
> >> >>       > >>>  disk 4: 1.11e-01 1.13e-01
> >> >>       > >>>  disk 5: 8.33e-02 8.08e-02
> >> >>       > >>>  disk 6: 1.39e-01 1.38e-01
> >> >>       > >>>  disk 7: 1.11e-01 1.09e-01
> >> >>       > >>>  disk 8: 8.33e-02 8.48e-02
> >> >>       > >>>
> >> >>       > >>>
> >> >>       > >>> Simulation: R=2 devices capacity [10 10 10 10  1]
> >> >>       > >>>
> >> >>
> >> >> ------------------------------------------------------------------------
> >> >>       > >>> Before: All replicas on each hard drive
> >> >>       > >>> Expected vs actual use (20000 samples)
> >> >>       > >>>  disk 0: 2.44e-01 2.36e-01
> >> >>       > >>>  disk 1: 2.44e-01 2.38e-01
> >> >>       > >>>  disk 2: 2.44e-01 2.34e-01
> >> >>       > >>>  disk 3: 2.44e-01 2.38e-01
> >> >>       > >>>  disk 4: 2.44e-02 5.37e-02
> >> >>       > >>> it=    1 jac norm=2.43e-01 loss=2.98e-03
> >> >>       > >>> it=    2 jac norm=2.28e-01 loss=2.47e-03
> >> >>       > >>> ...
> >> >>       > >>> it=   37 jac norm=1.28e-03 loss=3.48e-08
> >> >>       > >>> it=   38 jac norm=1.07e-03 loss=2.42e-08
> >> >>       > >>> Converged to desired accuracy :)
> >> >>       > >>> After: All replicas on each hard drive
> >> >>       > >>> Expected vs actual use (20000 samples)
> >> >>       > >>>  disk 0: 2.44e-01 2.46e-01
> >> >>       > >>>  disk 1: 2.44e-01 2.44e-01
> >> >>       > >>>  disk 2: 2.44e-01 2.41e-01
> >> >>       > >>>  disk 3: 2.44e-01 2.45e-01
> >> >>       > >>>  disk 4: 2.44e-02 2.33e-02
> >> >>       > >>>
> >> >>       > >>>
> >> >>       > >>> [1] crush
> >> >> hackhttp://libcrush.org/main/libcrush/commit/6efda297694392d0b07845eb98464a0dcd
> >> >>       56fee8
> >> >>       > >>> [2] python-crush
> >> >> hackhttp://libcrush.org/dachary/python-crush/commit/d9202fcd4d17cd2a82b37ec20c1
> >> >>       bd25f8f2c4b68
> >> >>       > >>>
> >> >>       > >>> On 03/19/2017 11:31 PM, Loic Dachary wrote:
> >> >>       > >>>> Hi Pedro,
> >> >>       > >>>>
> >> >>       > >>>> It looks like trying to experiment with crush won't work
> >> >>       as expected because crush does not distinguish the probability
> >> >>       of selecting the first device from the probability of selecting
> >> >>       the second or third device. Am I mistaken ?
> >> >>       > >>>>
> >> >>       > >>>> Cheers
> >> >>       > >>>>
> >> >>       > >>>> On 03/18/2017 10:21 AM, Loic Dachary wrote:
> >> >>       > >>>>> Hi Pedro,
> >> >>       > >>>>>
> >> >>       > >>>>> I'm going to experiment with what you did at
> >> >>       > >>>>>
> >> >>       > >>>>>
> >> >>       https://github.com/plafl/notebooks/blob/master/replication.ipynb
> >> >>       > >>>>>
> >> >>       > >>>>> and the latest python-crush published today. A
> >> >>       comparison function was added that will help measure the data
> >> >>       movement. I'm hoping we can release an offline tool based on
> >> >>       your solution. Please let me know if I should wait before diving
> >> >>       into this, in case you have unpublished drafts or new ideas.
> >> >>       > >>>>>
> >> >>       > >>>>> Cheers
> >> >>       > >>>>>
> >> >>       > >>>>> On 03/09/2017 09:47 AM, Pedro López-Adeva wrote:
> >> >>       > >>>>>> Great, thanks for the clarifications.
> >> >>       > >>>>>> I also think that the most natural way is to keep just
> >> >>       a set of
> >> >>       > >>>>>> weights in the CRUSH map and update them inside the
> >> >>       algorithm.
> >> >>       > >>>>>>
> >> >>       > >>>>>> I keep working on it.
> >> >>       > >>>>>>
> >> >>       > >>>>>>
> >> >>       > >>>>>> 2017-03-08 0:06 GMT+01:00 Sage Weil
> >> >>       <sage@newdream.net>:
> >> >>       > >>>>>>> Hi Pedro,
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> Thanks for taking a look at this!  It's a frustrating
> >> >>       problem and we
> >> >>       > >>>>>>> haven't made much headway.
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> On Thu, 2 Mar 2017, Pedro López-Adeva wrote:
> >> >>       > >>>>>>>> Hi,
> >> >>       > >>>>>>>>
> >> >>       > >>>>>>>> I will have a look. BTW, I have not progressed that
> >> >>       much but I have
> >> >>       > >>>>>>>> been thinking about it. In order to adapt the
> >> >>       previous algorithm in
> >> >>       > >>>>>>>> the python notebook I need to substitute the
> >> >>       iteration over all
> >> >>       > >>>>>>>> possible devices permutations to iteration over all
> >> >>       the possible
> >> >>       > >>>>>>>> selections that crush would make. That is the main
> >> >>       thing I need to
> >> >>       > >>>>>>>> work on.
> >> >>       > >>>>>>>>
> >> >>       > >>>>>>>> The other thing is of course that weights change for
> >> >>       each replica.
> >> >>       > >>>>>>>> That is, they cannot be really fixed in the crush
> >> >>       map. So the
> >> >>       > >>>>>>>> algorithm inside libcrush, not only the weights in
> >> >>       the map, need to be
> >> >>       > >>>>>>>> changed. The weights in the crush map should reflect
> >> >>       then, maybe, the
> >> >>       > >>>>>>>> desired usage frequencies. Or maybe each replica
> >> >>       should have their own
> >> >>       > >>>>>>>> crush map, but then the information about the
> >> >>       previous selection
> >> >>       > >>>>>>>> should be passed to the next replica placement run so
> >> >>       it avoids
> >> >>       > >>>>>>>> selecting the same one again.
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> My suspicion is that the best solution here (whatever
> >> >>       that means!)
> >> >>       > >>>>>>> leaves the CRUSH weights intact with the desired
> >> >>       distribution, and
> >> >>       > >>>>>>> then generates a set of derivative weights--probably
> >> >>       one set for each
> >> >>       > >>>>>>> round/replica/rank.
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> One nice property of this is that once the support is
> >> >>       added to encode
> >> >>       > >>>>>>> multiple sets of weights, the algorithm used to
> >> >>       generate them is free to
> >> >>       > >>>>>>> change and evolve independently.  (In most cases any
> >> >>       change is
> >> >>       > >>>>>>> CRUSH's mapping behavior is difficult to roll out
> >> >>       because all
> >> >>       > >>>>>>> parties participating in the cluster have to support
> >> >>       any new behavior
> >> >>       > >>>>>>> before it is enabled or used.)
> >> >>       > >>>>>>>
> >> >>       > >>>>>>>> I have a question also. Is there any significant
> >> >>       difference between
> >> >>       > >>>>>>>> the device selection algorithm description in the
> >> >>       paper and its final
> >> >>       > >>>>>>>> implementation?
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> The main difference is the "retry_bucket" behavior was
> >> >>       found to be a bad
> >> >>       > >>>>>>> idea; any collision or failed()/overload() case
> >> >>       triggers the
> >> >>       > >>>>>>> retry_descent.
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> There are other changes, of course, but I don't think
> >> >>       they'll impact any
> >> >>       > >>>>>>> solution we come with here (or at least any solution
> >> >>       can be suitably
> >> >>       > >>>>>>> adapted)!
> >> >>       > >>>>>>>
> >> >>       > >>>>>>> sage
> >> >>       > >>>>>> --
> >> >>       > >>>>>> To unsubscribe from this list: send the line
> >> >>       "unsubscribe ceph-devel" in
> >> >>       > >>>>>> the body of a message to majordomo@vger.kernel.org
> >> >>       > >>>>>> More majordomo info at
> >> >>       http://vger.kernel.org/majordomo-info.html
> >> >>       > >>>>>>
> >> >>       > >>>>>
> >> >>       > >>>>
> >> >>       > >>>
> >> >>       > >>> --
> >> >>       > >>> Loïc Dachary, Artisan Logiciel Libre
> >> >>       > >> --
> >> >>       > >> To unsubscribe from this list: send the line "unsubscribe
> >> >>       ceph-devel" in
> >> >>       > >> the body of a message to majordomo@vger.kernel.org
> >> >>       > >> More majordomo info at
> >> >>       http://vger.kernel.org/majordomo-info.html
> >> >>       > >>
> >> >>       > >
> >> >>       > > --
> >> >>       > > Loïc Dachary, Artisan Logiciel Libre
> >> >>       > --
> >> >>       > To unsubscribe from this list: send the line "unsubscribe
> >> >>       ceph-devel" in
> >> >>       > the body of a message to majordomo@vger.kernel.org
> >> >>       > More majordomo info at
> >> >>       http://vger.kernel.org/majordomo-info.html
> >> >>       >
> >> >>       >
> >> >>
> >> >>
> >> >>
> >>
> >> --
> >> Loïc Dachary, Artisan Logiciel Libre
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-930994217-1490621994=:10776--
