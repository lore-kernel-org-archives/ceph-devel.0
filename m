From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: ceph mgr balancer bad distribution
Date: Thu, 1 Mar 2018 13:12:04 +0100
Message-ID: <CABZ+qq=xs5CYAXn55JEGbA4OSZayGdvbFnpwDz7AZDa0A0T2aQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <3d244da6-25c2-b6d8-d4c2-a6a28b897509-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
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

On Thu, Mar 1, 2018 at 1:08 PM, Stefan Priebe - Profihost AG
<s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
> nice thanks will try that soon.
>
> Can you tell me how to change the log lever to info for the balancer module?

debug mgr = 4/5

-- dan
