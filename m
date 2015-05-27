From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Memory Allocators and Ceph
Date: Wed, 27 May 2015 12:12:14 -0600
Message-ID: <CAANLjFpiTqotqOTHm540jG9JNCvbZs5cfONtzTzxvBmyKi9fHg@mail.gmail.com>
References: <CAANLjFpErC4xbwgJgZGWFdMaWQ1Q4otBksyRqP0jfWKnqVacog@mail.gmail.com>
	<CACJqLyZS5pVB8ULCc7CNemtd1qRhkfz_mvOS0RRdbiHFbiQn6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CACJqLyZS5pVB8ULCc7CNemtd1qRhkfz_mvOS0RRdbiHFbiQn6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

The workload is on average, 17KB per read request and 13KB per write
request with 73% read abd 27% write. This is a web hosting workload.
- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, May 27, 2015 at 11:59 AM, Haomai Wang  wrote:
> On Thu, May 28, 2015 at 1:40 AM, Robert LeBlanc  wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> With all the talk of tcmalloc and jemalloc, I decided to do some
>> testing og the different memory allocating technologies between KVM
>> and Ceph. These tests were done a pre-production system so I've tried
>> to remove some the variance with many runs and averages. The details
>> are as follows:
>>
>> Ceph v0.94.1 (I backported a branch from master to get full jemalloc
>> support for part of the tests)
>> tcmalloc v2.4-3
>> jemalloc v3.6.0-1
>> QEMU v0.12.1.2-2 (I understand the latest version for RH6/CentOS6)
>> OSDs are only spindles with SSD journals, no SSD tiering
>>
>> The 11 Ceph nodes are:
>> CentOS 7.1
>> Linux 3.18.9
>> 1 x Intel E5-2640
>> 64 GB RAM
>> 40 Gb Intel NIC bonded with LACP using jumbo frames
>> 10 x Toshiba MG03ACA400 4 TB 7200 RPM drives
>> 2 x Intel SSDSC2BB240G4 240GB SSD
>> 1 x 32 GB SATADOM for OS
>>
>> The KVM node is:
>> CentOS 6.6
>> Linux 3.12.39
>> QEMU v0.12.1.2-2 cache mode none
>>
>> The VM is:
>> CentOS 6.6
>> Linux 2.6.32-504
>> fio v2.1.10
>>
>> On average preloading Ceph with either tcmalloc or jemalloc showed an
>> increase of performance of about 30% with most performance gains for
>> smaller I/O. Although preloading QEMU with jemalloc provided about a
>> 6% increase on a lightly loaded server, it did not add or subtract a
>> noticeable performance difference combined with Ceph using either
>> tcmalloc or jemalloc.
>>
>> Compiling Ceph entirely with jemalloc overall had a negative
>> performance impact. This may be due to dynamically linking to RocksDB
>> instead of the default static linking.
>>
>> Preloading QEMU with tcmalloc in all cases overall showed very
>> negative results, however it showed the most improvement of any tests
>> in the 1MB tests up to almost 2.5x performance of the baseline. If
>> your workload is guaranteed to be of 1MB I/O (and possibly larger),
>> then this option may be useful.
>>
>> Based on the architecture of jemalloc, it is possible that with it
>> loaded on the QEMU host may provide more benefit on servers that are
>> closer to memory capacity, but I did not test this scenario.
>>
>> Any feedback regarding this exercise is welcome.
>
> Really cool!!!
>
> It's really an important job to help us realize so such difference by
> memory allocation library.
>
> Recently I did some basic works and want to invest ceph memory
> allocation characteristic workload, I'm hesitate to do this because of
> the unknown things about improvements. Now the top cpu usage is
> consumed by memory allocation/free, and I see different io size
> workloads(and high cpu usage) will result in terrible performance for
> ceph cluster. I hope we can lower a cpu level for ceph require(for
> fast storage device backend) by solving this problem
>
> BTW, could I know the details about your workload?
>
>>
>> Data: https://docs.google.com/a/leblancnet.us/spreadsheets/d/1n12IqAOuH2wH-A7Sq5boU8kSEYg_Pl20sPmM0idjj00/edit?usp=sharing
>> Test script is multitest. The real world test is based off of the disk
>> stats of about 100 of our servers which have uptimes of many months.
>>
>> - - ----------------
>> Robert LeBlanc
>> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v0.13.1
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJVZgGRCRDmVDuy+mK58QAAM20QAJh0rR0NIQABCkMjiluP
>> f/mcIiy4MQfFd5RJ9/ZlMRDQ0KDwW7haRm58QE0S/l6ZZ3+z7MqsQOW8KHJE
>> Y75YjEdsl7zrLLcB4wNnUKJXZrPwzFReTtLbXsNB8h73tbzaLp3y9711gbNf
>> EQQujiSp5XDiOK+d+H0FVGp4AfVmFvlO5gjQMSUcUt58qN6BsnD8NbRLEvKf
>> S2WzvJjFO7g1HqWr5QssKGb+1rvze2Z2xByURU8yKVpdX59EIhfzPdgadp/n
>> AJGR2pXWGgW2CQ3ce7gN7cr32cjjWbmzpdr0djgVB5/Y1ERU8FvwNFIwFa6N
>> eFUKCohW5UjMw8CcO9CzUQtQxgKnqeHcyVe6Loamd2eZ+epIupFLI3lQF6NU
>> GSdBV/8Ale1SJuhShY6QnEJFav8nLTvNvlDF/NiBoSUMtnsl5fDTpLH3KA2w
>> o8sT2dcDEJEc9+kzUrugUBElinjOacFcINU3osYZJ0NNi4t1PDtPTUiWChvT
>> jZdpWVGVpxZ3w46csACJZxY0lP/Kd6JoSH+78q7wNivCHeHT7c3uy8KGbKA7
>> fecFaHBAsCYliX1tDN/abZFVhEvdb8AuTGqGkZ7xHj0PAUyddObYGjkStVUw
>> dGOH+nurnFZ5Qqct/gvcbxggbOTGunHLGwtALT5EAtTB1ThlfpVQImy5vKl0
>> aOER
>> =YTTi
>> -----END PGP SIGNATURE-----
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
>
> --
> Best Regards,
>
> Wheat

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVZgjYCRDmVDuy+mK58QAAZfIQAML2Z20JnZw9+sU2vnvr
oizfxb5TGuPwPNKaFYcbM3+gCmfYBFRIR87u/VWo/V/5Y1s0qLYcsZco+rmE
qj7KHGQ5FM22e2pX5dc7PqzlqIe8KP66hsRfqwGTgZkQJAIYn5O02TA8JXrh
Yrdu+4xttPFOy+WCEmlKYDsYhHJHwQ3dkeXIC0TRvMYABc+5j9W59qCa8fq7
QxSQs4HGhBYB6kRi6fX8pl0NZ675bsgEmBeJ7ZkbdKfpPycj9Py/SCIXJtEg
amVEO3ABZ89uIglUyOkCvK5Pakpx4Pd8nMfhQf2iXyfEPWHLYZ4w8i0UyJC2
880udQdghxdXm8Z9s9STD3IIHUjsC99ltfnp2zSWjnHAm+OMqxRVTmsD9z1a
6eyzNBRi55VuXMqbZpRuAnwiNGniucZLG1dTtQtTR14/56mDeJLt8gcG6rHM
Glfm7YHyB+JpU4MUSKSRSRs1qfyDigxmynniNC6G0qvQIDrL4UBL1/LMKKKd
CiBUCvK337PMbaePDDT3EZKe5YoZsbxQf/GGD4WB8BgkjF79JmHYkZarivYb
acthRIHF3Y/OzU133Tg3YXC3hVe0y42u2OmqBJzbPWytyw3FuIhR8KFBLx6O
qp2Mj6HXGLJ3LNvsYA1hAmimxsjR9AbGsMYFCnYbwPX4ZvD23gPk8lxEMBiP
VcVd
=bQPB
-----END PGP SIGNATURE-----
