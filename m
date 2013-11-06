From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Running on disks that lose their head
Date: Wed, 6 Nov 2013 01:33:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311060128510.24956@cobra.newdream.net>
References: <52798E1D.9090807@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <52798E1D.9090807-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 6 Nov 2013, Loic Dachary wrote:
> Hi Ceph,
> 
> People from Western Digital suggested ways to better take advantage of 
> the disk error reporting. They gave two examples that struck my 
> imagination. First there are errors that look like the disk is dying ( 
> read / write failures ) but it's only a transient problem and the driver 
> should be able to make the difference by properly interpreting the 
> available information. They said that the prolonged life you get if you 
> don't decommission a disk that only has a transient error is 

This make me think we really need to build or integrate with some generic 
SMART reporting infrastructure so that we can identify disks that are 
failing or going to fail.  What to do with that information is another 
question; initially I would lean toward just marking the disk out, but 
there may be smarter alternatives to investigate.

> significant. The second example is when one head out of ten fails : 
> disks can keep working with the nine remaining heads. Losing 1/10 of the 
> disk is likely to result in a full re-install of the Ceph osd. But, 
> again, the disk could keep going after that, with 9/10 of its original 
> capacity. And Ceph is good at handling osd failures.

Yeah...but if you lose 1/10 of a block device any existing local file 
system is going to blow up.  I suspet this is something that newgangled 
interfaces like Kinetic will be much better at.  Even then, though, it is 
challenging for anything sitting above to cope with losing some random 
subset of it's data underneath.  To a first approximation, for this to be 
useful, the fs and disk would need to keep, say, all teh data in a 
particular PG confined to a single platter, so that when a head goes the 
other PGs are still fully intact and usage.  It is probably a long way to 
get from here to there...

> All this is news to me and sounds really cool. But I'm sure there are 
> people who already know about it and I'm eager to hear their opinion :-)
> 
> Cheers
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
