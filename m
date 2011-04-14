From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: The cache problem of re-export NFS test
Date: Thu, 14 Apr 2011 16:52:59 +0800
Message-ID: <BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
	<Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33900 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab1DNIxA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 04:53:00 -0400
Received: by bwz15 with SMTP id 15so1195935bwz.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 01:52:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,
Thanks for your reply. I really appreciated.
I tried what you suggested to set the argument "sync" in /etc/exports.
I also checked "man 5 exports" and it showed that sync means reply to
requests only after the changes have been committed to stable storage.
It didn't mention that the export server won't do the cache task.
However, after I did the experiment, I found that the memory usage of
Ceph-client still went up to maximum value while writing the data
which means Ceph-client did the cache task.
So...are there other possible ways to solve my problem?
Thanks~~

Best Regards,
Sylar Shen

2011/4/12 Sage Weil <sage@newdream.net>:
> On Tue, 12 Apr 2011, Sylar Shen wrote:
>> Hi developers,
>> I know that the following question may not be relative to Ceph but
>> this confuses me a lot.
>> I am testing the function of re-exporting nfs by command "dd" withou=
t
>> using buffer.
>> That means I would like my data to be written to Ceph DFS directly
>> without passing by the buffer of client or nfs-client.
>> Here is my test architecture. Hope you could understand what I am
>> trying to express.....:p
>> --------------------------------------------------------------------=
----------
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0    =C2=A0nfs =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ceph protocol
>> Client <------------>Ceph-Client <-------------------> Ceph DFS
>> --------------------------------------------------------------------=
----------
>> I used the command "dd if=3D/dev/zero of=3D/mnt/ceph/test bs=3D64k
>> count=3D10000 oflag=3Ddsync"
>> My purpose was to write the data from the client to Ceph DFS through
>> Ceph-client.
>> Ceph DFS was mounted by Ceph-client using Ceph protocol and
>> Ceph-client was mounted by client using nfs protocol.
>> I know that my dd command with argument oflag=3Ddsync would write th=
e
>> data to Ceph-client without using buffer on the client.
>> But I want my Ceph-client could also just pass the data to Ceph DFS
>> without using its buffer.
>> So.....is there any way I can run my scenario?
>> Or in other words, is there any method I can assure that Ceph-client
>> won't do the buffer task itself?
>
> I think what you're looking for is the 'sync' option in /etc/exports =
on
> the ceph-client machine. =C2=A0See 'man 5 exports'. =C2=A0That will s=
low things down
> considerably but will give you the consistency and safety you're look=
ing
> for.
>
> sage
>



--=20
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
