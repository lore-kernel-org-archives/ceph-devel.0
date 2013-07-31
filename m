From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: Blueprint: Add LevelDB support to ceph cluster backend store
Date: Wed, 31 Jul 2013 14:07:45 +0800
Message-ID: <CAMm-wcJFbkpB0V_u6-SvP2q-LxGjV--PQvfW8hwn15RV+9i90g@mail.gmail.com>
References: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
	<kta8j6$51o$1@ger.gmane.org>
	<CAMm-wcJb-K_eqcKcVVTn8M7ZW_eqDjkeb-b_KhE0b7xLHQEvKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:57427 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab3GaGHq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 02:07:46 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so309053veb.37
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 23:07:45 -0700 (PDT)
In-Reply-To: <CAMm-wcJb-K_eqcKcVVTn8M7ZW_eqDjkeb-b_KhE0b7xLHQEvKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

A better format result:

1KB Block
LevelDB with Compress: 1.77MB/s
LevelDB without Compress: 1.12MB/s
Btrfs: 13.84MB/s

4KB Block
LevelDB with Compress: 5.15MB/s
LevelDB without Compress: 3.21MB/s
Btrfs: 12.96MB/s

8KB Block
LevelDB with Compress:  6.44MB/s
LevelDB without Compress: 4.57MB/s
Btrfs: 18.29MB/s

128KB Block
LevelDB with Compress:  7.64MB/s
LevelDB without Compress: 7.28MB/s
Btrfs:  95.26MB/s

1MB Block
LevelDB with Compress:  13.61MB/s
LevelDB without Compress: 13.28MB/s
Btrfs:  109.23MB/s

On 31 July 2013 14:04, =E8=A2=81=E5=86=AC <yuandong1222@gmail.com> wrot=
e:
> We have the same idea and already tested the LevelDB Performance VS
> Btrfs.  The result is negative, especially for big block IO.
>
>                                                   1KB Block     4KB
> Block    8KB Block     128KB Block    1MB Block
> LevelDB with Compress:        1.77MB/s       5.15MB/s     6.44MB/s
>     7.64MB/s        13.61MB/s
> LevelDB without Compress:   1.12MB/s       3.21MB/s     4.57MB/s
>   7.28MB/s        13.28MB/s
> Btrfs                                           13.84MB/s
> 12.96MB/s  18.29MB/s       95.26MB/s      109.23MB/s
>
> On 31 July 2013 06:54, Alex Elsayed <eternaleye@gmail.com> wrote:
>> I posted this as a comment on the blueprint, but I figured I'd say i=
t here:
>>
>> The thing I'd worry about here is that LevelDB's performance (along =
with
>> that of various other K/V stores) falls off a cliff for large values=
=2E
>>
>> Symas (who make LMDB, used by OpenLDAP) did some benchmarking that s=
hows
>> drastic performance loss with 100KB values on both read and write:
>> http://symas.com/mdb/microbench/#sec4
>>
>> It's not just disk latency, either - an SSD showed the same behavior=
:
>> http://symas.com/mdb/microbench/#sec7
>>
>> I'd recommend REALLY careful benchmarking with a variety of loads (a=
nd value
>> sizes).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com



--=20
Dong Yuan
Email:yuandong1222@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
