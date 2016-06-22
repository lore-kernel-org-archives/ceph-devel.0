From: Daniel Swarbrick <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: cluster down during backfilling,
 Jewel tunables and client IO optimisations
Date: Wed, 22 Jun 2016 18:09:48 +0200
Message-ID: <nked8c$elu$1@ger.gmane.org>
References: <848514758.3747.1466265852627.JavaMail.zimbra@arhont.com>
	<31cbf96d-c79e-1e7d-19fd-df9e2d2a748f@ip-interactive.de>
	<1456968003.98467.1466423640703.JavaMail.zimbra@arhont.com>
	<nk92c8$knq$1@ger.gmane.org>
	<CAJ4mKGb28W-jPK7Z7wMzm7fC8Q5YPmqr+PeGS=Bz7jky4GfxuA@mail.gmail.com>
	<nke15p$u9f$1@ger.gmane.org>
	<829216253.136015.1466610890998.JavaMail.zimbra@arhont.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <829216253.136015.1466610890998.JavaMail.zimbra-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 22/06/16 17:54, Andrei Mikhailovsky wrote:
> Hi Daniel,
> 
> Many thanks for your useful tests and your results.
> 
> How much IO wait do you have on your client vms? Has it significantly increased or not?
> 

Hi Andrei,

Bearing in mind that this cluster is tiny (four nodes, each with four
OSDs), our metrics may not be that meaningful. However, on a VM that is
running ElasticSearch, collecting logs from Graylog, we're seeing no
more than about 5% iowait for a 5s period, and most of the time it's
below 1%. This VM is really not writing a lot of data though.

The cluster as a whole is peaking at only about 1200 write op/s,
according to ceph -w.

Executing a "sync" in a VM does of course have a noticeable delay due to
the recovery happening in the background, but nothing is waiting for IO
long enough to trigger the kernel's 120s timer / warning.

The recovery has been running for about four hours now, and is down to
20% misplaced objects. So far we have not had any clients block
indefinitely, so I think the migration of VMs to Jewel-capable
hypervisors did the trick.

Best,
Daniel
