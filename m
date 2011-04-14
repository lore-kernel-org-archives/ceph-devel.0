From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: The cache problem of re-export NFS test
Date: Thu, 14 Apr 2011 20:49:13 +0800
Message-ID: <BANLkTik5aTanEEeH+QphZQLhfsqxuz+zAg@mail.gmail.com>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
	<Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
	<BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
	<BANLkTincrGv4gzxsT0P+5o=h8rLqZGBN+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59140 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265Ab1DNMtO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 08:49:14 -0400
Received: by bwz15 with SMTP id 15so1338318bwz.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 05:49:13 -0700 (PDT)
In-Reply-To: <BANLkTincrGv4gzxsT0P+5o=h8rLqZGBN+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, after testing I found that "sync" will still do the cache in memor=
y.
But what I want to know  is the real speed to write data into the disks=
=2E
I know it may not be safe without using memory and the speed may go ver=
y slow.
However, that's what I am trying to find out.
Thanks~~^^

2011/4/14 Brian Chrisman <brchrisman@gmail.com>:
> I don't think 'sync' will prevent data from going into cache, it just
> means that a copy has to be on stable storage/disk as well. =C2=A0Whe=
ther
> there's a copy in memory wont matter.
>
> On Thu, Apr 14, 2011 at 1:52 AM, Sylar Shen <kimulaaa@gmail.com> wrot=
e:
>> Hi Sage,
>> Thanks for your reply. I really appreciated.
>> I tried what you suggested to set the argument "sync" in /etc/export=
s.
>> I also checked "man 5 exports" and it showed that sync means reply t=
o
>> requests only after the changes have been committed to stable storag=
e.
>> It didn't mention that the export server won't do the cache task.
>> However, after I did the experiment, I found that the memory usage o=
f
>> Ceph-client still went up to maximum value while writing the data
>> which means Ceph-client did the cache task.
>> So...are there other possible ways to solve my problem?
>> Thanks~~
>>
>> Best Regards,
>> Sylar Shen
>>
>> 2011/4/12 Sage Weil <sage@newdream.net>:
>>> On Tue, 12 Apr 2011, Sylar Shen wrote:
>>>> Hi developers,
>>>> I know that the following question may not be relative to Ceph but
>>>> this confuses me a lot.
>>>> I am testing the function of re-exporting nfs by command "dd" with=
out
>>>> using buffer.
>>>> That means I would like my data to be written to Ceph DFS directly
>>>> without passing by the buffer of client or nfs-client.
>>>> Here is my test architecture. Hope you could understand what I am
>>>> trying to express.....:p
>>>> ------------------------------------------------------------------=
------------
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0nfs =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ceph protocol
>>>> Client <------------>Ceph-Client <-------------------> Ceph DFS
>>>> ------------------------------------------------------------------=
------------
>>>> I used the command "dd if=3D/dev/zero of=3D/mnt/ceph/test bs=3D64k
>>>> count=3D10000 oflag=3Ddsync"
>>>> My purpose was to write the data from the client to Ceph DFS throu=
gh
>>>> Ceph-client.
>>>> Ceph DFS was mounted by Ceph-client using Ceph protocol and
>>>> Ceph-client was mounted by client using nfs protocol.
>>>> I know that my dd command with argument oflag=3Ddsync would write =
the
>>>> data to Ceph-client without using buffer on the client.
>>>> But I want my Ceph-client could also just pass the data to Ceph DF=
S
>>>> without using its buffer.
>>>> So.....is there any way I can run my scenario?
>>>> Or in other words, is there any method I can assure that Ceph-clie=
nt
>>>> won't do the buffer task itself?
>>>
>>> I think what you're looking for is the 'sync' option in /etc/export=
s on
>>> the ceph-client machine. =C2=A0See 'man 5 exports'. =C2=A0That will=
 slow things down
>>> considerably but will give you the consistency and safety you're lo=
oking
>>> for.
>>>
>>> sage
>>>
>>
>>
>>
>> --
>> Best Regards,
>> Sylar Shen
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>



--=20
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
