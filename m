From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Filestore throttling
Date: Tue, 28 Oct 2014 08:59:29 +0000
Message-ID: <BLU175-W342F27D41BA13BF4F0F763DF9F0@phx.gbl>
References: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>,
	<alpine.DEB.2.00.1410222104080.10837@cobra.newdream.net>
	<BLU175-W176682F001CDC16FC4FA67DF920@phx.gbl>,
	<alpine.DEB.2.00.1410230653320.10837@cobra.newdream.net>,
	<BLU175-W21BCCB0C8E9A1CF98FB27EDF930@phx.gbl>,
	<alpine.DEB.2.00.1410232119190.10837@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1410232119190.10837-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



----------------------------------------
> Date: Thu, 23 Oct 2014 21:26:07 -0700
> From: sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org
> To: yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org
> CC: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: RE: Filestore throttling
>
> On Fri, 24 Oct 2014, GuangYang wrote:
>>> commit 44dca5c8c5058acf9bc391303dc77893793ce0be
>>> Author: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
>>> Date: Sat Jan 19 17:33:25 2013 -0800
>>>
>>> filestore: disable extra committing queue allowance
>>>
>>> The motivation here is if there is a problem draining the op queue
>>> during a sync. For XFS and ext4, this isn't generally a problem: you
>>> can continue to make writes while a syncfs(2) is in progress. There
>>> are currently some possible implementation issues with btrfs, but we
>>> have not demonstrated them recently.
>>>
>>> Meanwhile, this can cause queue length spikes that screw up latency.
>>> During a commit, we allow too much into the queue (say, recovery
>>> operations). After the sync finishes, we have to drain it out before
>>> we can queue new work (say, a higher priority client request). Having
>>> a deep queue below the point where priorities order work limits the
>>> value of the priority queue.
>>>
>>> Signed-off-by: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
>>>
>>> I'm not sure it makes sense to increase it in the general case. It might
>>> make sense for your workload, or we may want to make peering transactio=
ns
>>> some sort of special case...?
>> It is actually another commit:
>>
>> commit 40654d6d53436c210b2f80911217b044f4d7643a
>> filestore: filestore_queue_max_ops 500 -> 50
>> Having a deep queue limits the effectiveness of the priority queues
>> above by adding additional latency.
>
> Ah, you're right.
>
>> I don't quite understand the use case that it might add additional
>> latency by increasing this value, would you mind elaborating?
>
> There is a priority queue a bit further up the stack OpWQ, in which high
> priority items (e.g., client IO) can move ahead of low priority items
> (e.g., recovery). If the queue beneath that (the filestore one) is very
> deep, the client IO will only have a marginal advantage over the recovery
> IO since it will still sit in the second queue for a long time. Ideally,
> we want the priority queue to be the deepest one (so that we maximize the
> amount of stuff we can reorder) and the queues above and below to be as
> shallow as possible.

That makes perfect sense, thanks for explaining the details.

>
> I think the peering operations are different because they can't be
> reordered with respect to anything else in the same PG (unlike, say,
> client vs recovery io for that pg). On the other hand, there may be
> client IO on other PGs that we want to reorder and finish more quickly.
> Allowing all of the right reordering and also getting the priority
> inheritence right here is probably a hugely complex undertaking, so we
> probably just want to go for a reasonably simple strategy that avoids the
> worst instances of priority inversion (where an important thing is stuck
> behind a slow thing). :/

We mainly observed the following issues during peering:
=A0 1. For several peering OPs (pg_info, pg_notify, pg_log), the dispatcher=
 thread needs to queue filestore transaction which in turn need to acquire =
filesotre ops/bytes budget, so that once the OSD hit the upper limit of tho=
se throttler, the dispatcher thread would hang which blocks all OPs. In thi=
s regard, it is very dangerous to hit those threshold as it could severely =
impact performance.=A0
=A0 =A02. If the OSD was down for a while, the peering OP to search for mis=
sing objects could take up to several minutes, during which time period thi=
s PG is inactive can all traffic to that PG would stuck, I am not sure if t=
here is a chance to improve for such situation due to the strong consistenc=
y model, increasing the op thread number could help a little bit as sometim=
es those peering OPs could eat up all op threads.
>
> In any case, though, I'm skeptical that making the lowest-level queue
> deeper is going to help in general, even if it addresses the peering
> case specifically...
>
> sage
 		 	   		  =
