From: Matthew Vernon <mv3-5fLPn3lgkryFxr2TtlUqVg@public.gmane.org>
Subject: Re: killing ceph-disk [was Re: ceph-volume: migration
 and disk partition support]
Date: Thu, 12 Oct 2017 12:39:39 +0100
Message-ID: <e0b4d0ae-f48a-417f-9171-98b020ec4abd@sanger.ac.uk>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
 <alpine.DEB.2.11.1710091448500.26711@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1710091448500.26711-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

On 09/10/17 16:09, Sage Weil wrote:
> To put this in context, the goal here is to kill ceph-disk in mimic.
> 
> One proposal is to make it so new OSDs can *only* be deployed with LVM,
> and old OSDs with the ceph-disk GPT partitions would be started via
> ceph-volume support that can only start (but not deploy new) OSDs in that
> style.
> 
> Is the LVM-only-ness concerning to anyone?
> 
> Looking further forward, NVMe OSDs will probably be handled a bit
> differently, as they'll eventually be using SPDK and kernel-bypass (hence,
> no LVM).  For the time being, though, they would use LVM.

This seems the best point to jump in on this thread. We have a ceph 
(Jewel / Ubuntu 16.04) cluster with around 3k OSDs, deployed with 
ceph-ansible. They are plain-disk OSDs with journal on NVME partitions. 
I don't think this is an unusual configuration :)

I think to get rid of ceph-disk, we would want at least some of the 
following:

* solid scripting for "move slowly through cluster migrating OSDs from 
disk to lvm" - 1 OSD at a time isn't going to produce unacceptable 
rebalance load, but it is going to take a long time, so such scripting 
would have to cope with being stopped and restarted and suchlike (and be 
able to use the correct journal partitions)

* ceph-ansible support for "some lvm, some plain disk" arrangements - 
presuming a "create new OSDs as lvm" approach when adding new OSDs or 
replacing failed disks

* support for plain disk (regardless of what provides it) that remains 
solid for some time yet

> On Fri, 6 Oct 2017, Alfredo Deza wrote:

>> Bluestore support should be the next step for `ceph-volume lvm`, and
>> while that is planned we are thinking of ways to improve the current
>> caveats (like OSDs not coming up) for clusters that have deployed OSDs
>> with ceph-disk.

These issues seem mostly to be down to timeouts being too short and the 
single global lock for activating OSDs.

> IMO we can't require any kind of data migration in order to upgrade, which
> means we either have to (1) keep ceph-disk around indefinitely, or (2)
> teach ceph-volume to start existing GPT-style OSDs.  Given all of the
> flakiness around udev, I'm partial to #2.  The big question for me is
> whether #2 alone is sufficient, or whether ceph-volume should also know
> how to provision new OSDs using partitions and no LVM.  Hopefully not?

I think this depends on how well tools such as ceph-ansible can cope 
with mixed OSD types (my feeling at the moment is "not terribly well", 
but I may be being unfair).

Regards,

Matthew



-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
