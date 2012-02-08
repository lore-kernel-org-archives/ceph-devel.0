From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Disable logging for radosgw inside rados pool
Date: Wed, 8 Feb 2012 15:51:44 +0100
Message-ID: <740576855017444408@unknownmsgid>
References: <CAMwB3ThXF20wHewK_NNgSkeEyD=XhaF=gbPDa9o_j7f5gKWv_w@mail.gmail.com>
 <CAC-hyiHGbqWd9FTuckwUq8yMeO7U86tPs1ckLCsTBsNATGJ6Bw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44807 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab2BHOvq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2012 09:51:46 -0500
Received: by wics10 with SMTP id s10so413490wic.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2012 06:51:45 -0800 (PST)
In-Reply-To: <CAC-hyiHGbqWd9FTuckwUq8yMeO7U86tPs1ckLCsTBsNATGJ6Bw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Excellent, thanks.

Pozdrawiam

iSS

Dnia 8 lut 2012 o godz. 15:45 Yehuda Sadeh Weinraub
<yehuda.sadeh@dreamhost.com> napisa=B3(a):

> 2012/2/8 S=B3awomir Skowron <szibis@gmail.com>:
>> Is there any way to disable logging inside rados for radosgw.
>>
>> pool name       category                 KB      objects       clone=
s
>>   degraded      unfound           rd        rd KB           wr
>> wr KB
>> .intent-log     -                       5952           16           =
 0
>>           0           0            0            0        29288
>> 29288
>> .log            -                     356198          497           =
 0
>>           0           0            0            0      1473971
>> 1473971
>> .rgw            -                          1           10           =
 0
>>           0           0            1            0            9
>>    7
>> .rgw.buckets    -                    9756733        65589           =
 0
>>           0           0       588675   4224301428      1000737
>> 1699523842
>>
>> Disable writes to .log ??
>>
>
> You can set RGW_SHOULD_LOG parameter to 'no' in your http server
> config. Note that we may move that option soon to ceph.conf (just
> opened issue #2040).
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
