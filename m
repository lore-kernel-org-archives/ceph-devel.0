From: Andrei Mikhailovsky <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>
Subject: Re: cluster down during backfilling,
 Jewel tunables and client IO optimisations
Date: Wed, 22 Jun 2016 16:54:51 +0100 (BST)
Message-ID: <829216253.136015.1466610890998.JavaMail.zimbra@arhont.com>
References: <848514758.3747.1466265852627.JavaMail.zimbra@arhont.com>
	<31cbf96d-c79e-1e7d-19fd-df9e2d2a748f@ip-interactive.de>
	<1456968003.98467.1466423640703.JavaMail.zimbra@arhont.com>
	<nk92c8$knq$1@ger.gmane.org>
	<CAJ4mKGb28W-jPK7Z7wMzm7fC8Q5YPmqr+PeGS=Bz7jky4GfxuA@mail.gmail.com>
	<nke15p$u9f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <nke15p$u9f$1@ger.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Daniel Swarbrick <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Daniel,

Many thanks for your useful tests and your results.

How much IO wait do you have on your client vms? Has it significantly increased or not?

Many thanks

Andrei

----- Original Message -----
> From: "Daniel Swarbrick" <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
> To: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Sent: Wednesday, 22 June, 2016 13:43:37
> Subject: Re: [ceph-users] cluster down during backfilling, Jewel tunables and client IO optimisations

> On 20/06/16 19:51, Gregory Farnum wrote:
>> On Mon, Jun 20, 2016 at 8:33 AM, Daniel Swarbrick
>>>
>>> At this stage, I have a strong suspicion that it is the introduction of
>>> "require_feature_tunables5 = 1" in the tunables. This seems to require
>>> all RADOS connections to be re-established.
>> 
>> Do you have any evidence of that besides the one restart?
>> 
>> I guess it's possible that we aren't kicking requests if the crush map
>> but not the rest of the osdmap changes, but I'd be surprised.
>> -Greg
> 
> I think the key fact to take note of is that we had long-running Qemu
> processes that had been started a few months ago, using Infernalis
> librbd shared libs.
> 
> If Infernalis had no concept of require_feature_tunables5, then it seems
> logical that these clients would block if the cluster were upgraded to
> Jewel and this tunable became mandatory.
> 
> I have just upgraded our fourth and final cluster to Jewel. Prior to
> applying optimal tunables, we upgraded our hypervisor nodes' librbd
> also, and migrated all VMs at least once, to start a fresh Qemu process
> for each (using the updated librbd).
> 
> We're seeing ~65% data movement due to chooseleaf_stable 0 => 1, but
> other than that, so far so good. No clients are blocking indefinitely.
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
