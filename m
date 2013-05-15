From: "Jim Schutt" <jaschut-4OHPYypu0djtX7QSmKvirg@public.gmane.org>
Subject: Re: OSD state flipping when cluster-network in high
 utilization
Date: Wed, 15 May 2013 09:05:51 -0600
Message-ID: <5193A44F.1060509@sandia.gov>
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

On 05/14/2013 09:23 PM, Chen, Xiaoxi wrote:
>> How responsive generally is the machine under load?  Is there available CPU?
> 	The machine works well, and the issued OSDs are likely the same, seems because they have relative slower disk( disk type are the same but the latency is a bit higher ,8ms -> 10ms).
> 	
> 	Top show no idle % but still have 30+% of io_wait,  my colleague educate me that io_wait can be treated as free.
> 
> Another information is offload the heartbeat to 1Gb nic doesn't solve the problem, what's more, when we doing random write test, we can still see this flipping happen. So I would like to say it may related with CPU scheduler ? The heartbeat thread (in busy OSD ) failed to get enough cpu cycle.
> 

FWIW, also take a close look at your monitor daemons, and
whether they show any signs of being overloaded.

I frequently see OSDs wrongly marked down when my
mons cannot keep up with their workload.

-- Jim
