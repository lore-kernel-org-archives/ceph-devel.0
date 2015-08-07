From: Derek Su <dereksu@qnap.com>
Subject: Re: About the Ceph erasure pool with ISA plugin on Intel xeon CPU
Date: Fri, 7 Aug 2015 09:26:45 +0800
Message-ID: <CAKEOLWVtwPC4Ob5SSOCe2dxHrbVV+ncUEETD2qKYXaj=onQDvw@mail.gmail.com>
References: <CAKEOLWVxuURSgYP3FLRhHs=THuYK0Qy084hNxZAqERyAYy2J4w@mail.gmail.com>
	<55C35386.6070602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34881 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbHGB0q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 21:26:46 -0400
Received: by pabxd6 with SMTP id xd6so57183496pab.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 18:26:45 -0700 (PDT)
In-Reply-To: <55C35386.6070602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hello, Loic
the following is my steps and configurations:
(1) The 11 osd and 3 monitors were ran in the docker container on the
same host machine.
(2) Each osd had one 1T HDD.

(3)  I set the erasure coding pool profiles:
## Jerasure, reed-soloman
 $ ceph osd erasure-code-profile set reed_k4m2_A k=3D4 m=3D2
directory=3D/usr/lib64/ceph/erasure-code

## ISA, reed-soloman
ceph osd erasure-code-profile set reed_k4m2_isa_A k=3D4 m=3D2
directory=3D/usr/lib64/ceph/erasure-code plugin=3Disa
technique=3Dreed_sol_van

(4) Then, the erasure pools were created:
## Jerasure, reed-soloman
$ $ceph osd pool create reed_k4m2_A_pool 128 128 erasure reed_k4m2_A

## ISA, reed-soloman
$ ceph osd pool create reed_k4m2_isa_A_pool 128 128 erasure reed_k4m2_i=
sa_A

(5) Then, I used the rados benchmark to test the write performance
## Jerasure, reed-soloman
rados bench  -p reed_k4m2_A_pool 500 write --no-cleanup

## ISA, reed-soloman
rados bench  -p reed_k4m2_isa_A_pool write --no-cleanup

----
The results:
(1) Jerasure/Reed-Soloman
Write throughput: 136.0 MB/S, Latency: 0.471
(2) ISA/Reed-Soloman
Write throughput: 133.1 MB/S, Latency: 0.481
(3) Jerasure/cauchy_good
Write throughput: 138.3 MB/S, Latency: 0.462
(4) ISA/cauchy
Write throughput: 140.2 MB/S, Latency: 0.452

--
My CPU information:
Intel(R) Xeon(R) CPU E3-1245 v3 @ 3.40GHz

$ cat /proc/cpuinfo | grep flags
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm ida arat epb pln pts dtherm tpr_shadow vnmi
flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms
invpcid xsaveopt

Ram: 12 GiB


The results of the performance tests seem there are no differences...

Thanks, :)
Derek

2015-08-06 20:31 GMT+08:00 Loic Dachary <loic@dachary.org>:
> Hi,
>
> Could you please publish the benchmark results somewhere ? I should b=
e able to figure out why you don't see a difference.
>
> Cheers
>
> On 06/08/2015 13:25, Derek Su wrote:
>> Dear Mr. Dachary and all,
>>
>> Recently, I found your blog show the performance tests of erasure
>> pools (http://dachary.org/?p=3D3042 , http://dachary.org/?p=3D3665).
>> The results indicates the write throughput can be enhanced
>> significantly using Intel xeon CPU.
>>
>> I tried to create an erasure pool with isa plugin, reed_sol_van
>> technique, and k/m=3D4/2 on the Intel(R) Xeon(R) CPU E3-1245 v3 @
>> 3.40GHz machines.
>>
>> However, the results of the rados benchmark showed that there was no
>> any difference between the jerasure and isa plugins. It seems very
>> strange.
>>
>> Do I need to do other configurations in addition to only setting the
>> erasure profile?
>> In addition, how can I know the erasure pool is accelerated by ISA
>> plugin exactly? Is there any command I can use?
>>
>> Thanks, :)
>>
>> Derek Su.
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
