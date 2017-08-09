From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: Prometheus: associating disk+nic metrics with OSDs
Date: Wed, 9 Aug 2017 16:25:52 +0200
Message-ID: <20170809142552.utikzk6acqx455zt@jf_suse_laptop>
References: <CALe9h7dNvBQ5F7=ie-GM-6kTG2+thX1rJdNd8V+gJYk1F0CipQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:42365 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdHIOZ7 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 9 Aug 2017 10:25:59 -0400
Content-Disposition: inline
In-Reply-To: <CALe9h7dNvBQ5F7=ie-GM-6kTG2+thX1rJdNd8V+gJYk1F0CipQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Paul Cuzner <pcuzner@redhat.com>

On Wed, Aug 09, 2017 at 03:10:12PM +0100, John Spray wrote:
>Hi folks,
>
>So after much poking around with rules etc, I think I've realised how
>one is meant to do this kind of thing.
>
>Prometheus queries have a powerful join-like capability, that can be
>used for things like selecting instances running a particular version
>of software, without putting the version as a label on everything you
>want to filter:
>https://www.robustperception.io/exposing-the-software-version-to-prometheus/
>
>We can use that to establish a connection between disks and OSDs by
>emitting special metrics like this:
>ceph_disk_occupation{instance="mynode456", device="sdc",osd="123"}
>
>Then someone writing a dashboard can get the metrics for the disk for
>a known OSD ID with a query like this:
>node_disk_bytes_written and on (device,instance) ceph_disk_occupation{osd="123"}
>
>One can also conveniently a metric for all disks that are in use by
>any Ceph OSD (but not all disks in the system), by leaving off the
>osd=123 part.  I think we can also add rack= labels (or arbitrary
>crush ancestry) to these nodes, so that a UI can query their
>disk/network stats by crush hierarchy.
>
>There is a constraint that we need the instance= labels to match up
>between the metrics describing the OSD disk/nic usage, and the metrics
>that come from node_exporter.  By default the instance labels are the
>IP/host:port of an exporter, so one has to override them in the
>prometheus config to be just the hostname.  That seems to be something
>that some people do anyway to have cleaner instance labels in UIs.
>
>I'm going to extend the ceph-mgr prometheus module to emit these
>metrics -- to do the same trick for network cards as for disks, we
>need the OSDs to tell us their interface names, so I have a PR for
>doing that: https://github.com/ceph/ceph/pull/16941
Great, I was actually looking if and how this was already possible. I've started 
work on the prometheus plugin too: https://github.com/jan--f/ceph/tree/wip-mgr-prometheus-health
I wasn't quite sure how much of the crush labels to include and was going to go 
with the device_class for now (not committed yet). Happy to add other crush 
labels too.
>
>Cheers,
>John
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
