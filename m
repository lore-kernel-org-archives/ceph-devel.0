From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: long object names
Date: Fri, 22 Apr 2011 10:36:07 -0700
Message-ID: <BANLkTinc4nnZ_61pJsP4Jp2EFwp5GprZEg@mail.gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
	<20110421185606.GC9431@dreamer>
	<BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
	<20110421193240.GA26545@dreamer>
	<99672323C62444DFA181A0659E4D37FC@gmail.com>
	<20110421220044.GB26545@dreamer>
	<BANLkTikCG487GB=n+9eT+66hxBVk_gfwqw@mail.gmail.com>
	<20110421230744.GC26545@dreamer>
	<Pine.LNX.4.64.1104220818210.15351@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32890 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab1DVRgJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2011 13:36:09 -0400
Received: by fxm17 with SMTP id 17so433012fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2011 10:36:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104220818210.15351@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Fri, Apr 22, 2011 at 8:44 AM, Sage Weil <sage@newdream.net> wrote:
> Few things:
>
> - I think the xattr approach is always going to be faster. =A0xattrs =
are
> stored adjacent to the inode in the btree, while creating intervening
> directories means a new inode is allocated, seeked to, and loaded, an=
d
> _then_ the directory content is looked up in another part of the btre=
e
> before the final inode is located. =A0For each level you add two seek=
s
> (although in the common case, at least, those inodes will be close by=
).

=46air enough.

> - You can't make intervening directories both rare (long) and useful =
for
> prefix search (short) unless you really think people will be searchin=
g on
> 100+ character prefixes.

Earlier I suggested making it configurable, so that we could have it
tuned to a short value on the cluster backing rgw, but a long value
elsewhere.

> - Hash collisions will be rare for all but our test cases. =A0If we o=
nly
> hash for long filenames (say, 200+ characters) that means someone has=
 to
> find a SHA-256 collision (has anybody??). =A0And even then they only =
turn 1
> stat into 2. =A0Only if someone can generate an arbitrary number of i=
nputs
> that hash to the same value do they get anywhere. =A0I don't think th=
at's
> something we should worry about. =A0If someone breaks a crypto hash t=
here
> are much bigger things to worry about. =A0(Even if we are super paran=
oid,
> then just sha(name + sha(name)).

A good guide to choosing a crypto hash: http://valerieaurora.org/hash.h=
tml

> - We can easily wrap the non-fast past with a mutex to avoid the race=
s
> (because, again, collisions are vanishingly rare except in our test
> cases).

I believe that all these operations are already done under the PG
lock. So there are no race conditions in normal operation. TV is
talking about a case where there has been a crash and we're resuming
from some intermediate state. Based on our earlier discussion, perhaps
this is not a problem on btrfs because of the snapshotting mechanic?

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
