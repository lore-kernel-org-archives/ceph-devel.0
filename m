From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Re: civetweb threads
Date: Mon, 17 Nov 2014 15:46:55 +0300
Message-ID: <CAMWPydSHeJs4qj-O8WcYdqCLe7Hsx-nUWa8zYJEi7GpmvHbB3g@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
	<CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
	<CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
	<CAMc8nAXGkXgJz2uEpoTfYBr=z3p_fjLrU1XQ9onFWp0B2HkPJA@mail.gmail.com>
	<CAMWPydR2hbNCtVZrEkcVCrPF-tnV=QzkgWp6L80Vavg5R-YLpQ@mail.gmail.com>
	<CAMc8nAXhouvyvVcFHs2mARzkR6-u9TWV-wxgca_zOeSGoa59cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:47788 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaKQMq5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 07:46:57 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so2518833wgh.6
        for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 04:46:55 -0800 (PST)
In-Reply-To: <CAMc8nAXhouvyvVcFHs2mARzkR6-u9TWV-wxgca_zOeSGoa59cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 17, 2014 at 3:03 PM, pushpesh sharma <pushpesh.eck@gmail.co=
m> wrote:
> Mustafa,
>
> I am not positive about the results you posted here(200MB/s =3D=3D> 1=
200MB/s, by
> just increasing number of 'rgw_thread_pool_size'). These are results =
I
> observed on my setup:
>
> 1. Workload : 100% Read, Object_size=3D1MB, ClientWorkers: 512,
> rgw_object_chunk_size=3D 1048576, rgw_thread_pool_size=3D128
>
> General Report
>
> Op-Type    Op-Count     Byte-Count              Avg-Res  TimeAvg-Proc
> TimeThroughput   Bandwidth    Succ-Ratio
> Read         515.99 kops 515.99 GB  74.37 ms 72.2 ms 1721.04 op/s 1.7=
2 GB/S
> 99.33%
>
> ResTime (RT) Details
> Op-Type     60%-RT    80%-RT      90%-RT   95%-RT    99%-RT        10=
0%-RT
>  read          < 30 ms < 80 ms < 200 ms < 290 ms < 670 ms  < 6,530 ms
>
>
> 2.  Workload : 100% Read, Object_size=3D1MB, ClientWorkers: 512,
> rgw_object_chunk_size=3D 1048576, rgw_thread_pool_size=3D512
>
> General Report
>
> Op-Type    Op-Count         Byte-Count    Avg-Res       TimeAvg-Proc
> TimeThroughput    Bandwidth    Succ-Ratio
> read          521.21 kops 521.21 GB 294.17 ms 291.7 ms 1740.46 op/s 1=
=2E74
> GB/S 100%
>
>
> ResTime (RT) Details
> Op-Type     60%-RT     80%-RT      90%-RT      95%-RT     99%-RT
> 100%-RT
> read          < 280 ms     < 360 ms     < 450 ms   < 570 ms  <1,040 m=
s
> <3,790 ms
>
>
> You can checkout more setup details here  . It is certainly possible =
I am
> missing some other configs, please enlighten me.
>

In my case, I have a very large files (multiple gigs), I have a very
large number of connections, so I hit the "MAX_WORKER_THREADS" that is
1024 in civetweb code, so increasing the "rgw thread pool size" for me
was to increase "num_op_thread" to handle more than 1024 connection, I
could handle more than 7000 connections and I got the 1200 MB/s

In your blog, you said you used civetweb in default configuration
"=E2=80=98num_op_thread=E2=80=99, which is set to 128", but the number =
is mapped from
rgw_thread_pool_size, so when you have more clients, they will wait.

Regards
Mustafa

