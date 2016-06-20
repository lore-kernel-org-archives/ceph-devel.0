From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: cluster down during backfilling,
 Jewel tunables and client IO optimisations
Date: Mon, 20 Jun 2016 10:51:04 -0700
Message-ID: <CAJ4mKGb28W-jPK7Z7wMzm7fC8Q5YPmqr+PeGS=Bz7jky4GfxuA@mail.gmail.com>
References: <848514758.3747.1466265852627.JavaMail.zimbra@arhont.com>
	<31cbf96d-c79e-1e7d-19fd-df9e2d2a748f@ip-interactive.de>
	<1456968003.98467.1466423640703.JavaMail.zimbra@arhont.com>
	<nk92c8$knq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <nk92c8$knq$1@ger.gmane.org>
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
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Jun 20, 2016 at 8:33 AM, Daniel Swarbrick
<daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org> wrote:
> We have just updated our third cluster from Infernalis to Jewel, and are
> experiencing similar issues.
>
> We run a number of KVM virtual machines (qemu 2.5) with RBD images, and
> have seen a lot of D-state processes and even jbd/2 timeouts and kernel
> stack traces inside the guests. At first I thought the VMs were being
> starved of IO, but this is still happening after throttling back the
> recovery with:
>
> osd_max_backfills = 1
> osd_recovery_max_active = 1
> osd_recovery_op_priority = 1
>
> After upgrading the cluster to Jewel, I changed our crushmap to use the
> newer straw2 algorithm, which resulted in a little data movment, but no
> problems at that stage.
>
> Once the cluster had settled down again, I set tunables to optimal
> (hammer profile -> jewel profile), which has triggered between 50% and
> 70% misplaced PGs on our clusters. This is when the trouble started each
> time, and when we had cascading failures of VMs.
>
> However, after performing hard shutdowns on the VMs and restarting them,
> they seemed to be OK.
>
> At this stage, I have a strong suspicion that it is the introduction of
> "require_feature_tunables5 = 1" in the tunables. This seems to require
> all RADOS connections to be re-established.

Do you have any evidence of that besides the one restart?

I guess it's possible that we aren't kicking requests if the crush map
but not the rest of the osdmap changes, but I'd be surprised.
-Greg

>
>
> On 20/06/16 13:54, Andrei Mikhailovsky wrote:
>> Hi Oliver,
>>
>> I am also seeing this as a strange behavriour indeed! I was going through the logs and I was not able to find any errors or issues. There was also no slow/blocked requests that I could see during the recovery process.
>>
>> Does anyone has an idea what could be the issue here? I don't want to shut down all vms every time there is a new release with updated tunable values.
>>
>>
>> Andrei
>>
>>
>>
>> ----- Original Message -----
>>> From: "Oliver Dzombic" <info-cbyvsTkHNGAhzyAFmVfXCbNAH6kLmebB@public.gmane.org>
>>> To: "andrei" <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>, "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>> Sent: Sunday, 19 June, 2016 10:14:35
>>> Subject: Re: [ceph-users] cluster down during backfilling, Jewel tunables and client IO optimisations
>>
>>> Hi,
>>>
>>> so far the key values for that are:
>>>
>>> osd_client_op_priority = 63 ( anyway default, but i set it to remember it )
>>> osd_recovery_op_priority = 1
>>>
>>>
>>> In addition i set:
>>>
>>> osd_max_backfills = 1
>>> osd_recovery_max_active = 1
>>>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
