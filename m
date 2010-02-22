From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Scalability
Date: Sun, 21 Feb 2010 17:07:10 -0800
Message-ID: <1471eea71002211707w261df9fp80b5d0563c2ab75d@mail.gmail.com>
References: <c41302d21002210108g6953bd30je6ac2130bf68fbab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <c41302d21002210108g6953bd30je6ac2130bf68fbab@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Avishay Traeger <avishay@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Avishay:
It's been a while since we've expressly tested scalability in Ceph,
because doing so is pretty hard -- it takes a lot of nodes. The most
recent figures I'm aware of come from an early version of the code
(2007) and are described in Sage's thesis (available at
ceph.newdream.net), in which per-MDS performance drops by about 50%
going from a 1-node to a 128-node metadata cluster (out of 430 total
nodes). At this point it was servicing ~250k metadata ops/second,
which is enough to handle many thousands of OSDs (he says 25k in a
file create/write scenario with 10MB files).
But, that's with an old version of the code and was run on borrowed
machines from Lawrence Livermore. Right now the largest testing
cluster is 30 or so total machines and we haven't thoroughly tested
multi-MDS clusters in a while -- that's the focus for our next release
after a lot of MDS work.
eGenerally speaking, the system is designed to scale infinitely.
Adding MDS nodes may reduce the per-MDS performance but it keeps
improving total performance past anything we've had the ability to
test; adding OSD nodes doesn't place much (if any) additional load on
the system because once started up they only communicate with their
peers in the cluster (which in a large cluster should be rather
smaller than the whole cluster); the Paxos monitor cluster only has to
handle MDS heartbeats and sharing the cluster map with new nodes and
clients. My guess is that the Paxos cluster would be the first
impediment to growth, but I can't even begin to imagine how many MDSes
and clients you would need to have before it gets too large to
perform. If that point actually were reached it wouldn't be hard to
implement an additional layer of slaves within the cluster to
propagate data while keeping the Paxos quorum itself small.
The ratio of OSD:MDS will depend wholly on what types of workloads
you're running -- the more data throughput per file the fewer MDSes
you will need. Although if you're opening a lot of files concurrently
without O_LAZY the MDS will have to do a lot more work during file IO
(normally it doesn't do any) as it manages the client locks. I think
our current test cluster is going to switch to 3 MDS nodes (from 1),
but that's out of a desire to test the multi-MDS code rather than any
need for the extra metadata throughput.
-Greg

On Sun, Feb 21, 2010 at 1:08 AM, Avishay Traeger <avishay@gmail.com> wrote:
> Hi,
> I was wondering if there was a limit to Ceph's scalability in terms of
> number of nodes (both MDS and OSD).=A0 What is the largest cluster that h=
as
> been tested, and how well did performance scale?=A0 In addition, is there=
 a
> rule of thumb for the size of the MDS cluster vs. the size of the OSD
> cluster?
>
> Thanks,
> Avishay
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>
>

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
