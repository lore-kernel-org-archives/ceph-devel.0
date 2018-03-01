From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: ceph mgr balancer bad distribution
Date: Thu, 1 Mar 2018 09:03:13 +0100
Message-ID: <CABZ+qqnQ+GrhRR7+9GmuzBA3STfwmtSzfMpSU2tPZWocMGHB8A@mail.gmail.com>
References: <1ac5678e-ec95-3ab6-38bf-bdb889e1cd23@profihost.ag>
 <b5d774be-a2e2-b57c-d201-b5df71868d49@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <b5d774be-a2e2-b57c-d201-b5df71868d49-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
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
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Is the score improving?

    ceph balancer eval

It should be decreasing over time as the variances drop toward zero.

You mentioned a crush optimize code at the beginning... how did that
leave your cluster? The mgr balancer assumes that the crush weight of
each OSD is equal to its size in TB.
Do you have any osd reweights? crush-compat will gradually adjust
those back to 1.0.

Cheers, Dan



On Thu, Mar 1, 2018 at 8:27 AM, Stefan Priebe - Profihost AG
<s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
> Does anybody have some more input?
>
> I keeped the balancer active for 24h now and it is rebalancing 1-3%
> every 30 minutes but the distribution is still bad.
>
> It seems to balance from left to right and than back from right to left...
>
> Greets,
> Stefan
>
> Am 28.02.2018 um 13:47 schrieb Stefan Priebe - Profihost AG:
>> Hello,
>>
>> with jewel we always used the python crush optimizer which gave us a
>> pretty good distribution fo the used space.
>>
>> Since luminous we're using the included ceph mgr balancer but the
>> distribution is far from perfect and much worse than the old method.
>>
>> Is there any way to tune the mgr balancer?
>>
>> Currently after a balance we still have:
>> 75% to 92% disk usage which is pretty unfair
>>
>> Greets,
>> Stefan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
