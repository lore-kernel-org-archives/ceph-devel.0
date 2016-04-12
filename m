From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 09:45:02 +0200
Message-ID: <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36040 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbcDLHpG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 03:45:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id v188so115474734wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 00:45:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com, ceph-announce@ceph.com

I'd like to raise these points, then

1) some people (like me) will never ever use XFS if they have a choice
given no choice, we will not use something that depends on XFS

2) choice is always good

3) doesn't majority of Ceph users only care about RBD?

(Angry rant coming)
Even our last performance testing of Ceph (Infernalis) showed abysmal performance. The most damning sign is the consumption of CPU time at unprecedented rate. Was it faster than Dumpling? Slightly, but it ate more CPU also, so in effect it was not really "faster".

It would make *some* sense to only support ZFS or BTRFS because you can offload things like clones/snapshots and consistency to the filesystem - which would make the architecture much simpler and everything much faster.
Instead you insist on XFS and reimplement everything in software. I always dismissed this because CPU time was ususally cheap, but in practice it simply doesn't work.
You duplicate things that filesystems had solved for years now (namely crash consistency - though we have seen that fail as well), instead of letting them do their work and stripping the IO path to the bare necessity and letting someone smarter and faster handle that.

IMO, If Ceph was moving in the right direction there would be no "supported filesystem" debate, instead we'd be free to choose whatever is there that provides the guarantees we need from filesystem (which is usually every filesystem in the kernel) and Ceph would simply distribute our IO around with CRUSH.

Right now CRUSH (and in effect what it allows us to do with data) is _the_ reason people use Ceph, as there simply wasn't much else to use for distributed storage. This isn't true anymore and the alternatives are orders of magnitude faster and smaller.

Jan

P.S. If anybody needs a way out I think I found it, with no need to trust a higher power :P


> On 11 Apr 2016, at 23:44, Sage Weil <sage@newdream.net> wrote:
> 
> On Mon, 11 Apr 2016, Sage Weil wrote:
>> Hi,
>> 
>> ext4 has never been recommended, but we did test it.  After Jewel is out, 
>> we would like explicitly recommend *against* ext4 and stop testing it.
> 
> I should clarify that this is a proposal and solicitation of feedback--we 
> haven't made any decisions yet.  Now is the time to weigh in.
> 
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

