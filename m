From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Memory Allocators and Ceph
Date: Wed, 27 May 2015 15:06:03 -0500
Message-ID: <556623AB.9030804@redhat.com>
References: <CAANLjFpErC4xbwgJgZGWFdMaWQ1Q4otBksyRqP0jfWKnqVacog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFpErC4xbwgJgZGWFdMaWQ1Q4otBksyRqP0jfWKnqVacog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 05/27/2015 12:40 PM, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> With all the talk of tcmalloc and jemalloc, I decided to do some
> testing og the different memory allocating technologies between KVM
> and Ceph. These tests were done a pre-production system so I've tried
> to remove some the variance with many runs and averages. The details
> are as follows:
>
> Ceph v0.94.1 (I backported a branch from master to get full jemalloc
> support for part of the tests)
> tcmalloc v2.4-3
> jemalloc v3.6.0-1
> QEMU v0.12.1.2-2 (I understand the latest version for RH6/CentOS6)
> OSDs are only spindles with SSD journals, no SSD tiering
>
> The 11 Ceph nodes are:
> CentOS 7.1
> Linux 3.18.9
> 1 x Intel E5-2640
> 64 GB RAM
> 40 Gb Intel NIC bonded with LACP using jumbo frames
> 10 x Toshiba MG03ACA400 4 TB 7200 RPM drives
> 2 x Intel SSDSC2BB240G4 240GB SSD
> 1 x 32 GB SATADOM for OS
>
> The KVM node is:
> CentOS 6.6
> Linux 3.12.39
> QEMU v0.12.1.2-2 cache mode none
>
> The VM is:
> CentOS 6.6
> Linux 2.6.32-504
> fio v2.1.10
>
> On average preloading Ceph with either tcmalloc or jemalloc showed an
> increase of performance of about 30% with most performance gains for
> smaller I/O. Although preloading QEMU with jemalloc provided about a
> 6% increase on a lightly loaded server, it did not add or subtract a
> noticeable performance difference combined with Ceph using either
> tcmalloc or jemalloc.

Very interesting tests Robert!

>
> Compiling Ceph entirely with jemalloc overall had a negative
> performance impact. This may be due to dynamically linking to RocksDB
> instead of the default static linking.

Is it possible that there were any other differences?  A 30% gain 
turning into a 30% loss with pre-loading vs compiling seems pretty crazy!

>
> Preloading QEMU with tcmalloc in all cases overall showed very
> negative results, however it showed the most improvement of any tests
> in the 1MB tests up to almost 2.5x performance of the baseline. If
> your workload is guaranteed to be of 1MB I/O (and possibly larger),
> then this option may be useful.
>
> Based on the architecture of jemalloc, it is possible that with it
> loaded on the QEMU host may provide more benefit on servers that are
> closer to memory capacity, but I did not test this scenario.
>
> Any feedback regarding this exercise is welcome.

Might be worth trying to reproduce the results and grab perf data or 
some other kind of trace data during the tests.  There's so much 
variability here it's really tough to get an idea of why the performance 
swings so dramatically.

Still, excellent testing!  We definitely need more of this so we can 
determine if jemalloc is something that would be worth switching to 
eventually.

>
> Data: https://docs.google.com/a/leblancnet.us/spreadsheets/d/1n12IqAOuH2wH-A7Sq5boU8kSEYg_Pl20sPmM0idjj00/edit?usp=sharing
> Test script is multitest. The real world test is based off of the disk
> stats of about 100 of our servers which have uptimes of many months.
>
> - - ----------------
> Robert LeBlanc
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v0.13.1
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJVZgGRCRDmVDuy+mK58QAAM20QAJh0rR0NIQABCkMjiluP
> f/mcIiy4MQfFd5RJ9/ZlMRDQ0KDwW7haRm58QE0S/l6ZZ3+z7MqsQOW8KHJE
> Y75YjEdsl7zrLLcB4wNnUKJXZrPwzFReTtLbXsNB8h73tbzaLp3y9711gbNf
> EQQujiSp5XDiOK+d+H0FVGp4AfVmFvlO5gjQMSUcUt58qN6BsnD8NbRLEvKf
> S2WzvJjFO7g1HqWr5QssKGb+1rvze2Z2xByURU8yKVpdX59EIhfzPdgadp/n
> AJGR2pXWGgW2CQ3ce7gN7cr32cjjWbmzpdr0djgVB5/Y1ERU8FvwNFIwFa6N
> eFUKCohW5UjMw8CcO9CzUQtQxgKnqeHcyVe6Loamd2eZ+epIupFLI3lQF6NU
> GSdBV/8Ale1SJuhShY6QnEJFav8nLTvNvlDF/NiBoSUMtnsl5fDTpLH3KA2w
> o8sT2dcDEJEc9+kzUrugUBElinjOacFcINU3osYZJ0NNi4t1PDtPTUiWChvT
> jZdpWVGVpxZ3w46csACJZxY0lP/Kd6JoSH+78q7wNivCHeHT7c3uy8KGbKA7
> fecFaHBAsCYliX1tDN/abZFVhEvdb8AuTGqGkZ7xHj0PAUyddObYGjkStVUw
> dGOH+nurnFZ5Qqct/gvcbxggbOTGunHLGwtALT5EAtTB1ThlfpVQImy5vKl0
> aOER
> =YTTi
> -----END PGP SIGNATURE-----
>
