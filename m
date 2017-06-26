From: Sage Weil <sage@newdream.net>
Subject: Re: Ideas on the UI/UX improvement of ceph-mgr: Cluster Status
 Dashboard
Date: Mon, 26 Jun 2017 14:04:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706261401240.3424@piezo.novalocal>
References: <CA+b5B0_6YibOkt4oJuPXZ1disBOAs2wYL7GRwbO4wUgyrg75-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57299 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdFZOE5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2017 10:04:57 -0400
In-Reply-To: <CA+b5B0_6YibOkt4oJuPXZ1disBOAs2wYL7GRwbO4wUgyrg75-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: saumay agrawal <saumay.agrawal@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Saumay!

On Mon, 26 Jun 2017, saumay agrawal wrote:
> Hi everyone!
> 
> I am working on the improvement of the web-based dashboard for Ceph.
> My intention is to add some UI elements to visualise some performance
> counters of a Ceph cluster. This gives a better overview to the users
> of the dashboard about how the Ceph cluster is performing and, if
> necessary, where they can make necessary optimisations to get even
> better performance from the cluster.
> 
> Here is my suggestion on the two perf counters, commit latency and
> apply latency. They are visualised using line graphs. I have prepared
> UI mockups for the same.
> 1. OSD apply latency
> [https://drive.google.com/open?id=0ByXy5gIBzlhYNS1MbTJJRDhtSG8]
> 2. OSD commit latency
> [https://drive.google.com/open?id=0ByXy5gIBzlhYNElyVU00TGtHeVU]
> 
> These mockups show the latency values (y-axis) against the instant of
> time (x-axis). The latency values for different OSDs are highlighted
> using different colours. The average latency value of all OSDs is
> shown specifically in red. This representation allows the dashboard
> user to compare the performances of an OSD with other OSDs, as well as
> with the average performance of the cluster.
> 
> The line width in these graphs is specially kept less, so as to give a
> crisp and clear representation for more number of OSDs. However, this
> approach may clutter the graph and make it incomprehensible for a
> cluster having significantly higher number of OSDs. For such
> situations, we can retain only the average latency indications from
> both the graphs to make things more simple for the dashboard user.

For the overview graphs I would operate on the assumption that all 
clusters have too many OSDs to show individual osd values.  (IMO it's not 
worth spending time special casing the small clusters.)  Instead, using a 
graph that shows grayed areas for the first few standard deviations so 
that you get a visual sense of the range of values would I think be most 
valuable.

> Also, higher latency values suggest bad performance. We can come up
> with some specific values for both the counters, above which we can
> say that the cluster is performing very bad. If the value of any of
> the OSDs exceeds this value, we can highlight entire graph in a light
> red shade to draw the attention of user towards it.
> 
> I am planning to use AJAX based templates and plugins (like
> Flotcharts) for these graphs. This would allow real-time update of the
> graphs without having any need to reload the entire dashboard page.
> 
> Another feature I propose to add is the representation of the version
> distribution of all the clients in a cluster. This can be categorised
> into distribution
> 1. on the basis of ceph version
> [https://drive.google.com/open?id=0ByXy5gIBzlhYYmw5cXF2bkdTWWM] and,
> 2. on the basis of kernel version
> [https://drive.google.com/open?id=0ByXy5gIBzlhYczFuRTBTRDcwcnc]
> 
> I have used doughnut charts instead of regular pie charts, as they
> have some whitespace at their centre. This whitespace makes the chart
> appear less cluttered, while properly indicating the appropriate
> fraction of the total value. Also, we can later add some data to
> display at this centre space when we hover over a particular slice of
> the chart.
> 
> The main purpose of this visualisation is to identify any number of
> clients left behind while updating the clients of the cluster. Suppose
> a cluster has 50 clients running ceph jewel. In the process of
> updating this cluster, 40 clients get updated to ceph luminous, while
> the other 10 clients remain behind on ceph jewel. This may occur due
> to some bug or any interruption in the update process. In such
> scenarios, the user can find which clients have not been updated and
> update them according to his needs.  It may also give a clear picture
> for troubleshooting, during any package dependency issues due to the
> kernel. The clients are represented in both, absolutes numbers as well
> as the percentage of the entire cluster, for a better overview.

I think these!  You're probaly already aware, but for others benefit there 
are two sources of data it can use for this, both of which are now exposed 
via the CLI in luminous: the daemon metadata (see new 'ceph {osd,mds,mon} 
versions' command) and the information about connected clients ('ceph 
features').

sage


> 
> An interesting approach could be highlighting the older version(s)
> specifically to grab the attention of the user. For example, a user
> running ceph jewel may not need to update as necessarily compared to
> the user running ceph hammer.
> 
> As of now, I am looking for plugins in AdminLTE to implement these two
> elements in the dashboard. I would like to have feedbacks and
> suggestions on these two from the ceph community, on how can I make
> them more informative about the cluster.
> 
> Also a request to the various ceph users and developers. It would be
> great if you could share the various metrics you are using as a
> performance indicator for your cluster, and how you are using them.
> Any metrics being used to identify the issues in a cluster can also be
> shared.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
