From: Owen Synge <osynge@suse.com>
Subject: Re: 60-ceph-partuuid-workaround.rules
Date: Mon, 18 Apr 2016 16:00:06 +0200
Message-ID: <5714E866.90607@suse.com>
References: <5714B073.6070809@redhat.com>
 <alpine.DEB.2.11.1604180821450.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39030 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcDROAQ (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 18 Apr 2016 10:00:16 -0400
In-Reply-To: <alpine.DEB.2.11.1604180821450.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Peter Rajnoha <prajnoha@redhat.com>
Cc: ceph-devel@vger.kernel.org, Loic Dachary <ldachary@redhat.com>, "Alasdair G. Kergon" <agk@redhat.com>, Zdenek Kabelac <zkabelac@redhat.com>

On 04/18/2016 02:25 PM, Sage Weil wrote:
> On Mon, 18 Apr 2016, Peter Rajnoha wrote:
>> Hi!
>>
>> I'm resending original mail to this list after initial
>> discussion with Loic Dachary so others can chime in. Loic
>> says these rules were there to workaround certain problems
>> on Centos 6 only and that it can be discarded now.
>>
>> Please, read original mail below:
>>
>> ===
>>
>> We've just noticed 60-ceph-partuuid-workaround.rules.
>>
>> You added a patch some time ago which made these rules
>> to be applied for DM devices too:
>>
>> https://github.com/ceph/ceph/commit/42ad86e14e352f2a3a33e774224f1789f268da83
>>
>> The problem we've spotted and hit recently is that
>> these rules call blkid which opens all DM devices now
>> on uevents. However, not all DM devices are suitable
>> for scanning as they may not be prepared fully yet.
>> We use various flags in DM (and its subsystems like LVM)
>> to avoid these scans and for all the rules we don't manage,
>> there's DM_UDEV_DISABLE_OTHER_RULES_FLAG that needs to
>> be checked in these "foreign" rules before opening such
>> DM device (which includes running blkid).
>>
>> Otherwise, we may end up with errors where some DM subsystem
>> needs to close the device or do some initialization on this
>> device before making it public by dropping the
>> DM_UDEV_DISABLE_OTHER_RULES_FLAG. So we need to make sure
>> these things are in sync - the scan can't be run on all DM
>> devices, it's controlled via DM_UDEV_*_FLAG variables.
>>
>> Now, when it comes to the 60-ceph-partuuid-workaround.rules,
>> why do we need that at all? I mean, the 60-persistent-storage.rules
>> do not whitelist DM devices, so these rules are skipped anyway
>> and it was that way since beginning, I think. Now, I see this
>> comment in the 60-ceph-partuuid-workaround.rules:
>>
>> # this is a kludge installed by ceph to fix the /dev/disk/by-partuuid
>> # symlinks on systems with old udev (< 180).  it's a stripped down
>> # version of a newer 60-persistent-storage.rules file that hopefully
>> # captures the same set of conditions for setting up those symlinks.
>>
>> So I need to get to the bottom of the problem which was
>> resolved here. Feel free to point me to someone else if you're
>> not the right person, but I need to understand what's behind
>> these extra workaround rules so I can help to make it work
>> correctly with DM devices.
> 
> We added them back when to make the by-partuuid symlinks appear on wheezy:
> 
> commit d8d7113c35b59902902d487738888567e3a6b933
> Author: Sage Weil <sage@inktank.com>
> Date:   Thu May 16 18:40:29 2013 -0700
> 
>     udev: install disk/by-partuuid rules
>     
>     Wheezy's udev (175-7.2) has broken rules for the /dev/disk/by-partuuid/
>     symlinks that ceph-disk relies on.  Install parallel rules that work.  On
>     new udev, this is harmless; old older udev, this will make life better.
>     
>     Fixes: #4865
>     Backport: cuttlefish
>     Signed-off-by: Sage Weil <sage@inktank.com>
> 
> On current master, we are not support wheezy (or rhel6) so we should just 
> remove this rule file entirely--it is no longer needed for 
> internfalis, jewel, or later.
> 
> If you're concerned about hammer, then we need to make sure that it still 
> works on el6, and I'm guessing that is what Loic was working with when we 
> disabled dm-* skipping to make multipath work...
> 
> sage

I am 80% certain this will be fine on SUSE, but since this file has been
included we at SUSE (to my surprise as I thought we only needed it on
SLE11 and earlier) do need to test the impact.

Best wishes

Owen


