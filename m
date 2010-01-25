From: Wood.Chris@tatravelcenters.com
Subject: Hello, and question about uses for ceph
Date: Mon, 25 Jan 2010 12:54:54 -0500
Message-ID: <OF651EA8A7.E420BBCA-ON852576B6.00619E37-852576B6.00626911@tatravelcenters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hello everyone,

I found out about this project looking for "distributed storage" software. 
What I have in mind is this:

We have 248 sites each running a work order system on a server tower with 
950Gb internal storage on a RAID 5 array. Right now, the application only 
consumes about 15Gb of the storage, with modest future storage increases 
expected. 

What I would like to do is to somehow utilize the unused space in a 
distributed storage system, so that instead of backing up our application 
data to CDs nightly, we could just copy the backup to distributed storage 
space. If a server crashes and we need to reinstall it, we could just 
recover the backup data from the other nodes in the storage network.

I was thinking of running a VM server on each machine, and one VM would 
run the application server, and another VM would run a ceph server, which 
would also make the distributed storage available. Unfortunately, the 
links between the sites and HQ are limited to 1.5Mbps, but that might be 
made up for by distributing the load over many sites.

I realize ceph is not ready for production work, but if ceph would be the 
tool for this, I'd like to set up a test cluster in our lab and see if I 
can make this work. 

Thank you,
Chris 

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
