From: Dallas Kashuba <dallas@newdream.net>
Subject: Re: Hello, and question about uses for ceph
Date: Mon, 25 Jan 2010 11:09:20 -0800
Message-ID: <4481E1CB-0455-4939-9A14-68DC008B1722@newdream.net>
References: <OF651EA8A7.E420BBCA-ON852576B6.00619E37-852576B6.00626911@tatravelcenters.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <OF651EA8A7.E420BBCA-ON852576B6.00619E37-852576B6.00626911@tatravelcenters.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Wood.Chris@tatravelcenters.com
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi,

Ceph isn't really intended to be used across wide area networks.  From what I understand there's not really a technical limitation preventing it, but you would probably get pretty poor performance.  Ceph is primarily intended for use within a single local area network, and that's what's being worked on right now.  

That said, if you want to test it out over your 1.5Mbps connections and report back how it works for you I think that information would be useful to other people.  One thing to watch out for is that failure recovery would likely saturate your network links as all that data would get copied over all at once.

 - Dallas



On Jan 25, 2010, at 9:54 AM, Wood.Chris@tatravelcenters.com wrote:

> Hello everyone,
> 
> I found out about this project looking for "distributed storage" software. 
> What I have in mind is this:
> 
> We have 248 sites each running a work order system on a server tower with 
> 950Gb internal storage on a RAID 5 array. Right now, the application only 
> consumes about 15Gb of the storage, with modest future storage increases 
> expected. 
> 
> What I would like to do is to somehow utilize the unused space in a 
> distributed storage system, so that instead of backing up our application 
> data to CDs nightly, we could just copy the backup to distributed storage 
> space. If a server crashes and we need to reinstall it, we could just 
> recover the backup data from the other nodes in the storage network.
> 
> I was thinking of running a VM server on each machine, and one VM would 
> run the application server, and another VM would run a ceph server, which 
> would also make the distributed storage available. Unfortunately, the 
> links between the sites and HQ are limited to 1.5Mbps, but that might be 
> made up for by distributing the load over many sites.
> 
> I realize ceph is not ready for production work, but if ceph would be the 
> tool for this, I'd like to set up a test cluster in our lab and see if I 
> can make this work. 
> 
> Thank you,
> Chris 
> 


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
