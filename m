From: Gregory Farnum <greg@inktank.com>
Subject: Re: github pull requests, comments and rebase
Date: Wed, 14 Aug 2013 11:28:55 -0700
Message-ID: <CAPYLRzhArn4_0G5h_Kiwa4mnFKbtgpqiSABtDpFQHMsA+OqzUg@mail.gmail.com>
References: <52036DAC.5040106@dachary.org>
	<alpine.DEB.2.00.1308081330300.29872@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34779 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760342Ab3HNS25 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 14:28:57 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so8057869wes.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 11:28:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308081330300.29872@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 8, 2013 at 1:46 PM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 8 Aug 2013, Loic Dachary wrote:
>> Hi Sage,
>>
>> During the discussions about continuous integration at the CDS this week ( http://youtu.be/cGosx5zD4FM?t=1h16m05s ) you mentionned that github was able to keep track of the successive versions of a pull request commit, even in the case of a rebase. I just tried the following:
>>
>> a) comment on commit associated to https://github.com/ceph/ceph/pull/455 ( both inline and at the end of the commit )
>> b) Christophe rebased the associated commit against master and git push --force to publish it
>> c) The original commit  does not show up in https://github.com/ceph/ceph/pull/455  and the new commit, result of the rebase, https://github.com/kri5/ceph/commit/051b0c3e15c98714b95fca5cb7838de9614dc8e3 does not display my inline comments.
>>
>> Do you to know a different workflow that would allow rebase and keep track of the different versions / comments of the pull request ? Something similar to what you have in gerrit with https://review.openstack.org/#/c/22708/ for example where you can see and compare the patch sets.
>
> Well, blarney.  Yeah, it is not perfect.
>
> The workflow that *does* work:
>
> - open a pull
> - comment on the rolled-up diff, e.g.
> https://github.com/ceph/ceph/pull/487/files
> - re-push teh branch
>
> and it will do a cute 'so and so commented on 3 old commits' thing.
>
> This isn't always how people like to review, sadly.  I'm hopeful that
> github will suddenly get better and this problem will go way, but
> shouldn't hold my breath.
>
> In my mind this isn't a deal-breaker... whatdoes everyone else think?

It's fairly frustrating when reviewing large branches. What I've
resorted to is doing reviews in gitk on a patch-by-patch basis and
then going and finding the line in the rolled-up diff. That does work,
but it's really awkward, especially when the full patch set includes
changes that don't fix an issue but do obscure its origin. I would
love a more robust review system but the more I hear about Gerrit the
less it sounds like I could stand that either. :/
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
