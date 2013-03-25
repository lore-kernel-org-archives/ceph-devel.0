From: Gregory Farnum <greg@inktank.com>
Subject: Re: crush changes via cli
Date: Sun, 24 Mar 2013 17:18:58 -0700
Message-ID: <CAPYLRzi4z1BMnhkENLyOoBRsDCcbsrnj5_bw+6CrWbP1Pws5NA@mail.gmail.com>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net>
	<CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com>
	<alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net>
	<43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
	<alpine.DEB.2.00.1303241629400.1736@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:45109 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3CYAS7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Mar 2013 20:18:59 -0400
Received: by mail-qc0-f177.google.com with SMTP id u28so1979099qcs.22
        for <ceph-devel@vger.kernel.org>; Sun, 24 Mar 2013 17:18:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303241629400.1736@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Mar 24, 2013 at 5:04 PM, Sage Weil <sage@inktank.com> wrote:
> On Sun, 24 Mar 2013, Gregory Farnum wrote:
>> On Fri, Mar 22, 2013 at 3:58 PM, Sage Weil <sage@inktank.com (mailto=
:sage@inktank.com)> wrote:
>> > On Fri, 22 Mar 2013, Gregory Farnum wrote:
>> > > I suspect users are going to easily get in trouble without a mor=
e
>> > > rigid separation between multi-linked and single-linked buckets.=
 It's
>> > > probably best if anybody who's gone to the trouble of setting up=
 a DAG
>> > > can't wipe it out without being very explicit ? so for instance =
"move"
>> > > should only work against a bucket with a single parent.
>> > >
>> >
>> >
>> > Good idea; I'll add that.
>> >
>> > > Rather than
>> > > defaulting to all ancestors, removals should (for multiply-linke=
d
>> > > buckets) require users to either specify a set of ancestors or t=
o pass
>> > > in a "--all" flag.
>> >
>> > 'rm' only works on an empty bucket, so I'm not sure there is much =
danger
>> > is removing all links (and the bucket) in that case?
>>
>> Well, if "unlink" takes it out of the tree without requiring it to b=
e empty then that would be one case.
>
> Oh, right.  That's true.  I'm still not a fan of an --all flag, thoug=
h.
> In almost all cases, users will have maps with only 1 link, so the
> required flag will be confusing.  It also breaks the current behavior
> (which already removes all links).

I was thinking that if there was only one link it would remove that
one. I didn't realize it currently removed all links =97 although I
dimly remember a bug about just randomly taking the first one it
finds. Is that new-ish behavior?


>> I guess mostly I'm just not sure what the use case is for keeping ar=
ound
>> unlinked buckets so I'd rather keep the set of CLI options simpler. =
It's
>> not that hard to link a bucket into the tree where you want it and t=
hen
>> remove the other links.
>
> Yeah, that isn't often useful in and of itself... but it is possible =
(and
> often required) to create independent trees, and if you can link them=
, you
> have to be able to unlink them.

Currently we just have "rm", right? And that removes the link and the
bucket? Can't we just keep "rm" and for multiply-linked buckets
require a specification of which ancestor to remove the link from (or
a --all flag), and then delete the bucket when the final link is
removed?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
