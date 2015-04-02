From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: don't set memalloc flags in loopback case
Date: Thu, 2 Apr 2015 11:35:35 +0300
Message-ID: <CAOi1vP_VYDQ1+CjzGG4kZx5C2K97Vhv63w2s9edLE4rnZ2pTMA@mail.gmail.com>
References: <1427908760-7083-1-git-send-email-idryomov@gmail.com>
	<20150401230323.GD20397@suse.de>
	<CAOi1vP-u_sWF0uZpbYCN9qUp80tXQvmnJdOjWM3kpSR1JqSDMg@mail.gmail.com>
	<20150402054124.GE20397@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38743 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbbDBIfg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Apr 2015 04:35:36 -0400
Received: by wibgn9 with SMTP id gn9so96536987wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2015 01:35:35 -0700 (PDT)
In-Reply-To: <20150402054124.GE20397@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mel Gorman <mgorman@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <michaelc@cs.wisc.edu>, Sage Weil <sage@redhat.com>

On Thu, Apr 2, 2015 at 8:41 AM, Mel Gorman <mgorman@suse.de> wrote:
> On Thu, Apr 02, 2015 at 02:40:19AM +0300, Ilya Dryomov wrote:
>> On Thu, Apr 2, 2015 at 2:03 AM, Mel Gorman <mgorman@suse.de> wrote:
>> > On Wed, Apr 01, 2015 at 08:19:20PM +0300, Ilya Dryomov wrote:
>> >> Following nbd and iscsi, commit 89baaa570ab0 ("libceph: use memalloc
>> >> flags for net IO") set SOCK_MEMALLOC and PF_MEMALLOC flags for rbd and
>> >> cephfs.  However it turned out to not play nice with loopback scenario,
>> >> leading to lockups with a full socket send-q and empty recv-q.
>> >>
>> >> While we always advised against colocating kernel client and ceph
>> >> servers on the same box, a few people are doing it and it's also useful
>> >> for light development testing, so rather than reverting make sure to
>> >> not set those flags in the loopback case.
>> >>
>> >
>> > This does not clarify why the non-loopback case needs access to pfmemalloc
>> > reserves. Granted, I've spent zero time on this but it's really unclear
>> > what problem was originally tried to be solved and why dirty page limiting
>> > was insufficient. Swap over NFS was always a very special case minimally
>> > because it's immune to dirty page throttling.
>>
>> I don't think there was any particular problem tried to be solved,
>
> Then please go back and look at why dirty page limiting is insufficient
> for ceph.
>
>> certainly not one we hit and fixed with 89baaa570ab0.  Mike is out this
>> week, but I'm pretty sure he said he copied this for iscsi from nbd
>> because you nudged him to (and you yourself did this for nbd as part of
>> swap-over-NFS series).
>
> In http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/23708 I
> stated that if ceph insisted on using using nbd as justification for ceph
> using __GFP_MEMALLOC that it was preferred that nbd be broken instead. In
> commit 7f338fe4540b1d0600b02314c7d885fd358e9eca, the use case in mind was
> the swap-over-nbd case and I regret I didn't have userspace explicitly
> tell the kernel that NBD was being used as a swap device.

OK, it all starts to make sense now.  So ideally nbd would only use
__GFP_MEMALLOC if nbd-client was invoked with -swap - you just didn't
implement that.  I guess I should have gone deeper into the history of
your nbd patch when Mike cited it as a reason he did this for ceph.

I think ceph is fine with dirty page limiting in general, so it's only
if we wanted to support swap-over-rbd (cephfs is a bit of a weak link
currently, so I'm not going there) would we need to enable
SOCK_MEMALLOC/PF_MEMALLOC and only for that ceph_client instance.
Sounds like that will require a "swap" libceph option, which will also
implicitly enable "noshare" to make sure __GFP_MEMALLOC ceph_client is
not shared with anything else - luckily we don't have a userspace
process a la nbd-client we need to worry about.

Thanks,

                Ilya
