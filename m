From: huang jun <hjwsm1989@gmail.com>
Subject: Re: bad CRC in data error on ARM
Date: Mon, 18 May 2015 09:20:26 +0800
Message-ID: <CABAwU-ZKRh1O_JoT7Hme5322+BFy8m285Y_1HS-DwZ8_=rQ89A@mail.gmail.com>
References: <CABAwU-Y8-fV6cFza0oHt8yJ4+-nYs51b0rQ5qDqQCfpJUk2kvw@mail.gmail.com>
	<CAPvkgC1OeQBKq+m42qccKkQHz1rLuGHt29rLJwVQrP=5V92DKw@mail.gmail.com>
	<CABAwU-YpoDsx50f2FieLyMX0Fqf3_nyPiayNxEdm6u6q5fF1Yg@mail.gmail.com>
	<CACJqLyZ6+VEw597JRgsjeWntYVOiEWLGNmXc2F5wEbwzOVZCjA@mail.gmail.com>
	<CABAwU-az+xyq856FJfe7kP1tgohO9K+6M9VZ0KPifvxBDpyhWg@mail.gmail.com>
	<CABAwU-bx4k+fgszjW4XOh9jGiHdi1=M_go1qzPKYEBfC7Kh7cA@mail.gmail.com>
	<CACJqLybs5XNBoNHvsr6GcA_xa195oH6zeJKt3tadVcU4rEz5ZA@mail.gmail.com>
	<CABAwU-adREPUjQ=om+59dYLOtfwNmfs0s=jhSkzbadYihLgmYQ@mail.gmail.com>
	<CACJqLybDwRP5KqDrcmbg6PbYiG-dYOaZs3TNL7xyiOxhuWnX9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:33786 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbERBU2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 May 2015 21:20:28 -0400
Received: by lagr1 with SMTP id r1so115464353lag.0
        for <ceph-devel@vger.kernel.org>; Sun, 17 May 2015 18:20:26 -0700 (PDT)
In-Reply-To: <CACJqLybDwRP5KqDrcmbg6PbYiG-dYOaZs3TNL7xyiOxhuWnX9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Steve Capper <steve.capper@linaro.org>, ceph-devel <ceph-devel@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@linaro.org>

hi,haomai
I have tested it again, use "dd if=/dev/zero of=/mnt/test bs=4M
count=1000" on our X86 cluster, and we confirmed that, all
4194304 bytes object's data_crc is 0 both in client and OSD side.
Note that we use /dev/zero to generate data bytes.

