From: Sage Weil <sage@newdream.net>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Sun, 4 Dec 2011 20:47:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net>
References: <4EDC0ECF.60805@cs.ucsc.edu> <4EDC1853.5080405@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40469 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab1LEEr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Dec 2011 23:47:59 -0500
In-Reply-To: <4EDC1853.5080405@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Sun, 4 Dec 2011, Noah Watkins wrote:
> Yikes, I think this was actually the problem. nm
> 
> # ulimit -n
> 1024

I'm a little surprised the fd count got that high with a fixed size 
cluster.  Were there lots of short-lived clients?

It would be interested to see what `ls -al /proc/$pid/fd` looks like after 
the process has been running for a while...  there is probably a leak 
somewhere.

sage


> 
> -----
> 
> root@issdm-23:/var/log/ceph# grep -n  "Too many" full_conn_refused.log
> 2417924:2011-12-04 14:52:15.289873 7f1406ecb700 -- 192.168.141.123:6800/1325
> accepter no incoming connection?  sd = -1 errno 24 Too many open files
> 2417925:2011-12-04 14:52:15.289923 7f1406ecb700 -- 192.168.141.123:6800/1325
> accepter no incoming connection?  sd = -1 errno 24 Too many open files
> 2417926:2011-12-04 14:52:15.289952 7f1406ecb700 -- 192.168.141.123:6800/1325
> accepter no incoming connection?  sd = -1 errno 24 Too many open files
> 2417927:2011-12-04 14:52:15.289970 7f1406ecb700 -- 192.168.141.123:6800/1325
> accepter no incoming connection?  sd = -1 errno 24 Too many open files
> 2417928:2011-12-04 14:52:15.290002 7f1406ecb700 -- 192.168.141.123:6800/1325
> accepter no incoming connection?  sd = -1 errno 24 Too many open files
> 
> On 12/04/2011 04:22 PM, Noah Watkins wrote:
> > We are experiencing client connection problems that occur only after some
> > period of heavy use. Prior to the 'connection refused' error in the client
> > log the cluster behaves as normal. Restarting Ceph solves the problem but we
> > are not able to finish long jobs.
> > 
> > Logs attached. I have the full 1 GB MDS log if needed, and included only the
> > portition of the log in which the client had problems plus about 5 seconds
> > of context on either side of the test.
> > 
> > Thanks,
> > Noah
> > 
> > Client
> > ====
> > ...
> > 2011-12-04 16:07:58.154523 7f4458314700 -- 192.168.141.123:0/1009375 >>
> > 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).connect
> > 0
> > 2011-12-04 16:07:58.154562 7f4458314700 -- 192.168.141.123:0/1009375 >>
> > 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0
> > l=0).connecting to 192.168.141.123:6800/1325
> > 2011-12-04 16:07:58.154605 7f4458314700 -- 192.168.141.123:0/1009375 >>
> > 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).connect
> > error 192.168.141.123:6800/1325, 111: Connection refused
> > 2011-12-04 16:07:58.154620 7f4458314700 -- 192.168.141.123:0/1009375 >>
> > 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).fault
> > 111: Connection refused
> > 2011-12-04 16:07:58.154635 7f4458314700 -- 192.168.141.123:0/1009375 >>
> > 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).fault
> > waiting 3.200000
> > 
> > Full logs attached.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
