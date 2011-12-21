From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how many MDS active daemons to run
Date: Tue, 20 Dec 2011 16:10:51 -0800
Message-ID: <CAF3hT9A1XEeZinwjFscouDkS4Pf2hT6RKQHP9B3bSy2=uQiOLQ@mail.gmail.com>
References: <4EF11A83.2030006@genome.wustl.edu>
	<CAF3hT9B0jq0adbT2hy6TjFyzs9TcRfVapnXEV0OAjrnby553zg@mail.gmail.com>
	<4EF120A5.2010100@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43614 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab1LUAKw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 19:10:52 -0500
Received: by iaeh11 with SMTP id h11so10974799iae.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 16:10:52 -0800 (PST)
In-Reply-To: <4EF120A5.2010100@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, Dec 20, 2011 at 3:56 PM, Matt Weil <mweil@genome.wustl.edu> wro=
te:
> On 12/20/11 5:39 PM, Gregory Farnum wrote:
>>
>> On Tue, Dec 20, 2011 at 3:30 PM, Matt Weil<mweil@genome.wustl.edu> =A0=
wrote:
>>>
>>> Hello all:
>>>
>>> given six osd servers does it make any difference of each one also =
runs a
>>> mds or not?
>>>
>>> How many mds's is to many. =A0How does this effect metadata perform=
ance.
>>
>> Right now a single-MDS system is significantly more stable than a
>> system with multiple active MDSes, so if possible you should use tha=
t
>> configuration. Only add MDSes when you need more metadata throughput
>> (probably you only need one).
>
>
> Thanks for the response.
>
> these osd servers are also going run the client and serve out NFS.
Make sure you carefully consider the deadlock risks associated with
running filesystem clients and servers on the same machine... :) (See
here:http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/4335
and the containing thread for more info if needed.)

> Is it better to split the mds and mon out to a dedicated system? =A0t=
hen run
> standby on the active osd's
Depends on your hardware and performance requirements =97 the MDS will
consume as much RAM as you allow it to, and up to a CPU or so. The
OSDs don't use much memory, but the more that's available to page
cache the less they need to hit disk to serve reads, etc.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