2015-05-16 22:07 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
> Maybe I'm missing something, but from your osd.log:
>
> 2015-05-13 08:12:50.050234 7f378d8d8700  0 bad crc in data 0 != exp 3036014994
>
> osd side compute the crc value from data is "0", it shouldn't happen
> if we have any data bytes.
>
> On Sat, May 16, 2015 at 7:34 PM, huang jun <hjwsm1989@gmail.com> wrote:
>> we think is the client send the wrong crc value.
>> we print data on OSD side, it seems ok, no data changed, but the
>> calculated crc not equals the one passed from client.
>>
>>
>> 2015-05-16 19:25 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
>>> On Sat, May 16, 2015 at 6:54 PM, huang jun <hjwsm1989@gmail.com> wrote:
>>>> <<Even if from /dev/zero, the data crc shouldn't be 0.
>>>> we print all 4M object's data crc, it seems all 0 until now.
>>>> <<I guess osd(arm) doesn't do crc computing. But from code, crc for arm
>>>> <<should be fine
>>>> When decode a message, it will check the fron_crc, middle_crc and also data_crc,
>>>> so not OSD but MON and MDS will do crc computing, and the OSD side
>>>> compute the CRC value is 0, which is different with the data_crc in
>>>> message footer.data_crc.
>>>
>>> I'm not following your meaning. The core problem is osd computes a
>>> wrong crc value?
>>>
>>>>
>>>> 2015-05-16 18:21 GMT+08:00 huang jun <hjwsm1989@gmail.com>:
>>>>> that always happen, every test have such errors. And our cluster and
>>>>> client that  running on X86 works fine, never seen bad crc error.
>>>>>
>>>>>
>>>>> 2015-05-16 17:30 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
>>>>>> is this always happen or occasionally?
>>>>>>
>>>>>> On Sat, May 16, 2015 at 10:10 AM, huang jun <hjwsm1989@gmail.com> wrote:
>>>>>>> hi,steve
>>>>>>>
>>>>>>> 2015-05-15 16:36 GMT+08:00 Steve Capper <steve.capper@linaro.org>:
>>>>>>>> On 15 May 2015 at 00:51, huang jun <hjwsm1989@gmail.com> wrote:
>>>>>>>>> hi,all
>>>>>>>>
>>>>>>>> Hi HuangJun,
>>>>>>>>
>>>>>>>>>
>>>>>>>>> We run ceph cluster on ARM platform (arm64, linux kernel 3.14, OS
>>>>>>>>> ubuntu 14.10), and use "dd if=/dev/zero of=/mnt/test bs=4M count=125"
>>>>>>>>> to write data.  On the osd side, we got bad data CRC error.
>>>>>>>>>
>>>>>>>>> The kclient log: (tid=6)
>>>>>>>>> May 14 17:21:08 node103 kernel: [  180.194312] CPU[0] libceph:
>>>>>>>>> send_request ffffffc8d252f000 tid-6 to osd0 flags 36 pg 1.9aae829f req
>>>>>>>>> data size is 4194304
>>>>>>>>> May 14 17:21:08 node103 kernel: [  180.194316] CPU[0] libceph: tid-6
>>>>>>>>> ----- ffffffc0702f66c8 to osd0 42=osd_op len 197+0+4194304 -----
>>>>>>>>> libceph: tid-6 front_crc is 388648745 middle_crc is 0 data_crc is 3036014994
>>>>>>>>>
>>>>>>>>> The OSD-0 log:
>>>>>>>>> 2015-05-13 08:12:50.049345 7f378d8d8700  0 seq  3 tid 6 front_len 197
>>>>>>>>> mid_len 0 data_len 4194304
>>>>>>>>> 2015-05-13 08:12:50.049348 7f378d8d8700  0 crc in front 388648745 exp 388648745
>>>>>>>>> 2015-05-13 08:12:50.049395 7f378d8d8700  0 crc in middle 0 exp 0
>>>>>>>>> 2015-05-13 08:12:50.049964 7f378d8d8700  0 crc in data 0 exp 3036014994
>>>>>>>>> 2015-05-13 08:12:50.050234 7f378d8d8700  0 bad crc in data 0 != exp 3036014994
>>>>>>>>>
>>>>>>>>> some considerations:
>>>>>>>>> 1) we use ceph 0.80.7 realse version and compile it on ARM, did this
>>>>>>>>> works? or  does ceph's code has ARM branch?
>>>>>>>>
>>>>>>>> We did run a Ceph version close to that for 64-bit ARM, I'm checking
>>>>>>>> out 0.80.7 now to test.
>>>>>>>> In v9.0.0, there is some code to use the ARM optional crc32c
>>>>>>>> instructions, but this isn't in 0.80.7.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2) as we have write 125 objects, only few of them report CRC error,
>>>>>>>>> and the right object's data_crc is 0 both on osd and kclient. the
>>>>>>>>> wrong object's data_crc is not 0 on kclient, but osd calculate result
>>>>>>>>> 0. the object data came from /dev/zero, i think the data_crc should be
>>>>>>>>> 0, am i right?
>>>>>>>>>
>>>>>>>>
>>>>>>>> If the initial CRC seed value is non-zero, then the CRC of a buffer
>>>>>>>> full of zeros won't be zero.
>>>>>>>> So ceph_crc32c(somethingnonzero, zerofilledbuffer, len), will be non-zero.
>>>>>>>>
>>>>>>>> I would like to reproduce this problem here.
>>>>>>>> What steps did you take before this error occurred?
>>>>>>>> Is this a cephfs filesystem or something on top of an RBD image?
>>>>>>>> Which kernel are you running? Is it the one that comes with Ubuntu?
>>>>>>>> (If so which package version is it?)
>>>>>>>>
>>>>>>> We use linux kernel version 3.14 and we just tested it on Ubuntu, and
>>>>>>> ceph version v0.80.7. Both cephfs and RBD image have CRC problems.
>>>>>>> I'm not sure whether it's related to Memory, since we tested many
>>>>>>> times, but just a few reported CRC error.
>>>>>>> As i mentioned, i doubt the memory fault changed the data, because we
>>>>>>> write 125 objects, and the all data_crc is 0 except the Bad CRC
>>>>>>> object's data_crc. Any tips are welcome.
>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> --
>>>>>>>> Steve
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> thanks
>>>>>>> huangjun
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Best Regards,
>>>>>>
>>>>>> Wheat
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> thanks
>>>>> huangjun
>>>>
>>>>
>>>>
>>>> --
>>>> thanks
>>>> huangjun
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>>
>>
>>
>> --
>> thanks
>> huangjun
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
thanks
huangjun
