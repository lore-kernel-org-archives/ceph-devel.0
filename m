From: Jens Rosenboom <j.rosenboom-C33AMpY93qY@public.gmane.org>
Subject: Re: RGW: Truncated objects and bad error handling
Date: Mon, 12 Jun 2017 11:06:39 +0000
Message-ID: <CADr68Wa1BdGHgu9z3WtdmA1hTeTQx4H825H5kcXDa2YF6Tq-bA@mail.gmail.com>
References: <CADr68WaSwmgd3Cwf9AcEcbTYefbrEmREoFYzeWdeGtksEDjgFA@mail.gmail.com>
	<CAJ4mKGbbPyUsj662Fz84NYvvKjbsQxXz=Eagpk+r9bh5gW-7NQ@mail.gmail.com>
	<CADr68WbwwSvvcm_rBAFvA_K_EN9Q9+sJ9Sg0x6ivO_S_aHCdyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADr68WbwwSvvcm_rBAFvA_K_EN9Q9+sJ9Sg0x6ivO_S_aHCdyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Adding ceph-devel as this now involves two bugs that are IMO critical,
one resulting in data loss, the other in data not getting removed
properly.

2017-06-07 9:23 GMT+00:00 Jens Rosenboom <j.rosenboom-C33AMpY93qY@public.gmane.org>:
> 2017-06-01 18:52 GMT+00:00 Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>>
>>
>> On Thu, Jun 1, 2017 at 2:03 AM Jens Rosenboom <j.rosenboom-C33AMpY93qY@public.gmane.org> wrote:
>>>
>>> On a large Hammer-based cluster (> 1 Gobjects) we are seeing a small
>>> amount of objects being truncated. All of these objects are between
>>> 512kB and 4MB in size and they are not uploaded as multipart, so the
>>> first 512kB get stored into the head object and the next chunks should
>>> be in tail objects named <bucket_id>__shadow_<tag>_N, but the latter
>>> seem to go missing sometimes. The PUT operation for these objects is
>>> logged as successful (HTTP code 200), so I'm currently having two
>>> hypotheses as to what might be happening:
>>>
>>> 1. The object is received by the radosgw process, the head object is
>>> written successfully, then the write for the tail object somehow
>>> fails. So the question is whether this is possible or whether radosgw
>>> will always wait until all operations have completed successfully
>>> before returning the 200. This blog [1] at least mentions some
>>> asynchronous operations.
>>>
>>> 2. The full object is written correctly, but the tail objects are
>>> getting deleted somehow afterwards. This might happen during garbage
>>> collection if there was a collision between the tail object names for
>>> two objects, but again I'm not sure whether this is possible.
>>>
>>> So the question is whether anyone else has seen this issue, also
>>> whether it may possibly be fixed in Jewel or later.

For reference, the original issue is: http://tracker.ceph.com/issues/20107

> So I think I found out what is happening, which seems to be a pretty
> severe bug: When an object is copied, is seems like the copy is
> created with the same prefix for shadow objects. So when the copied
> object is afterwards deleted, garbage collection will delete the
> shadow object, rendering the original object truncated.

This inital idea of mine was wrong, the sharing of the shadow objects
is intentional. There is another additional bug though, that results
in shadow objects not being deleted at all anymore once an object has
been copied:

http://tracker.ceph.com/issues/20234

So this is making it even more mysterious why it sometimes can happen
that shadow objects _are_ being removed prematurely. But we are still
seing this on our production system at a rate of at least a couple of
events per day.

I'd also still like to get feedback on how best to deal with reading
these truncated objects:

> http://tracker.ceph.com/issues/20166
