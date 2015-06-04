From: Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
Subject: Re: Discuss: New default recovery config settings
Date: Thu, 04 Jun 2015 17:01:34 -0400
Message-ID: <5570BCAE.5050509@cloudapt.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>	<CAC6JEv8LyM1SRsOszDCj6tLxhZ=hvrEkinDARW8BvyQHDCz+LQ@mail.gmail.com>	<622F4407872BA447A16110F65453358C03DFB21C4B5F@FMSAMAIL.fmsa.local>	<CAC6JEv-i6tOwPBDjP++EW4FxAKZ_X_prEZ8YZOpLq-RTP1ZguQ@mail.gmail.com>
	<alpine.DEB.2.00.1506031541200.26591@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1506031541200.26591-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Von-Stamwitz <PVonStamwitz-gkcJ3tX5bYHQFUHtdCDX3A@public.gmane.org>, "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

With a write-heavy RBD workload, I add the following to ceph.conf:

osd_max_backfills = 2
osd_recovery_max_active = 2

If things are going well during recovery (i.e. guests happy and no slow 
requests), I will often bump both up to three:

# ceph tell osd.* injectargs '--osd-max-backfills 3 
--osd-recovery-max-active 3'

If I see slow requests, I drop them down.

The biggest downside to setting either to 1 seems to be the long tail 
issue detailed in:

http://tracker.ceph.com/issues/9566

Thanks,
Mike Dawson


On 6/3/2015 6:44 PM, Sage Weil wrote:
> On Mon, 1 Jun 2015, Gregory Farnum wrote:
>> On Mon, Jun 1, 2015 at 6:39 PM, Paul Von-Stamwitz
>> <PVonStamwitz-gkcJ3tX5bYHQFUHtdCDX3A@public.gmane.org> wrote:
>>> On Fri, May 29, 2015 at 4:18 PM, Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> On Fri, May 29, 2015 at 2:47 PM, Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>>> Many people have reported that they need to lower the osd recovery config options to minimize the impact of recovery on client io.  We are talking about changing the defaults as follows:
>>>>>
>>>>> osd_max_backfills to 1 (from 10)
>>>>> osd_recovery_max_active to 3 (from 15)
>>>>> osd_recovery_op_priority to 1 (from 10)
>>>>> osd_recovery_max_single_start to 1 (from 5)
>>>>
>>>> I'm under the (possibly erroneous) impression that reducing the number of max backfills doesn't actually reduce recovery speed much (but will reduce memory use), but that dropping the op priority can. I'd rather we make users manually adjust values which can have a material impact on their data safety, even if most of them choose to do so.
>>>>
>>>> After all, even under our worst behavior we're still doing a lot better than a resilvering RAID array. ;) -Greg
>>>> --
>>>
>>>
>>> Greg,
>>> When we set...
>>>
>>> osd recovery max active = 1
>>> osd max backfills = 1
>>>
>>> We see rebalance times go down by more than half and client write performance increase significantly while rebalancing. We initially played with these settings to improve client IO expecting recovery time to get worse, but we got a 2-for-1.
>>> This was with firefly using replication, downing an entire node with lots of SAS drives. We left osd_recovery_threads, osd_recovery_op_priority, and osd_recovery_max_single_start default.
>>>
>>> We dropped osd_recovery_max_active and osd_max_backfills together. If you're right, do you think osd_recovery_max_active=1 is primary reason for the improvement? (higher osd_max_backfills helps recovery time with erasure coding.)
>>
>> Well, recovery max active and max backfills are similar in many ways.
>> Both are about moving data into a new or outdated copy of the PG ? the
>> difference is that recovery refers to our log-based recovery (where we
>> compare the PG logs and move over the objects which have changed)
>> whereas backfill requires us to incrementally move through the entire
>> PG's hash space and compare.
>> I suspect dropping down max backfills is more important than reducing
>> max recovery (gathering recovery metadata happens largely in memory)
>> but I don't really know either way.
>>
>> My comment was meant to convey that I'd prefer we not reduce the
>> recovery op priority levels. :)
>
> We could make a less extreme move than to 1, but IMO we have to reduce it
> one way or another.  Every major operator I've talked to does this, our PS
> folks have been recommending it for years, and I've yet to see a single
> complaint about recovery times... meanwhile we're drowning in a sea of
> complaints about the impact on clients.
>
> How about
>
>   osd_max_backfills to 1 (from 10)
>   osd_recovery_max_active to 3 (from 15)
>   osd_recovery_op_priority to 3 (from 10)
>   osd_recovery_max_single_start to 1 (from 5)
>
> (same as above, but 1/3rd the recovery op prio instead of 1/10th)
> ?
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
