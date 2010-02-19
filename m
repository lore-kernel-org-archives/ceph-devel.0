From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Re: Write operation is stuck
Date: Fri, 19 Feb 2010 16:40:12 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

Thanks for the answer.

> It looks like dmesg shows it trying to connect to the monitor at .70, but you tested .83?
Since I test several ceph versions simultaneously I could confuse the error checking at different nodes.
I'll double check this and let you know.

> It also looks like the IO is synchronous, which may have something 
> to do with your performance.  Are you mounting with -o sync or using 
> direct IO, or are multiple clients reading and writing to the same file or 
> something?
The IO is indeed synchronous. However the performance under ceph is much worse than even under nfs, which looks strange. I do not mount with -o synch. And in our experiments multiple clients read and write the same file.

Thanks,
Roman


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Tuesday, February 16, 2010 8:35 PM
To: Talyansky, Roman
Cc: ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] Write operation is stuck

On Tue, 16 Feb 2010, Talyansky, Roman wrote:

> Hi Sage,
> 
> I am trying to reproduce the hang with the latest client and servers.
> I am able to start the servers, however mount fails with input/output error 5. The dmesg listing shows the following info:
> 
> [17008.244739] ceph: loaded 0.18.0 (mon/mds/osd proto 15/30/22)
> [17015.888143] ceph: mon0 10.55.147.70:6789 connection failed
> [17025.880170] ceph: mon0 10.55.147.70:6789 connection failed
> [17035.880121] ceph: mon0 10.55.147.70:6789 connection failed
> [17045.880189] ceph: mon0 10.55.147.70:6789 connection failed
> [17055.880130] ceph: mon0 10.55.147.70:6789 connection failed
> [17065.880113] ceph: mon0 10.55.147.70:6789 connection failed
> [17075.880170] ceph: mon0 10.55.147.70:6789 connection failed
> 
> The server is reachable, as the following command output shows:
> 
> $ nc 10.55.147.83 6789
> ceph v027

It looks like dmesg shows it trying to connect to the monitor at .70, but 
you tested .83?

> I started running the experiments with ceph 0.18 using the 
> configuration, where clients and servers run on separate nodes. It turns 
> out that the performance is extremely bad. Looking at dmesg trace I see 
> ceph-related faults (the partial trace is attached to the email).

The oops in the attached trace.txt was fixed last week in the unstable 
code.  It also looks like the IO is synchronous, which may have something 
to do with your performance.  Are you mounting with -o sync or using 
direct IO, or are multiple clients reading and writing to the same file or 
something?

Thanks-
sage


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
