From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Problems after crash yesterday
Date: Wed, 22 Feb 2012 09:12:04 -0800
Message-ID: <406144037926269578@unknownmsgid>
References: <4F4370F9.5030807@filoo.de> <4F44BB25.10202@filoo.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33114 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2BVRMG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2012 12:12:06 -0500
Received: by iacb35 with SMTP id b35so271620iac.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 09:12:06 -0800 (PST)
In-Reply-To: <4F44BB25.10202@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sage@newdream.net" <sage@newdream.net>

On Feb 22, 2012, at 1:53 AM, "Jens Rehp=F6hler" <jens.rehpoehler@filoo.=
de> wrote:

> Some Additios: meanwhile we are at the state:
>
> 2012-02-22 10:38:49.587403    pg v1044553: 2046 pgs: 2036 active+clea=
n,
> 10 active+clean+inconsistent; 2110 GB data, 4061 GB used, 25732 GB /
> 29794 GB avail
>
> The  active+recovering+remapped+backfill disappeared auf a restart of=
 a
> cashed OSD.
>
> The OSD crashed after issuing the command "ceph pg repair 106.3".
>
> The repeating message is also there:
Hmm. These messages indicate there are requests that came in that
never got answered -- or else that the tracking code isn't quite right
(it's new functionality). What version are you running?

> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:32.182488 osd.3
> 10.10.10.8:6803/29916 302906 : [WRN] old request pg_log(0.ea epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently =
started
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:32.182500 osd.3
> 10.10.10.8:6803/29916 302907 : [WRN] old request pg_log(2.e8 epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently =
no
> flag points reached
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:33.182615 osd.3
> 10.10.10.8:6803/29916 302908 : [WRN] old request pg_log(0.ea epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently =
started
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:33.182629 osd.3
> 10.10.10.8:6803/29916 302909 : [WRN] old request pg_log(2.e8 epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently =
no
> flag points reached
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:34.182839 osd.3
> 10.10.10.8:6803/29916 302910 : [WRN] old request pg_log(0.ea epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently =
started
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:34.182853 osd.3
> 10.10.10.8:6803/29916 302911 : [WRN] old request pg_log(2.e8 epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently =
no
> flag points reached
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:35.183075 osd.3
> 10.10.10.8:6803/29916 302912 : [WRN] old request pg_log(0.ea epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently =
started
> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:35.183089 osd.3
> 10.10.10.8:6803/29916 302913 : [WRN] old request pg_log(2.e8 epoch 84=
9
> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently =
no
> flag points reached
>
> Seems to hang since our crash.
>
> At last we see some scrub error like this:
>
> 2012-02-22 10:47:35.049386 log 2012-02-22 10:47:25.310571 osd.4
> 10.10.10.10:6800/17745 34356 : [ERR] 16.4 osd.2: soid
> ce7f1004/rb.0.0.00000000001a/headmissing attr _, missing attr
And that's a problem with the xattrs. What filesystem are you using
underneath Ceph?

>
> any advice ?
>
> thanks
>
> Jens
>
>
>
> Am 21.02.2012 11:24, schrieb Jens Rehp=F6hler:
>> Hi sage,
>>
>> sorry ... we have to disturb you again.
>>
>> After the node crash (oli wrote about that) we have some problems.
>>
>> The recovery process is stuck at:
>>
>> 2012-02-21 11:20:15.948527    pg v986715: 2046 pgs: 2035 active+clea=
n,
>> 10 active+clean+inconsistent, 1 active+recovering+remapped+backfill;
>> 1988 GB data, 3823 GB used, 25970 GB / 29794 GB avail; 1/1121879
>> degraded (0.000%)
>>
>> We also see this messages every few seconds:
>>
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:05.765762 osd.3
>> 10.10.10.8:6803/29916 131581 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:05.765775 osd.3
>> 10.10.10.8:6803/29916 131582 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:06.765912 osd.3
>> 10.10.10.8:6803/29916 131583 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:06.765943 osd.3
>> 10.10.10.8:6803/29916 131584 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:07.766312 osd.3
>> 10.10.10.8:6803/29916 131585 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:07.766324 osd.3
>> 10.10.10.8:6803/29916 131586 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:08.766467 osd.3
>> 10.10.10.8:6803/29916 131587 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>>
>> Any ideas how we can get the cluster back to consistent state  ?
>>
>> Thank you !!
>>
>> Jens
>
>
> --
> mit freundlichen Gr=FCssen
>
> Jens Rehp=F6hler
>
> ---------------------------------------------------------------------=
-
> Filoo GmbH
> Moltkestr. 25a
> 33330 G=FCtersloh
> HRB4355 AG G=FCtersloh
>
> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | Dr. C.Kunz
> Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
> Hotline: 07000-3378658 (14 Ct/min) Fax: +49 5241 8673020
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
