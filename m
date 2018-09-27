From: Maged Mokhtar <mmokhtar-6jkX1og9WkpAfugRpC6u6w@public.gmane.org>
Subject: Re: CRUSH puzzle: step weighted-take
Date: Thu, 27 Sep 2018 21:50:07 +0200
Message-ID: <005bdde7-f206-1405-8255-05025c6d0734@petasan.org>
References: <CABZ+qqmMiGSF3g-WR9TLTUAxwdK3aCt0wq+ku5XWzukp0tJ04w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqmMiGSF3g-WR9TLTUAxwdK3aCt0wq+ku5XWzukp0tJ04w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On 27/09/18 17:18, Dan van der Ster wrote:
> Dear Ceph friends,
>
> I have a CRUSH data migration puzzle and wondered if someone could
> think of a clever solution.
>
> Consider an osd tree like this:
>
>    -2       4428.02979     room 0513-R-0050
>   -72        911.81897         rack RA01
>    -4        917.27899         rack RA05
>    -6        917.25500         rack RA09
>    -9        786.23901         rack RA13
>   -14        895.43903         rack RA17
>   -65       1161.16003     room 0513-R-0060
>   -71        578.76001         ipservice S513-A-IP38
>   -70        287.56000             rack BA09
>   -80        291.20001             rack BA10
>   -76        582.40002         ipservice S513-A-IP63
>   -75        291.20001             rack BA11
>   -78        291.20001             rack BA12
>
> In the beginning, for reasons that are not important, we created two pools:
>    * poolA chooses room=0513-R-0050 then replicates 3x across the racks.
>    * poolB chooses room=0513-R-0060, replicates 2x across the
> ipservices, then puts a 3rd replica in room 0513-R-0050.
>
> For clarity, here is the crush rule for poolB:
>          type replicated
>          min_size 1
>          max_size 10
>          step take 0513-R-0060
>          step chooseleaf firstn 2 type ipservice
>          step emit
>          step take 0513-R-0050
>          step chooseleaf firstn -2 type rack
>          step emit
>
> Now to the puzzle.
> For reasons that are not important, we now want to change the rule for
> poolB to put all three 3 replicas in room 0513-R-0060.
> And we need to do this in a way which is totally non-disruptive
> (latency-wise) to the users of either pools. (These are both *very*
> active RBD pools).
>
> I see two obvious ways to proceed:
>    (1) simply change the rule for poolB to put a third replica on any
> osd in room 0513-R-0060. I'm afraid though that this would involve way
> too many concurrent backfills, cluster-wide, even with
> osd_max_backfills=1.
>    (2) change poolB size to 2, then change the crush rule to that from
> (1), then reset poolB size to 3. This would risk data availability
> during the time that the pool is size=2, and also risks that every osd
> in room 0513-R-0050 would be too busy deleting for some indeterminate
> time period (10s of minutes, I expect).
>
> So I would probably exclude those two approaches.
>
> Conceptually what I'd like to be able to do is a gradual migration,
> which if I may invent some syntax on the fly...
>
> Instead of
>         step take 0513-R-0050
> do
>         step weighted-take 99 0513-R-0050 1 0513-R-0060
>
> That is, 99% of the time take room 0513-R-0050 for the 3rd copies, 1%
> of the time take room 0513-R-0060.
> With a mechanism like that, we could gradually adjust those "step
> weighted-take" lines until 100% of the 3rd copies were in 0513-R-0060.
>
> I have a feeling that something equivalent to that is already possible
> with weight-sets or some other clever crush trickery.
> Any ideas?
>
> Best Regards,
>
> Dan
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
would it be possible in your case to create a parent datacenter bucket 
to hold both rooms and assign their relative weights there, then for the 
third replica do a step take to this parent bucket ? its not elegant but 
may do the trick.
The suggested step weighted-take would be more flexible as it can be 
changed on a replica level, but i do not know if you can do this with 
existing code.

Maged
