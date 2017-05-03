From: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Intel power tuning - 30% throughput performance
	increase
Date: Thu, 4 May 2017 09:56:34 +1000
Message-ID: <CAF-wwdF-w_nBF5HN3nwMtaSxK2KM+EsdBES=HhoCa71PH8Obbg@mail.gmail.com>
References: <CA+z5Dsx1Fwkxxk=5N3u_Ox6m+VC_vW2oexWsF29ispcm+Hf8bA@mail.gmail.com>
	<CABZ+qqk-cN25u8vf-XWoTincF5M90_JjBGnedHvnfAcL8CUDwQ@mail.gmail.com>
	<CA+z5DswHcgddrbYnwDH7o+58sASO5jZA5ZK+-NQ60Rw+bPRKkA@mail.gmail.com>
	<CABZ+qq=+1SvbPhZOBCS0Be4Z=6LXsgck2AgK+o40BOU_BwDngQ@mail.gmail.com>
	<CA+z5DsydfEGGzmKT+mf7BqpkwsD5CwL0hNMTW2OXFPeJjDWSGQ@mail.gmail.com>
	<CABZ+qqmu2C4jdu50X2u38K9cb57c0=BdfKG0BhrjJfTQYOPcjg@mail.gmail.com>
	<CA+z5DszC6EmYSPpZsj3O0Neb-qMhfmUDjjXWpfkgukrqTyZa6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DszC6EmYSPpZsj3O0Neb-qMhfmUDjjXWpfkgukrqTyZa6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

+ceph-devel to get input on whether we want/need to check the value of
/dev/cpu_dma_latency (platform dependant) at startup and issue a
warning, or whether documenting this would suffice?

Any doc contribution would be welcomed.

On Wed, May 3, 2017 at 7:18 PM, Blair Bethwaite
<blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 3 May 2017 at 19:07, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
>> Whether cpu_dma_latency should be 0 or 1, I'm not sure yet. I assume
>> your 30% boost was when going from throughput-performance to
>> dma_latency=0, right? I'm trying to understand what is the incremental
>> improvement from 1 to 0.
>
> Probably minimal given that represents a state transition latency
> taking only 1us. Presumably the main issue is when the CPU can drop
> into the lower states and the compounding impact of that over time. I
> will do some simple characterisation of that over the next couple of
> weeks and report back...
>
> --
> Cheers,
> ~Blairo
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Cheers,
Brad
