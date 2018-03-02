From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: ceph mgr balancer bad distribution
Date: Fri, 2 Mar 2018 21:21:10 +0100
Message-ID: <173aba9e-16ae-c9d6-3afa-2c25683b0dbe@profihost.ag>
References: <1ac5678e-ec95-3ab6-38bf-bdb889e1cd23@profihost.ag>
 <b5d774be-a2e2-b57c-d201-b5df71868d49@profihost.ag>
 <CABZ+qqnQ+GrhRR7+9GmuzBA3STfwmtSzfMpSU2tPZWocMGHB8A@mail.gmail.com>
 <da7136f6-cc57-0b28-428c-ccaaef34dfa7@profihost.ag>
 <CABZ+qqmONpy74yXqr7e_zt_24aaxcFomPrwz0Mu2ncf0gYW3Ng@mail.gmail.com>
 <3b2c1d04-c7bd-1906-6239-b783e4fd585a@profihost.ag>
 <CABZ+qqkKVsdr+Tch=ZOrpzbbSdmWo-eOdCspWxCRSTnK=buEFQ@mail.gmail.com>
 <bea62c27-0faf-1b47-ca1e-9577e98ec6b1@profihost.ag>
 <CABZ+qqnRwQa8Jrg9=DPc5VnzqG4cjq0RvdhfFG74NgLMs_4EwQ@mail.gmail.com>
 <CABZ+qqmUPsiUDQV4kkHAWN0v=fCosaaHs0dGvXDaKUGKC7v9=g@mail.gmail.com>
 <CABZ+qqm-gMs9COEg2TVfNwEhVja8mGox00=0y5wQB7Z2QoSjSQ@mail.gmail.com>
 <3d244da6-25c2-b6d8-d4c2-a6a28b897509@profihost.ag>
 <CABZ+qq=xs5CYAXn55JEGbA4OSZayGdvbFnpwDz7AZDa0A0T2aQ@mail.gmail.com>
 <88BB07AB-D6C8-4106-953F-2131E56081BD@profihost.ag>
 <CABZ+qqkdAHvkLv0q8ysDhjx+dHC_TCYrcQT9Nv_ddLt0krGzgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqkdAHvkLv0q8ysDhjx+dHC_TCYrcQT9Nv_ddLt0krGzgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spandankumarsahu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

Am 02.03.2018 um 14:29 schrieb Dan van der Ster:
> On Fri, Mar 2, 2018 at 10:12 AM, Stefan Priebe - Profihost AG
> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>> Thanks! Your patch works great!
> 
> Cool! I plan to add one more feature to allow operators to switch off
> components of the score function. Currently, by only changing the key
> to 'bytes', we aren't able to fully balance things because at some
> point the pgs score gets too suboptimal and the overall score reaches
> a min value.

OK great but it still works perfectly for my clusters. 2%-3% difference
for all OSDs.

>> The only problem I still see is that the
>> balancer kicks in even when the old optimize has not finished. It seems it
>> only evaluated the degraded of value. But while remapping it can happen that
>> none are degraded but a lot are still misplaced.
>>
>> I think the balancer should evaluate the ceph health status as well.
> 
> I guess this point is debatable. On our clusters we use max_misplaced
> = 0.01 and set the begin_hour end_hour to daytime hours so that by the
> late evening, every day, the cluster is back to HEALTH_OK.

ah OK. Is it true that the begin_time and end_time is GMT and not local
time? Can we change this as it makes configuration of monitoring systems
impossible - time changes also with summer and winter time.

Greets,
Stefan

> Cheers, Dan
> 
>> Stefan
>>
>> Excuse my typo sent from my mobile phone.
>>
>> Am 01.03.2018 um 13:12 schrieb Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>:
>>
>> On Thu, Mar 1, 2018 at 1:08 PM, Stefan Priebe - Profihost AG
>> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>>
>> nice thanks will try that soon.
>>
>>
>> Can you tell me how to change the log lever to info for the balancer module?
>>
>>
>> debug mgr = 4/5
>>
>> -- dan
