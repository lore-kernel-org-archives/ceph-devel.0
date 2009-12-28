From: Sage Weil <sage@newdream.net>
Subject: Re: ceph in v2.6.33?
Date: Mon, 28 Dec 2009 09:42:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0912280937231.28566@cobra.newdream.net>
References: <Pine.LNX.4.64.0912071511470.32397@cobra.newdream.net>
	<alpine.LFD.2.00.0912181327200.3712@localhost.localdomain>
	<Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
	<200912281205.36802.anton.vazir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200912281205.36802.anton.vazir@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Anton <anton.vazir@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Mon, 28 Dec 2009, Anton wrote:
> FS with CEPH abilities is the LOOOOONG time awaited stuff, 
> which I (personally) looking so much forward to stabilize - 
> that it could be hardly expressed. I't not widelly known 
> yet, but I think a lot of us, who needs clustered storage 
> and did own survey of the cluster FS stuff available (like 
> gluster, etc) - just siletntly monitor the list for the 
> signs that code is stable enough to be used in the 
> production. How should we show our demand fo Linus? I would 
> really like to see kernel supporting  CEPH in the mainline.

We have a few disk format changes planned for the next week or two (mainly 
compat/incompat flags to making future changes easier), but once those are 
in we could really use some wider testing.  Our list of known bugs is 
shrinking and it's getting hard to break things.  Getting more users 
trying the system out will both help with the development and stability 
effort and demonstrate the kind of interest Linus is looking for.

sage

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
