From: Gregory Farnum <greg@inktank.com>
Subject: Re: Hadoop DNS/topology details
Date: Tue, 19 Feb 2013 14:22:32 -0800
Message-ID: <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:38876 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934252Ab3BSWWe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 17:22:34 -0500
Received: by mail-qa0-f54.google.com with SMTP id hg5so2096247qab.6
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 14:22:33 -0800 (PST)
In-Reply-To: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Joe Buck <jbbuck@gmail.com>

On Tue, Feb 19, 2013 at 2:10 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
> Here is the information that I've found so far regarding the operatio=
n of Hadoop w.r.t. DNS/topology. There are two parts, the file system c=
lient requirements, and other consumers of topology information.
>
> -- File System Client --
>
> The relevant interface between the Hadoop VFS and its underlying file=
 system is:
>
>   FileSystem:getFileBlockLocations(File, Extent)
>
> which is expected to return a list of hosts (a 3-tuple: hostname, IP,=
 topology path) for each block that contains any part of the specified =
file extent. So, with triplication and 2 blocks, there are 2 * 3 =3D 6 =
3-tuples present.
>
>   *** Note: HDFS sorts each list of hosts based on a distance metric =
applied between the initiating file system client and each of the block=
s in the list using the HDFS cluster map. This should not affect correc=
tness, although it's possible that consumers of this list (e.g. MapRedu=
ce) may assume an ordering. ***

That is just truly annoying. Is this described anywhere in their docs?
I don't think it would be hard to sort, if we had some mechanism for
doing so (crush map nearness, presumably?), but if doing it wrong is
expensive in terms of performance we'll want some sort of contract to
code to.


> The current Ceph client can produce the same list, but does not inclu=
de hostname nor topology information. Currently reverse DNS is used to =
fill in the hostname, and defaults to a flat topology in which all host=
s are in a single topology path: "/default-rack/host".
>
> - Reverse DNS could be quite slow:
>    - 3x replication * 1 TB / 64 MB blocks =3D 49152 lookups
>    - Caching lookups could help
>
> -- Topology Information --
>
> Services that run on a Hadoop cluster (such as MapReduce) use hostnam=
e and topology information attached to each file system block to schedu=
le and aggregate work based on various policies. These services don't h=
ave direct access to the HDFS cluster map, and instead rely on a servic=
e to provide a mapping:
>
>    DNS-names/IP -> topology path mapping
>
> This can be performed using a script/utility program that will perfor=
m bulk translations, or implemented in Java.
>
> -- A Possible Approach --
>
> 1. Expand CephFS interface to return IP and hostname

Ceph doesn't store hostnames anywhere =97 it really can't do this. All
it has is IPs associated with OSD ID numbers. :) Adding hostnames
would be a monitor and map change, which we could do, but given the
issues we've had with hostnames in other contexts I'd really rather
not.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
