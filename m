From: Gregory Farnum <greg@inktank.com>
Subject: Re: reconfiguring existing hardware for ceph use
Date: Fri, 26 Oct 2012 11:40:09 -0700
Message-ID: <CAPYLRzjzOxfG4gPfrB-DxVmMs1wyTQx38e4f_ntBQc7WQeD1mg@mail.gmail.com>
References: <20121025204045.GF23127@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58825 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966020Ab2JZSkK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 14:40:10 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2409260iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 11:40:09 -0700 (PDT)
In-Reply-To: <20121025204045.GF23127@csail.mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Proulx <jon@csail.mit.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, Oct 25, 2012 at 1:40 PM, Jonathan Proulx <jon@csail.mit.edu> wr=
ote:
> Hi All,
>
> I have 8 servers available to test ceph on which are a bit over
> powered/under-disked and I'm trying to develop a plan for how to lay
> out services and how to populate the available disk slots.
>
> The hardware is dual socket Intel E5640 chips (8 core total/ node) wi=
th 48G
> RAM, dual 10G ethernet but only four 3.5" SAS slots (with Fusion-MPT
> controller).
>
> Target application is primarily RBD as volume storage backend for
> openstack (folsom cinder), and possibly using as object store for
> glance.  I'd also like to test CephFS, but don't have a particular
> usecase in mind for it.
>
> The openstack cloud this would back end is used for reasearch
> computing by a variety of internal research groups and has wildly
> unpredictable work loads.  Volume storage use has not been
> particularly intensive to date so I don't have a particular
> performance point to hit.
>
> Comparatively the current back end is a single cinder-volume server
> bpacing volumes on two software raid6 volumes each backed by 12 2T
> nearline SAS drives.  Another option we're evaluating is a Dell
> EqualLogic san with a mirrored pair of 16x1T drive raid6 units.
>
> My first though is to populate the test systesm with a single solid
> state drive (not sure size or type) to hold the operating system and
> journals and three 3T SAS drives of the OSD data filesystems.  Runnin=
g
> 3 osd on all nodes (one per data disk), with mon and mds only on the
> first 3.

That should be fairly balanced =97=A0most modern SSDs can handle (more
than) three streams and 300-500 MB/s, which is roughly what an SAS
drive can handle in streaming writes. Presumably your OS won't
actually be doing much access to disk once booted.

> My second though is to use 3T drives in all slots.  Take the os cut
> off the top of each (probably 16G each assmbled as software raid10 fo=
r
> 32G or mirrored space) and run 4 osd per node on the remaining disk
> space using internal journals.

Whereas this of course provides more space. I'm not so sure that you'd
want to take a cut out of each OSD though =97 probably just taking it
out of one OSD and weighting that one lower than the others would make
more sense. Then placing the journals as either a file or partition on
each OSD's disk. This should localize the expense of seeks a bit more,
which I intuitively suspect will produce better results. But somebody
with a more data-driven intuition than mine might disagree?

> Is either more sane than the other? Are both so crazy I should just u=
se
> an os disk and three osd disks with internal journals? have any bette=
r
> suggestions?

Basically you want to consider whether you need more storage or better
bandwidth and burst IOPs. Since OSDs use journaling for all writes,
then (*hands waving wildly*) your burst random IOPs can often be two
or three times what you'll actually get out of the backing disks
alone, which can be quite useful for some applications.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
