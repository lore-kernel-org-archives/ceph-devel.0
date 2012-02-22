From: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: Re: Problems after crash yesterday
Date: Wed, 22 Feb 2012 21:25:51 +0100
Message-ID: <4F454F4F.2080104@filoo.de>
References: <4F4370F9.5030807@filoo.de> <4F44BB25.10202@filoo.de> <406144037926269578@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:46048 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2BVUZy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2012 15:25:54 -0500
In-Reply-To: <406144037926269578@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sage@newdream.net" <sage@newdream.net>

Hi Gregory,


On 22.02.2012 18:12, Gregory Farnum wrote:
> On Feb 22, 2012, at 1:53 AM, "Jens Rehp=F6hler" <jens.rehpoehler@filo=
o.de> wrote:
>
>> Some Additios: meanwhile we are at the state:
>>
>> 2012-02-22 10:38:49.587403    pg v1044553: 2046 pgs: 2036 active+cle=
an,
>> 10 active+clean+inconsistent; 2110 GB data, 4061 GB used, 25732 GB /
>> 29794 GB avail
>>
>> The  active+recovering+remapped+backfill disappeared auf a restart o=
f a
>> cashed OSD.
>>
>> The OSD crashed after issuing the command "ceph pg repair 106.3".
>>
>> The repeating message is also there:
> Hmm. These messages indicate there are requests that came in that
> never got answered -- or else that the tracking code isn't quite righ=
t
> (it's new functionality). What version are you running?
We use:

root@fcmsnode0:~# ceph -v
ceph version 0.42-62-gd6de0bb
(commit:d6de0bb83bcac238b3a6a376915e06fb7129b2c8)

Kernel is 3.2.1

i accidently updated one of our OSDs to 0.42 -> So we updated the whole
cluster.

The OSD repeated to crash while issuing  "repair" command. The
inconsistent PGs
are all on the same (newly added) node.

>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:32.182488 osd.3
>> 10.10.10.8:6803/29916 302906 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:32.182500 osd.3
>> 10.10.10.8:6803/29916 302907 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:33.182615 osd.3
>> 10.10.10.8:6803/29916 302908 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:33.182629 osd.3
>> 10.10.10.8:6803/29916 302909 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:34.182839 osd.3
>> 10.10.10.8:6803/29916 302910 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:34.182853 osd.3
>> 10.10.10.8:6803/29916 302911 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:35.183075 osd.3
>> 10.10.10.8:6803/29916 302912 : [WRN] old request pg_log(0.ea epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currently=
 started
>> 2012-02-22 10:52:36.198983   log 2012-02-22 10:52:35.183089 osd.3
>> 10.10.10.8:6803/29916 302913 : [WRN] old request pg_log(2.e8 epoch 8=
49
>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currently=
 no
>> flag points reached
>>
>> Seems to hang since our crash.
>>
>> At last we see some scrub error like this:
>>
>> 2012-02-22 10:47:35.049386 log 2012-02-22 10:47:25.310571 osd.4
>> 10.10.10.10:6800/17745 34356 : [ERR] 16.4 osd.2: soid
>> ce7f1004/rb.0.0.00000000001a/headmissing attr _, missing attr
> And that's a problem with the xattrs. What filesystem are you using
> underneath Ceph?
XFS. We tried btrfs some weeks ago but we had some trouble with it und
heavy load.

The messages are repeated every 2 or 3 seconds.
>> any advice ?
>>
>> thanks
>>
>> Jens
>>
>>
>>
>> Am 21.02.2012 11:24, schrieb Jens Rehp=F6hler:
>>> Hi sage,
>>>
>>> sorry ... we have to disturb you again.
>>>
>>> After the node crash (oli wrote about that) we have some problems.
>>>
>>> The recovery process is stuck at:
>>>
>>> 2012-02-21 11:20:15.948527    pg v986715: 2046 pgs: 2035 active+cle=
an,
>>> 10 active+clean+inconsistent, 1 active+recovering+remapped+backfill=
;
>>> 1988 GB data, 3823 GB used, 25970 GB / 29794 GB avail; 1/1121879
>>> degraded (0.000%)
>>>
>>> We also see this messages every few seconds:
>>>
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:05.765762 osd.3
>>> 10.10.10.8:6803/29916 131581 : [WRN] old request pg_log(0.ea epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currentl=
y started
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:05.765775 osd.3
>>> 10.10.10.8:6803/29916 131582 : [WRN] old request pg_log(2.e8 epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currentl=
y no
>>> flag points reached
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:06.765912 osd.3
>>> 10.10.10.8:6803/29916 131583 : [WRN] old request pg_log(0.ea epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currentl=
y started
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:06.765943 osd.3
>>> 10.10.10.8:6803/29916 131584 : [WRN] old request pg_log(2.e8 epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currentl=
y no
>>> flag points reached
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:07.766312 osd.3
>>> 10.10.10.8:6803/29916 131585 : [WRN] old request pg_log(0.ea epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currentl=
y started
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:07.766324 osd.3
>>> 10.10.10.8:6803/29916 131586 : [WRN] old request pg_log(2.e8 epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774662 currentl=
y no
>>> flag points reached
>>> 2012-02-21 11:20:15.106958   log 2012-02-21 11:20:08.766467 osd.3
>>> 10.10.10.8:6803/29916 131587 : [WRN] old request pg_log(0.ea epoch =
849
>>> query_epoch 843) v2 received at 2012-02-20 17:39:41.774507 currentl=
y started
>>>
>>> Any ideas how we can get the cluster back to consistent state  ?
>>>
>>> Thank you !!
>>>
>>> Jens
>>
>> --
>> mit freundlichen Gr=FCssen
>>
>> Jens Rehp=F6hler
>>
>> --------------------------------------------------------------------=
--
>> Filoo GmbH
>> Moltkestr. 25a
>> 33330 G=FCtersloh
>> HRB4355 AG G=FCtersloh
>>
>> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | Dr. C.Kunz
>> Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
>> Hotline: 07000-3378658 (14 Ct/min) Fax: +49 5241 8673020
>>
>>


--=20
mit freundlichen Gr=FCssen

Jens Rehp=F6hler

----------------------------------------------------------------------
=46iloo GmbH
Moltkestr. 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
Hotline: 07000-3378658 (14 Ct/min) Fax: +49 5241 8673020

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
