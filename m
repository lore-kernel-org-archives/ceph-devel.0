From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Wed, 23 Nov 2011 13:04:40 -0800
Message-ID: <CAF3hT9AHSHf5Gd+9_AydBDWj2if01iNLjmQ5_PXLPna_-GwXQg@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
	<CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
	<CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
	<CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60149 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1KWVEl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 16:04:41 -0500
Received: by iage36 with SMTP id e36so2107341iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 13:04:40 -0800 (PST)
In-Reply-To: <CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaofei Du <xiaofei.du008@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Nov 23, 2011 at 12:07 PM, Xiaofei Du <xiaofei.du008@gmail.com> =
wrote:
> Hi Greg,>> I installed Ceph on 10 ec2 instances. one for mon, one for=
 mds, and> the other eights are osds. I used IOZONE's distributed measu=
rement> mode (Multiple clients that are on different nodes and creating=
 =A0same> type of workload in parallel) to test the scalability of Ceph=
=2E The> problem is with the increase of the number of clients that was=
 doing> writing. the aggregate write throughput didn't scale up. For ex=
ample.> when I had only one client writing data to ceph, the throughput=
 was> around 60 MB/s. when I had 2 clients writing to two different fil=
es to> ceph, the throughput was still around 60MB/s. Same condition wit=
h 4> clients and 8 clients. And the Clients were all on different nodes=
=2E> But the aggregate reading throughput did scale up, which told us t=
hat> the data was distributed on different osds. Otherwise it wouldn't>=
 scale up with the number of the reading clients.
I just want to make sure: each client is writing to a different file?

My first question is if you're sure that your EC2 cluster actually
provides more bandwidth than you're getting! We haven't tried Ceph on
EC2 but I've heard elsewhere that the disk IO rates are pretty
atrocious. (Don't forget to account for replication =97=A0that 60MB is
actually 120MB of data going to disk, and 15MB/s per disk isn't out of
the realm of possibility in many cloud setups.)
If you don't have your own tools for measuring this, you can use the
built-in one described at
http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance:
Watch the monitor output with ceph -w, then in a different window run:
ceph osd tell \* bench
Each OSD will write 1GB of data to disk and report it back (you'll see
it in the monitor output). Make sure those numbers are significantly
higher than the bandwidth you're seeing!

There are a number of other problems you could be running into, but
actual disk IO limits (or possibly network troubles) is my suspicion
since we generally see that one client can push 100+MB/s of data. :)
On Wed, Nov 23, 2011 at 12:48 PM, Xiaofei Du <xiaofei.du008@gmail.com> =
wrote:
> Actually when I ls the ceph file system. it was very slow to give me
> the result (There was only eight files, not tons of files). It seemed
> like all the clients were competing for some resource. But the mon an=
d
> mds resource usage almost equals to zero. That's reasonable because I
> only have 8 osds and several clients. So this seems quite weird.
Well, ls is a slower operation on Ceph than many systems due to the
way it handles client capabilities. But this issue will be separate
from the one you're seeing above.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
