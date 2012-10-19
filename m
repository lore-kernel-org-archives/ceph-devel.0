From: Gregory Farnum <greg@inktank.com>
Subject: Re: Guidelines for Calculating IOPS?
Date: Fri, 19 Oct 2012 13:46:56 -0700
Message-ID: <CAPYLRzizZim5nwKMQhw3KDQs6a5f_O5Y1SfC27K-bVHW0UwfUQ@mail.gmail.com>
References: <50816812.2040008@gammacode.com>
	<508191A0.1040509@inktank.com>
	<5081A506.3000505@gammacode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58329 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab2JSUq5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 16:46:57 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so625684iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Oct 2012 13:46:56 -0700 (PDT)
In-Reply-To: <5081A506.3000505@gammacode.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mdawson@gammacode.com>
Cc: Mark Kampe <mark.kampe@inktank.com>, ceph-devel@vger.kernel.org

On Fri, Oct 19, 2012 at 12:07 PM, Mike Dawson <mdawson@gammacode.com> w=
rote:
> I don't know if this use fits into buffered sequential IOPS or random=
 IOPS
> territory. Need to learn more about the NVR software probably.

Video cameras are almost certainly not doing synchronous writes, which
means the data would be buffered and coalesced. You need to handle
~43MB/s of writes.
(At least, if that's not the case, then either something very strange
is happening or it's shockingly poorly written software.)

> What role would putting the journal on an SSD play here?

Not a ton =97=A0journals can absorb spikes in workload but everything
still needs to get written out to the main data store as individual
ops, so your long-term IOPs and throughput are capped at what your
main storage can provide (modulo replication, of course).


>> My guess is that the IOPS may drive the number of
>> servers, and the drives per server will be the
>> capacity divided by the number of required servers.
>>
>> So how many IOPS can you get per server?
>
>
> I don't know the answer, but would love input here! Assuming I use 72=
00rpm
> drives and conservatively estimate 75 IOPS/drive. I think I need:
>
> 5250 / 75 * 3 =3D 210 drives for 3x replication
> 5250 / 75 * 2 =3D 140 drives for 2x replication
>
> Assuming that's a good starting point, then it's all about how to bri=
ng
> those drives online. Ignoring extra servers for spare capacity / fail=
ures,
> you could do:
>
> 18 12-drive servers
>  9 24-drive servers
>  6 36-drive servers
>
> Is there any reason to assume any other bounding factors like CPU, RA=
M, etc
> that would make more servers a better architecture?

Well, each OSD takes up some memory and CPU for its own processes. We
generally recommend ~1GHz of modern CPU and 1GB of RAM per process;
these are very ballpark estimates but seem to work. The memory is
usually devoted mostly to page cache (the daemon itself is generally
at ~100MB last I checked) but it can balloon under certain failure
handling scenarios.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
