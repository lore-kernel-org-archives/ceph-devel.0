From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: The cache problem of re-export NFS test
Date: Thu, 14 Apr 2011 05:30:07 -0700
Message-ID: <BANLkTincrGv4gzxsT0P+5o=h8rLqZGBN+A@mail.gmail.com>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
	<Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
	<BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40935 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab1DNMaI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 08:30:08 -0400
Received: by vxi39 with SMTP id 39so1225716vxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 05:30:07 -0700 (PDT)
In-Reply-To: <BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

I don't think 'sync' will prevent data from going into cache, it just
means that a copy has to be on stable storage/disk as well.  Whether
there's a copy in memory wont matter.

On Thu, Apr 14, 2011 at 1:52 AM, Sylar Shen <kimulaaa@gmail.com> wrote:
> Hi Sage,
> Thanks for your reply. I really appreciated.
> I tried what you suggested to set the argument "sync" in /etc/exports=
=2E
> I also checked "man 5 exports" and it showed that sync means reply to
> requests only after the changes have been committed to stable storage=
=2E
> It didn't mention that the export server won't do the cache task.
> However, after I did the experiment, I found that the memory usage of
> Ceph-client still went up to maximum value while writing the data
> which means Ceph-client did the cache task.
> So...are there other possible ways to solve my problem?
> Thanks~~
>
> Best Regards,
> Sylar Shen
>
> 2011/4/12 Sage Weil <sage@newdream.net>:
>> On Tue, 12 Apr 2011, Sylar Shen wrote:
>>> Hi developers,
>>> I know that the following question may not be relative to Ceph but
>>> this confuses me a lot.
>>> I am testing the function of re-exporting nfs by command "dd" witho=
ut
>>> using buffer.
>>> That means I would like my data to be written to Ceph DFS directly
>>> without passing by the buffer of client or nfs-client.
>>> Here is my test architecture. Hope you could understand what I am
>>> trying to express.....:p
>>> -------------------------------------------------------------------=
-----------
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0nfs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ceph protocol
>>> Client <------------>Ceph-Client <-------------------> Ceph DFS
>>> -------------------------------------------------------------------=
-----------
>>> I used the command "dd if=3D/dev/zero of=3D/mnt/ceph/test bs=3D64k
>>> count=3D10000 oflag=3Ddsync"
>>> My purpose was to write the data from the client to Ceph DFS throug=
h
>>> Ceph-client.
>>> Ceph DFS was mounted by Ceph-client using Ceph protocol and
>>> Ceph-client was mounted by client using nfs protocol.
>>> I know that my dd command with argument oflag=3Ddsync would write t=
he
>>> data to Ceph-client without using buffer on the client.
>>> But I want my Ceph-client could also just pass the data to Ceph DFS
>>> without using its buffer.
>>> So.....is there any way I can run my scenario?
>>> Or in other words, is there any method I can assure that Ceph-clien=
t
>>> won't do the buffer task itself?
>>
>> I think what you're looking for is the 'sync' option in /etc/exports=
 on
>> the ceph-client machine. =A0See 'man 5 exports'. =A0That will slow t=
hings down
>> considerably but will give you the consistency and safety you're loo=
king
>> for.
>>
>> sage
>>
>
>
>
> --
> Best Regards,
> Sylar Shen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
