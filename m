From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Regarding cache tier understanding
Date: Thu, 7 Aug 2014 16:00:51 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F264573D0@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2@SACMBXIP02.sdcorp.global.sandisk.com>
	<alpine.DEB.2.00.1408070706200.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1408070706200.18917-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
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
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Allen Samuels <Allen.Samuels-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thanks Sage, this helps !

Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
Sent: Thursday, August 07, 2014 7:12 AM
To: Somnath Roy
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; Anirban Ray; Allen Samuels
Subject: Re: Regarding cache tier understanding

On Thu, 7 Aug 2014, Somnath Roy wrote:
> Hi Sage,
>
> I went through the tiering agent code base and here is my
> understanding on the agent behavior. Please let me know if that is correct.
>
>
>
> 1.       Agent will be always in idle state if target_max_bytes or
> target_max_objects not set on the pool irrespective of other tiering
> params set in the pool. dirty_micro and full_micro will not be
> calculated if those two params are zero which is by default I guess.

Yeah

> 2.       Now, flush will be activated if dirty_micro is >
> flush_target. My understanding is, once it is activated it will
> iterate through all the dirty objects and flush all the dirty objects
> which is > cache_min_flush_age. Am I right ?

Yeah

> 3.       For the eviction, if full_micro > 1000000 , the mode set as
> TierAgentState::EVICT_MODE_FULL and all the clean objects are flushed.

Yeah

> 4.       if (full_micro > evict_target), the mode is set as
> TierAgentState::EVICT_MODE_SOME. In this scenario evict_effort is
> calculated and based on hit_set and temp calculation some clean
> objects are evicted. My question is , can we quantify this value ? For
> ex, if the target_full_ratio = 50%, once the eviction is triggered, what %objects will be evicted ?

The effort is calculated based on how far between target_full and 100% we are.  This is mapped onto the estimation of atime.  We generate a histogram of age for the objects we have examined, so after the agent has run a bit we'll have a reasonable idea how the current object's age compares to others and can decide whether this is older or newer than the others; based on that we decide what to do.

> 5.       Also, why we are multiplying with 1000000 always ? Is it
> because in the histogram it is positioned as 0..1000000 ?

Yeah, and we use "micro" units throughout to avoid doing any floating point.

> 6.       I saw the cache_min_evict_age is not been used anywhere, am I
> missing anything ?

It's possible.  The _min_ params are a bit dangerous because they can potentially confuse the cache agent (e.g., what if *all* objects are under the min?  How/when do we decide to ignore the min, or, how/when do we give up trying to find an older object?).

> 7.       The cache_min_flush_age will only be applicable if the flush
> is triggered after crossing the dirty_threshold, right ? If
> dirty_threshold is not breached, the flush age param is never checked.

Right.

> I need to understand the behavior so that we can test the Cache
> tiering properly.
>
> Is there any behavior I am missing here which you want us to test out ?

There is a new behavior just merged into master that controls our decision to promote data into the cache on read; see maybe_handle_cache().  That's not strictly agent behavior per se.  Also, there is now a readforward mode that doesn't promote on read ever, based on our discussion about the performance of flash on read.

Hope this helps!
sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
