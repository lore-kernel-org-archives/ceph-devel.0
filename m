From: biyan chen <riby.chen@gmail.com>
Subject: Re: As with ceph database to store
Date: Thu, 14 Jul 2011 11:11:52 +0800
Message-ID: <CACR322iX8DWSVn2=r4MjFQRLooJv0b-RrfS0VC3AxmGTnysEbA@mail.gmail.com>
References: <CACR322gm8Zz8ZNTN+ks5GYPod131MnygEzUQtEBJEhO2uxwVDA@mail.gmail.com>
	<ivk42l$6o2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44461 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab1GNDLy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 23:11:54 -0400
Received: by ywe9 with SMTP id 9so2689865ywe.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 20:11:53 -0700 (PDT)
In-Reply-To: <ivk42l$6o2$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

Thanks a lot.
I now want to do is for each user assigned a sqlite database, and put
each database to store in ceph file system. Each of the user data in 1
G the following. The restrictions

Then countless client to update!!!!!

I will go to try..




2011/7/13 Rutger ter Borg <rutger@terborg.net>:
> On 07/13/2011 12:39 PM, biyan chen wrote:
>>
>> Hi everyone, I want to ask next ceph whether can be used as a mass
>> sqlite small database of storage?
>>
>> Ceph direct sharing as the database of storage space is whether
>> foreseeable problem?
>>
>> Thanks! I haven't made specific test!!!!! Was underway
>
>
> As it happens to be, I have been investigating the same thing in the =
past
> few days. Sqlite and rados seems to be a very natural combination. Sq=
lite's
> and rados' architecture seem to provide hooks to make it possible. Th=
ings to
> consider / look into:
>
> * where to put the "backend" split, i.e., at the btree or pager level=
, or
> just implement a rados-sqlite's vfs.
> * increase the max #pages in a DB "file" to 48 or 64 bits (otherwise =
it's
> limited to "just" 140 TB)
> * how to improve concurrency (distributed shared-memory, etc.)
> * a distributed locking service (chubby-like)
>
> Cheers,
>
> Rutger
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
