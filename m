From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: ceph mgr balancer bad distribution
Date: Wed, 28 Feb 2018 14:59:55 +0100
Message-ID: <f8725c11-a083-2f05-dc0d-5d2a5517534e@profihost.ag>
References: <1ac5678e-ec95-3ab6-38bf-bdb889e1cd23@profihost.ag>
 <CABZ+qqmgOb459reQ2=MkhQLBho_O5AM8OA=0PuUQ1Zz=uGrMpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqmgOb459reQ2=MkhQLBho_O5AM8OA=0PuUQ1Zz=uGrMpA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Am 28.02.2018 um 13:58 schrieb Dan van der Ster:
> Hi Stefan,
> 
> Which balancer mode are you using? crush-compat scores using a mix of
> nobjects, npgs, and size. It's doing pretty well over here as long as
> you have a relatively small number of empty PGs.
>
> I believe that upmap uses nPGs only, and I haven't tested it enough
> yet to know if it actually improves things.
> 
> Also, did you only run one iteration of the balancer? It only moves up
> to 5% of objects each iteration, so it can take several to fully
> balance things.

crush-compat mode

Yes only one iteration but i set max_misplaced to 20%:
    "mgr/balancer/max_misplaced": "20.00",

> 
> -- dan
> 
> 
> On Wed, Feb 28, 2018 at 1:47 PM, Stefan Priebe - Profihost AG
> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
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
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