>
> On Sun, Nov 16, 2014 at 4:33 PM, Mustafa Muhammad
> <mustafaa.alhamdaani@gmail.com> wrote:
>> On Sun, Nov 16, 2014 at 7:57 AM, pushpesh sharma <pushpesh.eck@gmail=
=2Ecom>
>> wrote:
>>> Yehuda,
>>>
>>> I believe it would not be wise to increase the value of this
>>> parameter; till the underlying threading model of RGW is fixed.
>>> I tried with various  'rgw_thread_pool_size' (128,256,512,1024), an=
d
>>> didn't observe any better throughput , instead response time
>>> increased. Which means RGW is not able to handled increased
>>> concurrency.
>> I needed to increase this number to increase the number of concurren=
t
>> connections to civetweb, I need high number of threads (>7000
>> connections, large files)
>> I had my throughput going from 200 MB/s to 1200 MB/s (10G interface =
is
>> full, I could've gone higher)  due to increasing civetweb connection=
s.
>>
>>> I have another observation regarding 'rgw_max _chunk_size'. I was
>>> doing some experiment with this parameter. I have seen the followin=
g
>>> behavior on a test deployment and then verified on development
>>> environment :-
>>>
>>> 1. Based on the value we set for 'rgw_max_chunk_size', every Swift
>>> object gets sliced in to equal sized chunks and each chunk got crea=
ted
>>> as a RAODS Object in the pool (.rgw.buckets)
>>>
>>> 2. While reading the same Swift Object, sum of all RADOS objects
>>> provided.
>>>
>>> 3. However setting this 'rgw_max_chunk_size' value up to 4MB only
>>> works after which GET request will fail and only the first RADOS
>>> object will be returned.
>>>
>>> #######################
>>> $./ceph --admin-daemon out/client.admin.9660.asok config set
>>> rgw_max_chunk_size 4195000
>>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH **=
*
>>> { "success": "rgw_max_chunk_size =3D '4195000' "}
>>>
>>>
>>> swift -A http://localhost:8000/auth -U tester:testing -K asdf uploa=
d
>>> my4+MB_chunked ceph-0.85.tar.gz
>>> ceph-0.85.tar.gz
>>> ceph@Ubuntu14:~$ cd copy/
>>> ceph@Ubuntu14:~/copy$ swift -A http://localhost:8000/auth -U
>>> tester:testing -K asdf download my4+MB_chunked ceph-0.85.tar.gz
>>> ceph-0.85.tar.gz: md5sum !=3D etag, ea27d35584bae391e9f3e67c86849a6=
6 !=3D
>>> fd9237fa01803398bd8012c4d59975d8
>>> ceph-0.85.tar.gz [auth 0.021s, headers 0.040s, total 30.045s, 0.140=
 MB/s]
>>> ceph-0.85.tar.gz: read_length !=3D content_length, 4194304 !=3D 738=
4934
>>> ######################
>>>
>>> Is this behavior sane? Why the Swift Object is chunked  by default
>>> based on this value. Should the decision to chunk the object be com=
ing
>>> from end-user? (Like Native Swift)
>>>
>>> On Sat, Nov 15, 2014 at 9:48 PM, Yehuda Sadeh <yehuda@redhat.com> w=
rote:
>>>> On Sat, Nov 15, 2014 at 3:55 AM, Mustafa Muhammad
>>>> <mustafaa.alhamdaani@gmail.com> wrote:
>>>>> On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
>>>>> <mustafaa.alhamdaani@gmail.com> wrote:
>>>>>> Hi,
>>>>>> I am using civetweb in my radosgw, if I use "rgw thread pool siz=
e"
>>>>>> that is more than 1024, civetweb doesn't work.
>>>>>> e.g.
>>>>>> rgw thread pool size =3D 1024
>>>>>> rgw frontends =3D "civetweb port=3D80"
>>>>>>
>>>>>> #ps aux -L | grep rados | wc -l
>>>>>> 1096
>>>>>>
>>>>>> everything works fine
>>>>>>
>>>>>>
>>>>>> If I use:
>>>>>> rgw thread pool size =3D 1025
>>>>>> rgw frontends =3D "civetweb port=3D80"
>>>>>>
>>>>>> # ps aux -L | grep rados | wc -l
>>>>>> 43
>>>>>>
>>>>>> And http server is not listening.
>>>>>>
>>>>>> If I don't use civetweb:
>>>>>> rgw thread pool size =3D 10240
>>>>>>
>>>>>> # ps aux -L | grep rados | wc -l
>>>>>> 10278
>>>>>>
>>>>>> Regards
>>>>>>
>>>>>> Mustafa Muhammad
>>>>>
>>>>> I found the problem, it is hardcoded here:
>>>>> https://github.com/ceph/civetweb/blob/master/src/civetweb.c
>>>>> as:
>>>>> #define MAX_WORKER_THREADS 1024
>>>>>
>>>>> I increased it to 20480 an compiled from source, problem solved.
>>>>> I should we make a patch, right?
>>>>
>>>> Please do, preferably a github pull request. Also, if you could op=
en a
>>>> ceph tracker issue with the specific would be great.
>>>>
>>>> Thanks,
>>>> Yehuda
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> -Pushpesh
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> -Pushpesh
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
