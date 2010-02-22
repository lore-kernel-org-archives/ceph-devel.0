From: Sage Weil <sage@newdream.net>
Subject: Re: Scalability
Date: Mon, 22 Feb 2010 09:08:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002220901320.1117@cobra.newdream.net>
References: <c41302d21002210108g6953bd30je6ac2130bf68fbab@mail.gmail.com>
	<1471eea71002211707w261df9fp80b5d0563c2ab75d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1471eea71002211707w261df9fp80b5d0563c2ab75d@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@lists.sourceforge.net, Avishay Traeger <avishay@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Hi Avishay,

On Sun, 21 Feb 2010, Gregory Farnum wrote:
> It's been a while since we've expressly tested scalability in Ceph, 
> because doing so is pretty hard -- it takes a lot of nodes. The most 
> recent figures I'm aware of come from an early version of the code 
> (2007) and are described in Sage's thesis (available at 
> ceph.newdream.net), in which per-MDS performance drops by about 50% 
> going from a 1-node to a 128-node metadata cluster (out of 430 total 
> nodes). At this point it was servicing ~250k metadata ops/second, which 
> is enough to handle many thousands of OSDs (he says 25k in a file 
> create/write scenario with 10MB files).

The one thing I'll add here is that the MDS load balancing algorithm 
hasn't changed much since these tests a few years back.  If you were to 
try to scale the system today, I suspect the first wall you'd run into 
would be related to the MDS cluster.

The problem is trickier than it sounds.  For example, an 'optimum' 
distribution of load across a full loaded/saturated MDS cluster is a local 
performance _minimum_: any shifting load between two nodes to cause any 
imbalance will mean better cache performance on one node and poorer 
performance on the other, but the faster node will service more requests 
than the slower node loses.  Unfairness means better total system 
throughput.  This, among other things, makes it a bit difficult to find 
the right performance metrics to 'balance' when shifting load around.

In any case, as we start deploying larger clusters we'll be revisiting and 
retuning these algorithms with real workloads.

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
