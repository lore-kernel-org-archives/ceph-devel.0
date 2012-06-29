From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Fri, 29 Jun 2012 11:07:05 -0700
Message-ID: <CAPYLRzim+GHZe88_YA=1COKqh-A4XkPmUDYYiUyFVaQ2dxCuvA@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABC15C.3030500@profihost.ag>
	<CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64434 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab2F2SHH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 14:07:07 -0400
Received: by lbbgm6 with SMTP id gm6so4960050lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 11:07:05 -0700 (PDT)
In-Reply-To: <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, May 17, 2012 at 2:27 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> Sorry this got left for so long...
>
> On Thu, May 10, 2012 at 6:23 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hi,
>>
>> the "Designing a cluster guide"
>> http://wiki.ceph.com/wiki/Designing_a_cluster is pretty good but it
>> still leaves some questions unanswered.
>>
>> It mentions for example "Fast CPU" for the mds system. What does fas=
t
>> mean? Just the speed of one core? Or is ceph designed to use multi c=
ore?
>> Is multi core or more speed important?
> Right now, it's primarily the speed of a single core. The MDS is
> highly threaded but doing most things requires grabbing a big lock.
> How fast is a qualitative rather than quantitative assessment at this
> point, though.
>
>> The Cluster Design Recommendations mentions to seperate all Daemons =
on
>> dedicated machines. Is this also for the MON useful? As they're so
>> leightweight why not running them on the OSDs?
> It depends on what your nodes look like, and what sort of cluster
> you're running. The monitors are pretty lightweight, but they will ad=
d
> *some* load. More important is their disk access patterns =97 they ha=
ve
> to do a lot of syncs. So if they're sharing a machine with some other
> daemon you want them to have an independent disk and to be running a
> new kernel&glibc so that they can use syncfs rather than sync. (The
> only distribution I know for sure does this is Ubuntu 12.04.)

I just had it pointed out to me that I rather overstated the
importance of syncfs if you were going to do this. The monitor mostly
does fsync, not sync/syncfs(), so that's not so important. What is
important is that it has highly seeky disk behavior, so you don't want
a ceph-osd and ceph-mon daemon to be sharing a disk. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
