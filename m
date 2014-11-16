From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: civetweb threads
Date: Sat, 15 Nov 2014 21:50:26 -0800
Message-ID: <CABBk=J8FdB46oU9WKHf=Gnt+mPG_85siYeu0sW1B9e02aKr3Hw@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
	<CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
	<CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
	<CAMc8nAXGkXgJz2uEpoTfYBr=z3p_fjLrU1XQ9onFWp0B2HkPJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33236 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbaKPFu3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Nov 2014 00:50:29 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so118475iec.24
        for <ceph-devel@vger.kernel.org>; Sat, 15 Nov 2014 21:50:26 -0800 (PST)
In-Reply-To: <CAMc8nAXGkXgJz2uEpoTfYBr=z3p_fjLrU1XQ9onFWp0B2HkPJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pushpesh sharma <pushpesh.eck@gmail.com>
Cc: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 15, 2014 at 8:57 PM, pushpesh sharma <pushpesh.eck@gmail.com> wrote:
> Yehuda,
>
> I believe it would not be wise to increase the value of this
> parameter; till the underlying threading model of RGW is fixed.
> I tried with various  'rgw_thread_pool_size' (128,256,512,1024), and
> didn't observe any better throughput , instead response time
> increased. Which means RGW is not able to handled increased
> concurrency.
>
> I have another observation regarding 'rgw_max _chunk_size'. I was
> doing some experiment with this parameter. I have seen the following
> behavior on a test deployment and then verified on development
> environment :-
>
> 1. Based on the value we set for 'rgw_max_chunk_size', every Swift
> object gets sliced in to equal sized chunks and each chunk got created
> as a RAODS Object in the pool (.rgw.buckets)
>
> 2. While reading the same Swift Object, sum of all RADOS objects provided.
>
> 3. However setting this 'rgw_max_chunk_size' value up to 4MB only
> works after which GET request will fail and only the first RADOS
> object will be returned.
>
> #######################
> $./ceph --admin-daemon out/client.admin.9660.asok config set
> rgw_max_chunk_size 4195000
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> { "success": "rgw_max_chunk_size = '4195000' "}
>
>
> swift -A http://localhost:8000/auth -U tester:testing -K asdf upload
> my4+MB_chunked ceph-0.85.tar.gz
> ceph-0.85.tar.gz
> ceph@Ubuntu14:~$ cd copy/
> ceph@Ubuntu14:~/copy$ swift -A http://localhost:8000/auth -U
> tester:testing -K asdf download my4+MB_chunked ceph-0.85.tar.gz
> ceph-0.85.tar.gz: md5sum != etag, ea27d35584bae391e9f3e67c86849a66 !=
> fd9237fa01803398bd8012c4d59975d8
> ceph-0.85.tar.gz [auth 0.021s, headers 0.040s, total 30.045s, 0.140 MB/s]
> ceph-0.85.tar.gz: read_length != content_length, 4194304 != 7384934
> ######################
>
> Is this behavior sane? Why the Swift Object is chunked  by default

I need to see the logs for it to maybe determine what was going on.
There's another param that limits max request size
(rgw_get_obj_max_req_size), so you probably hit this one. Note that
it's not advisable to have the chunk size too big.

> based on this value. Should the decision to chunk the object be coming
> from end-user? (Like Native Swift)

Does native swift even support striping? Not having striping or having
variable stripe sizes could have severe impact on data balancing.
Also, the gateway insures atomicity of certain operations by limiting
the object head's size.

Yehuda

>
> On Sat, Nov 15, 2014 at 9:48 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> On Sat, Nov 15, 2014 at 3:55 AM, Mustafa Muhammad
>> <mustafaa.alhamdaani@gmail.com> wrote:
>>> On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
>>> <mustafaa.alhamdaani@gmail.com> wrote:
>>>> Hi,
>>>> I am using civetweb in my radosgw, if I use "rgw thread pool size"
>>>> that is more than 1024, civetweb doesn't work.
>>>> e.g.
>>>> rgw thread pool size = 1024
>>>> rgw frontends = "civetweb port=80"
>>>>
>>>> #ps aux -L | grep rados | wc -l
>>>> 1096
>>>>
>>>> everything works fine
>>>>
>>>>
>>>> If I use:
>>>> rgw thread pool size = 1025
>>>> rgw frontends = "civetweb port=80"
>>>>
>>>> # ps aux -L | grep rados | wc -l
>>>> 43
>>>>
>>>> And http server is not listening.
>>>>
>>>> If I don't use civetweb:
>>>> rgw thread pool size = 10240
>>>>
>>>> # ps aux -L | grep rados | wc -l
>>>> 10278
>>>>
>>>> Regards
>>>>
>>>> Mustafa Muhammad
>>>
>>> I found the problem, it is hardcoded here:
>>> https://github.com/ceph/civetweb/blob/master/src/civetweb.c
>>> as:
>>> #define MAX_WORKER_THREADS 1024
>>>
>>> I increased it to 20480 an compiled from source, problem solved.
>>> I should we make a patch, right?
>>
>> Please do, preferably a github pull request. Also, if you could open a
>> ceph tracker issue with the specific would be great.
>>
>> Thanks,
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> -Pushpesh
