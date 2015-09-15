From: Mike Almateia <mike.almateia@gmail.com>
Subject: Re: Question about big EC pool.
Date: Tue, 15 Sep 2015 14:32:47 +0300
Message-ID: <55F801DF.9070908@gmail.com>
References: <55F44C3D.4070603@gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE44457@SACMBXIP01.sdcorp.global.sandisk.com>
 <55F4793A.8040802@gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE4473A@SACMBXIP01.sdcorp.global.sandisk.com>
 <55F5B4C6.1040606@gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE44F96@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:34409 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbIOLcu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 07:32:50 -0400
Received: by lahg1 with SMTP id g1so75770670lah.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 04:32:48 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE44F96@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

13-Sep-15 21:25, Somnath Roy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> <<inline
>
> -----Original Message-----
> From: Mike Almateia [mailto:mike.almateia@gmail.com]
> Sent: Sunday, September 13, 2015 10:39 AM
> To: Somnath Roy; ceph-devel
> Subject: Re: Question about big EC pool.
>
> 13-Sep-15 01:12, Somnath Roy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 12-Sep-15 19:34, Somnath Roy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> I don't think there is any limit from Ceph side..
>>>> We are testing with ~768 TB deployment with 4:2 EC on Flash and it=
 is working well so far..
>>>>
>>>> Thanks & Regards
>>>> Somnath
>> Thanks for answer!
>>
>> It's very interesting!
>>
>> What is hardware you use for your the test cluster?
>> [Somnath] Three 256 TB SanDisk's JBOF (IF100) and 2 heads in front o=
f that , so, total of 6 node cluster. FYI, each IF100 can support max 5=
12 TB. Heads are with 128GB  RAM and Xeon 2690 V3 dual socket on each o=
f the server.
>
> What a version of ceph you use?
> [Somnath] As of now, it's giant , but, will be moving to Hammer soon.=
=2E
>
Good, may be you write a result perfomance/benefits after migrating to=20
Hammer?

> How cluster working in degraded state? Performance degradation is hug=
e?
>
> [Somnath] That's one of the reason we are using Cauchy_good, it's per=
formance in degraded state is much better. By reducing the recovery tra=
ffic (lower values of recovery settings) , we are able to get significa=
nt performance improvement during degraded state as well...BTW, degrada=
tion will depend on how much data cluster has to recover. In our case, =
we are seeing ~8% degradation if say ~64 TB (one ceph node) is failed, =
but, ~28% if ~128TB (2 node) is down. This is for 4M reads..
>
Cool, I see now.

> I think that e5-2690 didn't enough for that flash cluster.
>
> [Somnath] In our case and specially for bigger block sizes object use=
 cases, dual socket E5-2690 should be more than sufficient. We are not =
able to saturate that in this case. For smaller block size block use ca=
ses we are almost saturating the cpus with our config though. If you ar=
e planning to use EC with RGW and considering you have object size at l=
east 256K or so, this cpu complex is good enough IMO.
>

Ok.

>
> How you have 6 node if as you say "Three 256 TB SanDisk's JBOF (IF100=
) and 2 heads in front of that", may be I not realized how IF100 workin=
g.
>
> [Somnath] It is 2 ceph nodes connected to each IF100 (you can connect=
 upto 8 servers in front). The IF100 drives are partitioned between 2 h=
ead servers. We used 3 IF100s, so, total 3 * 2 =3D 6 head nodes or 6 no=
de ceph servers. Hope that make sense now.
>

Yes, I understood it now.

Thanks for info!

--=20
Mike, yes.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
