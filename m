From: Sage Weil <sage@newdream.net>
Subject: Re: how can i disable replication
Date: Wed, 10 Mar 2010 08:39:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003100839050.5681@cobra.newdream.net>
References: <courier.4B97B8B6.000065A0@red.servers.aueb.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <courier.4B97B8B6.000065A0@red.servers.aueb.gr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: parissis@aueb.gr
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Wed, 10 Mar 2010, parissis@aueb.gr wrote:
> Hello, 
> 
> I would to ask if there is a way (via a configuration parameter) to 
> completely disable data and metadata replication? 

Hi George,

You can adjust the replication level with

$ ceph osd pool set data size 1
$ ceph osd pool set metadata size 1

(Replacing 1 with 3 will switch to 3x replication, etc.)

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
