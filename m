From: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 08:42:16 +0000
Message-ID: <12767ffc79394b418661e919beab0e62@R01UKEXCASM111.r01.fujitsu.local>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.142]:8640 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759094AbbLCImV convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 03:42:21 -0500
In-Reply-To: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Sage Weil (sage@newdream.net)" <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Thursday, December 03, 2015 3:13 AM
>=20
> *Also*, in this way we are unnecessary adding another smart pointer
> overhead in the Ceph IO path.
> As I communicated sometimes back (probably 2 years now :-) ) in the
> community, profiler is showing these smart pointers (shared_ptr) as o=
ne of
> the hot spot. Now, I decided to actually measure this..Here is my fin=
dings
> from a sample application and using jemalloc.
>
> 1.  First, I measured the performance difference of just creation and=
 deletion
> of various pointers..Here is the result..
>=20
> [..]
> int main()
> {
>    struct timeval start, end;
>    long secs_used,micros_used;
>     printf("##### Test conventional ptr ######\n");
>     gettimeofday(&start, NULL);

Don't use gettimeofday, because it returns current wall time, which may=
 be adjusted any second by ntpd. Use clock_gettime with CLOCK_MONOTONIC=
 or CLOCK_MONOTONIC_RAW.

>     for (uint64_t i =3D 0; i < 1000000000; i++) {
>       Foo* f =3D new Foo();
>       int xxx =3D f->xx;
>       long yyy =3D f->yy;
>       delete f;
>     }
>     gettimeofday(&end, NULL);

>     printf("start: %d secs, %d usecs\n",start.tv_sec,start.tv_usec);
>     printf("end: %d secs, %d usecs\n",end.tv_sec,end.tv_usec);
>     secs_used=3D(end.tv_sec - start.tv_sec); //avoid overflow by subt=
racting
> first
>     micros_used=3D ((secs_used*1000000) + end.tv_usec) - (start.tv_us=
ec);
>=20
>     printf("micros_used for conventional ptr: %d\n",micros_used);

You calculate *total* time which is subject to drift due to context swi=
tches, interrupts, and other stuff getting in the way. Divide that by 1=
000000000 (times you ran your loop) to get average time per loop, which=
 is way more convincing. Then, count the number of actual uses of parti=
cular thing and multiply by average times to get reliaible info whether=
 the perf gain outweighs reasons why shared_ptrs and unique_ptrs are us=
ed in the first place.

I actually redid your testing and I can confirm that creation and freei=
ng of shared_ptrs is >3x slower than simple or unique_ptrs on g++ -std=3D=
c++11 -O2:

##### Test conventional ptr ######        =20
nanoseconds used by conventional ptr: 66.33
##### Test Unique Smart ptr ######        =20
nanoseconds used by unique_ptr: 66.94     =20
##### Test Shared Smart ptr ######        =20
nanoseconds used by shared_ptr: 202.22    =20

Also, accessing data through those pointers costs basically the same.
But are we creating and destroying that many shared_ptrs for this to be=
come actual problem? We may gain performance, but at (high) cost of fig=
hting memory leaks and dangling pointers. I'm not sure if it's worth it=
 in long run.


With best regards / Pozdrawiam
Piotr Da=B3ek


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
