From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Memory Allocators and Ceph
Date: Wed, 27 May 2015 16:48:32 -0500
Message-ID: <55663BB0.7090500@redhat.com>
References: <CAANLjFpErC4xbwgJgZGWFdMaWQ1Q4otBksyRqP0jfWKnqVacog@mail.gmail.com>	<556623AB.9030804@redhat.com>
	<CAANLjFr=f=o4_2admJ9rxdxrB5XBcDy8i2mYzVtEYP_mFZb_Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFr=f=o4_2admJ9rxdxrB5XBcDy8i2mYzVtEYP_mFZb_Aw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On 05/27/2015 04:00 PM, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
>
> On Wed, May 27, 2015 at 2:06 PM, Mark Nelson  wrote:
>>> Compiling Ceph entirely with jemalloc overall had a negative
>>> performance impact. This may be due to dynamically linking to RocksDB
>>> instead of the default static linking.
>>
>>
>> Is it possible that there were any other differences?  A 30% gain turning
>> into a 30% loss with pre-loading vs compiling seems pretty crazy!
>
> I tried hard to minimize the differences by backporting the Ceph
> jemalloc feature into 0.94.1 that was used in the other testing. I did
> have to get RocksDB from master to get it to compile against jemalloc
> so there is some difference there. When preloading Ceph with jemalloc,
> parts of Ceph still used tcmalloc because it was statically linked to
> by RocksDB, so it was using both allocators during those tests.
> Programming is not my forte so it is likely that I may have botched
> something with that test.
>
> The goal of the test was to see if and where these allocators may
> help/hinder performance. It could also provide some feedback to Ceph
> devs on how to leverage one or the other or both. I don't consider
> this test to be extremely reliable as there is some variability in
> this pre-production system even though I tried to remove the
> variability to an extent.
>
> I hope others can build on this as a jumping off point and at least
> have some interesting places to look instead of having to scope out a
> large section of the space.
>
>
>> Might be worth trying to reproduce the results and grab perf data or some
>> other kind of trace data during the tests.  There's so much variability here
>> it's really tough to get an idea of why the performance swings so
>> dramatically.
>
> I'm not very familiar with the perf tools (can you use them with
> jemalloc?) and what would be useful. If you would like to tell me some
> configurations and tests you are interested in and let me know how you
> want perf to generate the data, I can see what I can do to provide
> that. Each test suite takes about 9 hours to run so it is pretty
> intensive.

perf can give you a call graph showing how much cpu time is being spent 
in different parts of the code.

Something like this during the test:

sudo perf record --call-graph dwarf -F 99 -a
sudo perf report

You may need a newish kernel/os for dwarf support to work.  There are 
probably other tools that may also give insights into what is going on.

>
> Each "sub-test" (i.e. 4K seq read) takes 5 minutes, so it is much
> easier to run selections of those if there are specific tests you are
> interested in. I'm happy to provide data, but given the time to run
> these tests if we can focus on specific areas it would provide
> data/benefits much faster.

I guess starting out I'm interested in what's happening with preloaded 
vs compiled jemalloc.  Other tests might be interesting too though!

>
>>
>> Still, excellent testing!  We definitely need more of this so we can
>> determine if jemalloc is something that would be worth switching to
>> eventually.
>>
>>
>
>
> - ----------------
> Robert LeBlanc
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v0.13.1
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJVZjCACRDmVDuy+mK58QAAsHIQAImJWLkGix2sDKCZgcME
> 0RHmelyEBtFFjIUNJvrwC0PvUKqQ/sffdtC+QLLcFYKOO2G5lrojKhCdwhXI
> OP0O1IqMcXUCBcq5yNJf8O6uzQ56Q4qCHWJmg49JRHx4gQLNK9VtGLRevL96
> JNrwhllpI5v+ewuQR/P2uD/NAXhFWDjEXLO4xHQGylOQOOVRQBlWeq+3QLqX
> 4Zz+yiY4VIdhSe/z3aQYxes12snyjF2zP2Zo/BS47KBtVbmOJ7wGBGIFy8nw
> T4r7HYapCX3sqAN/fHEvwgcunYaW4y8aZT2a3Lv0PZKz23d6zcOUBPEFJ86W
> DzZyqqmDq7QJLtUnAb1yyQj23bWntI/zoT83zWCUvPHU7odmlBvSWZ8w7ToC
> mpOYjPw5CBVvztCFM2gwnmEXdM0qtmtdv/NhfQVu5+FNhQDSlhOPMCXdM3wf
> 2JjuygdfRg4kGE6KyX4nYSZxfacsvX3SIkLnKYsdeWMNMZwGC6TvulApY61s
> sedwbe+hyFqlfGlbM+QCtW495Wr9EcfFdM/PWUDkXtfmfE20UdqAKYzIeJfC
> F8HS5sZz6GtiLb1Dbiq69hNmUUtfDEIDVssARKbMtmZ30bPdNe42grBttzDG
> 3aNc05TwFe72HMjAhtvQrkrq1C+4XZA3mpNnosiXCUJT9WeOAOJbzWQS0mUS
> Yrtb
> =+ESo
> -----END PGP SIGNATURE-----
>
