From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: periodically delays when one of mons dies
Date: Fri, 23 Mar 2012 10:42:36 -0700
Message-ID: <FF841F681BD14AD597D019505C095260@dreamhost.com>
References: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
 <CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
 <63F3EB16E0CC4D6E9AC1F738A38838F0@dreamhost.com>
 <CAHULbCk90QZ7J0gc+_8V7LW9i5Amz2jxSo6QPJKx3Pp90Q4SBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43280 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab2CWRmj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 13:42:39 -0400
Received: by obbeh20 with SMTP id eh20so2572177obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Mar 2012 10:42:38 -0700 (PDT)
In-Reply-To: <CAHULbCk90QZ7J0gc+_8V7LW9i5Amz2jxSo6QPJKx3Pp90Q4SBg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Friday, March 23, 2012 at 1:57 AM, ruslan usifov wrote:
> I mean that, if throw pacemaker we organize fault tolerant monitor
> (monitor that will work all time - even in fail case), we prevent
> delays.

So the thing about this is that you can't use Pacemaker to start up dif=
ferent monitors in different places =E2=80=94 monitors are required to =
persist their state and while you can add new nodes, you can't remove o=
ld ones. (This is required for the consistency and data safety guarante=
es that the monitors have to provide.) So you could use Pacemaker to re=
start crashed monitors, and you could (maybe? I'm not very familiar wit=
h it) use it to propagate information about which monitors you want new=
 daemons to connect to, but you couldn't use it to start up new Monitor=
s in a different location when old ones crash =E2=80=94 Ceph will compl=
ain, because it has to.

This shouldn't be a big problem for you in general =E2=80=94 monitors a=
re contacted on daemon startup but every other use of them is asynchron=
ous and outside of data paths, so the only people that are really going=
 to be impacted by a down monitor are administrators, who can handle it=
!
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
