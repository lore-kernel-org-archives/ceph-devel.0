From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Wed, 2 Jul 2014 21:07:41 +0800
Message-ID: <CACJqLyZYpEJYUn5m5B4LCGGfszY_xPjui5q7HShQuotBkVDt4Q@mail.gmail.com>
References: <539B11C4.1010400@profihost.ag>
	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
	<53AD1411.101@profihost.ag>
	<CAPYLRzhJ_3WkWSFUAx+w+gt5PTLD7SYmSyQ-xPRZ31ahN4a1Ag@mail.gmail.com>
	<53B40292.2000108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <53B40292.2000108-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Could you give some perf counter from rbd client side? Such as op latency?

On Wed, Jul 2, 2014 at 9:01 PM, Stefan Priebe - Profihost AG
<s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
> Am 02.07.2014 00:51, schrieb Gregory Farnum:
>> On Thu, Jun 26, 2014 at 11:49 PM, Stefan Priebe - Profihost AG
>> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>>> Hi Greg,
>>>
>>> Am 26.06.2014 02:17, schrieb Gregory Farnum:
>>>> Sorry we let this drop; we've all been busy traveling and things.
>>>>
>>>> There have been a lot of changes to librados between Dumpling and
>>>> Firefly, but we have no idea what would have made it slower. Can you
>>>> provide more details about how you were running these tests?
>>>
>>> it's just a normal fio run:
>>> fio --ioengine=rbd --bs=4k --name=foo --invalidate=0
>>> --readwrite=randwrite --iodepth=32 --rbdname=fio_test2 --pool=teststor
>>> --runtime=90 --numjobs=32 --direct=1 --group
>>>
>>> Running one time with firefly libs and one time with dumpling libs.
>>> Traget is always the same pool on a firefly ceph storage.
>>
>> What's the backing cluster you're running against? What kind of CPU
>> usage do you see with both? 25k IOPS is definitely getting up there,
>> but I'd like some guidance about whether we're looking for a reduction
>> in parallelism, or an increase in per-op costs, or something else.
>
> Hi Greg,
>
> i don't have that test cluster anymore. It had to go into production
> with dumpling.
>
> So i can't tell you.
>
> Sorry.
>
> Stefan
>
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Best Regards,

Wheat
