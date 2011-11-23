From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Wed, 23 Nov 2011 12:48:38 -0800
Message-ID: <CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
 <CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com> <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61950 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab1KWUtK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 15:49:10 -0500
Received: by ghrr1 with SMTP id r1so1819042ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 12:49:09 -0800 (PST)
In-Reply-To: <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Actually when I ls the ceph file system. it was very slow to give me
the result (There was only eight files, not tons of files). It seemed
like all the clients were competing for some resource. But the mon and
mds resource usage almost equals to zero. That's reasonable because I
only have 8 osds and several clients. So this seems quite weird.

Best,
Xiaofei

On Wed, Nov 23, 2011 at 12:07 PM, Xiaofei Du <xiaofei.du008@gmail.com> =
wrote:
> Hi Greg,
>
> I installed Ceph on 10 ec2 instances. one for mon, one for mds, and
> the other eights are osds. I used IOZONE's distributed measurement
> mode (Multiple clients that are on different nodes and creating=A0 sa=
me
> type of workload in parallel) to test the scalability of Ceph. The
> problem is with the increase of the number of clients that was doing
> writing. the aggregate write throughput didn't scale up. For example.
> when I had only one client writing data to ceph, the throughput was
> around 60 MB/s. when I had 2 clients writing to two different files t=
o
> ceph, the throughput was still around 60MB/s. Same condition with 4
> clients and 8 clients. And the Clients were all on different nodes.
> But the aggregate reading throughput did scale up, which told us that
> the data was distributed on different osds. Otherwise it wouldn't
> scale up with the number of the reading clients.
>
> So I don't know the reason why it couldn't scale up for writing. I sa=
w
> the old bugs, so I tried new versions, but it still didn't work.
>
> BTW, actually my English name is Gregory too :) That's a good name
>
> Best,
> Xiaofei
>
> On Wed, Nov 23, 2011 at 10:53 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>>
>> On Wed, Nov 23, 2011 at 10:38 AM, Xiaofei Du <xiaofei.du008@gmail.co=
m> wrote:
>> > I searched online. saw=A0Bug #538 and=A0Tasks #584=A0may related t=
o my
>> > problem. What's the status of this problem? I first used version 0=
=2E34.
>> > Then I tried a newer version which is 0.37. But the problem still
>> > exists. Is there anyone who knows this problem and how to solve th=
is?
>> > Thanks a lot. and Happy Thanksgiving
>> Can you give us more details about the problem you're seeing? We've
>> got a pile of new hardware being installed now that we will soon be
>> doing large-scale testing on so we'll run into any problems. But if
>> you're seeing scaling issues it'd be good to know something more tha=
n
>> that they're related to two old bugs...
>> :)
>> -Greg
>
>
>
> --
> Xiaofei (Gregory) Du
> Department of Computer Science
> University of California, Santa Barbara
>



--=20
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
