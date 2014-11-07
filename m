From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Open source SPC-1 Workload IO Pattern
Date: Fri, 07 Nov 2014 06:53:42 -0600
Message-ID: <545CC0D6.50208@redhat.com>
References: <545CA6A4.2070104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:40837 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaKGMxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 07:53:44 -0500
Received: by mail-ie0-f172.google.com with SMTP id at20so5123534iec.3
        for <ceph-devel@vger.kernel.org>; Fri, 07 Nov 2014 04:53:44 -0800 (PST)
In-Reply-To: <545CA6A4.2070104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?THVpcyBQYWLDs24=?= <lpabon@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gluster Devel <gluster-devel@gluster.org>

On 11/07/2014 05:01 AM, Luis Pab=C3=B3n wrote:
> Hi guys,
> I created a simple test program to visualize the I/O pattern of NetAp=
p=E2=80=99s
> open source spc-1 workload generator. SPC-1 is an enterprise OLTP typ=
e
> workload created by the Storage Performance Council
> (http://www.storageperformance.org/results).  Some of the results are
> published and available here:
> http://www.storageperformance.org/results/benchmark_results_spc1_acti=
ve .
>
> NetApp created an open source version of this workload and described =
it
> in their publication "A portable, open-source implementation of the
> SPC-1 workload" (
> http://www3.lrgl.uqam.ca/csdl/proceedings/iiswc/2005/9461/00/01526014=
=2Epdf )
>
> The code is available onGithub: https://github.com/lpabon/spc1 .  All=
 it
> does at the moment is capture the pattern, no real IO is generated. I
> will be working on a command line program to enable usage on real blo=
ck
> storage systems.  I may either extend fio or create a tool specifical=
ly
> tailored to the requirements needed to run this workload.

Neat!  integration with fio could be interesting.  We could then use an=
y=20
of the engines include the librbd one (I think there is some kind of=20
gluster engine as well?)

>
> On github, I have an example IO pattern for a simulation running 50 m=
il
> IOs using HRRW_V2. The simulation ran with an ASU1 (Data Store) size =
of
> 45GB, ASU2 (User Store) size of 45GB, and ASU3 (Log) size of 10GB.

Out of curiosity have you looked at how fast you can generate IOs befor=
e=20
CPU is a bottleneck?

>
> - Luis
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
