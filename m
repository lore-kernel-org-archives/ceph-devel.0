From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: ceph mgr balancer bad distribution
Date: Thu, 1 Mar 2018 09:42:21 +0100
Message-ID: <CABZ+qqmONpy74yXqr7e_zt_24aaxcFomPrwz0Mu2ncf0gYW3Ng@mail.gmail.com>
References: <1ac5678e-ec95-3ab6-38bf-bdb889e1cd23@profihost.ag>
 <b5d774be-a2e2-b57c-d201-b5df71868d49@profihost.ag>
 <CABZ+qqnQ+GrhRR7+9GmuzBA3STfwmtSzfMpSU2tPZWocMGHB8A@mail.gmail.com>
 <da7136f6-cc57-0b28-428c-ccaaef34dfa7@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <da7136f6-cc57-0b28-428c-ccaaef34dfa7-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
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
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spandankumarsahu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Mar 1, 2018 at 9:31 AM, Stefan Priebe - Profihost AG
<s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
> Hi,
> Am 01.03.2018 um 09:03 schrieb Dan van der Ster:
>> Is the score improving?
>>
>>     ceph balancer eval
>>
>> It should be decreasing over time as the variances drop toward zero.
>>
>> You mentioned a crush optimize code at the beginning... how did that
>> leave your cluster? The mgr balancer assumes that the crush weight of
>> each OSD is equal to its size in TB.
>> Do you have any osd reweights? crush-compat will gradually adjust
>> those back to 1.0.
>
> I reweighted them all back to their correct weight.
>
> Now the mgr balancer module says:
> mgr[balancer] Failed to find further optimization, score 0.010646
>
> But as you can see it's heavily imbalanced:
>
>
> Example:
> 49   ssd 0.84000  1.00000   864G   546G   317G 63.26 1.13  49
>
> vs:
>
> 48   ssd 0.84000  1.00000   864G   397G   467G 45.96 0.82  49
>
> 45% usage vs. 63%

Ahh... but look, the num PGs are perfectly balanced, which implies
that you have a relatively large number of empty PGs.

But regardless, this is annoying and I expect lots of operators to get
this result. (I've also observed that the num PGs is gets balanced
perfectly at the expense of the other score metrics.)

I was thinking of a patch around here [1] that lets operators add a
score weight on pgs, objects, bytes so we can balance how we like.

Spandan: you were the last to look at this function. Do you think it
can be improved as I suggested?

Cheers, Dan

[1] https://github.com/ceph/ceph/blob/luminous/src/pybind/mgr/balancer/module.py#L558
