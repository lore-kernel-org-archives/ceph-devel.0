From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: OSD state flipping when cluster-network in high
 utilization
Date: Tue, 14 May 2013 20:40:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305142039520.23131@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC0145EFF6@SHSMSX102.ccr.corp.intel.com>
	<alpine.DEB.2.00.1305140828550.22973@cobra.newdream.net>,
	<519259C5.3000109@inktank.com>
	<6AC1548D-DE2C-4E71-AC73-3903B57C76C6@intel.com>
	<alpine.DEB.2.00.1305141620410.12954@cobra.newdream.net>
	<6F3FA899187F0043BA1827A69DA2F7CC0145F746@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC0145F746-0J0gbvR4kTiiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 15 May 2013, Chen, Xiaoxi wrote:

> >How responsive generally is the machine under load?  Is there available CPU?
> 	The machine works well, and the issued OSDs are likely the same, seems because they have relative slower disk( disk type are the same but the latency is a bit higher ,8ms -> 10ms).
> 	
> 	Top show no idle % but still have 30+% of io_wait,  my colleague educate me that io_wait can be treated as free.
> 
> Another information is offload the heartbeat to 1Gb nic doesn't solve 
> the problem, what's more, when we doing random write test, we can still 
> see this flipping happen. So I would like to say it may related with CPU 
> scheduler ? The heartbeat thread (in busy OSD ) failed to get enough cpu 
> cycle.

Can you try reproducing with logs?  If we can reproduce that will give us 
some clues.

sage

> 
> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
> Sent: 2013?5?15? 7:23
> To: Chen, Xiaoxi
> Cc: Mark Nelson; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
> Subject: Re: [ceph-users] OSD state flipping when cluster-network in high utilization
> 
> On Tue, 14 May 2013, Chen, Xiaoxi wrote:
> > I like the idea to leave ping in cluster network because it can help 
> > us detect switch?nic failure.
> > 
> > What confuse me is I keep pinging every ceph node's cluster ip?it is 
> > OK during the whole run with less than 1 ms latency?why the heartbeat 
> > still suffer? TOP show my cpu not 100% utilized?with ?30% io 
> > wait?.Enabling jumbo frame **seems** make things worth.(just 
> > feeling.no data supports)
> 
> I say "ping" in teh general sense.. it's not using ICMP, but sending small messages over a TCP session, doing some minimal processing on the other end, and sending them back.  If the machine is heavily loaded and that thread doesn't get scheduled or somehow blocks, it may be problematic.
> 
> How responsive generally is the machine under load?  Is there available CPU?
> 
> We can try to enable debugging to see what is going on.. 'debug ms = 1' 
> and 'debug osd = 20' is everything we would need, but will incur additoinal load itself and may spoil the experiment...
> 
> sage
> 
> > 
> > ???? iPhone
> > 
> > ? 2013-5-14?23:36?"Mark Nelson" <mark.nelson-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> ???
> > 
> > > On 05/14/2013 10:30 AM, Sage Weil wrote:
> > >> On Tue, 14 May 2013, Chen, Xiaoxi wrote:
> > >>> 
> > >>> Hi
> > >>> 
> > >>>   We are suffering our OSD flipping between up and down ( OSD X be 
> > >>> voted to down due to 3 missing ping, and after a while it tells 
> > >>> the monitor ?map xxx wrongly mark me down? ). Because we are 
> > >>> running sequential write performance test on top of RBDs, and the 
> > >>> cluster network nics is really in high utilization (8Gb/s+ for a 10Gb network).
> > >>> 
> > >>>          Is this a expected behavior ? or how can I prevent this happen?
> > >> 
> > >> You an increase the heartbeat grace period.  The pings are handled 
> > >> by a separate thread on the backside interface (if there is one).  
> > >> If you are missing pings then the network or scheduler is 
> > >> preventing those (small) messages from being processed (there is 
> > >> almost no lock contention in that path).  Which means it really is 
> > >> taking ~20 seconds or wahtever to handle those messages.  It's 
> > >> really a questin of how unresponsive you want to permit the OSDs to be before you consider it a failure..
> > >> 
> > >> sage
> > >> 
> > >> 
> > > 
> > > It might be worth testing out how long pings or other network traffic are taking during these tests.  There may be some tcp tunning you can do here, or even consider using a separate network for the mons.
> > > 
> > > Mark
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
