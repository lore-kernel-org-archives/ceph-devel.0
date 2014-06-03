From: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [Annonce]The progress of KeyValueStore in Firely
Date: Tue, 03 Jun 2014 21:34:57 +0200
Message-ID: <538E2361.2040400@bisect.de>
References: <CACJqLybuA48Jnz6Qwc7cs2kHJO30C4GwazXi8yGp8ZhvfFc2ZQ@mail.gmail.com>	<531123F6.5070007@bisect.de>	<CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A@mail.gmail.com>	<CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q@mail.gmail.com>	<CACJqLyY=BBKKdwOsEoDbo8OfD+o2B2XoSEtmnQ8=nNCm4EaADQ@mail.gmail.com>
	<CAOj3taONVV8rMAgu8Cen=eCZ2ycYjSs8u3nfKiJUptdb7ffyEA@mail.gmail.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOj3taONVV8rMAgu8Cen=eCZ2ycYjSs8u3nfKiJUptdb7ffyEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Am 03.06.2014 20:55, schrieb Sushma R:
> Haomai,
> 
> I'm using the latest ceph master branch.
> 
> ceph_smalliobench is a Ceph internal benchmarking tool similar to rados
> bench and the performance is more or less similar to that reported by fio.
> 
> I tried to use fio with rbd ioengine (
> http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html)
> and below are the numbers with different workloads on our setup.
> Note : fio rbd engine segfaults with randread IO pattern, only with LevelDB
> (no issues with FileStore). With FileStore, performance of
> ceph_smalliobench and fio-rbd is similar for READs, so the numbers for
> randread for LevelDB are with ceph_smalliobench (since fio rbd segfaults).

Could you send me a backtrace of the segfault and some info about the
ceph and fio version you used so that I can take a look at it?

Thanks,

Danny
