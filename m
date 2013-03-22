From: Gregory Farnum <greg@inktank.com>
Subject: Re: crush changes via cli
Date: Fri, 22 Mar 2013 15:51:28 -0700
Message-ID: <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38816 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423434Ab3CVWv3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 18:51:29 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so2075202qcq.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 15:51:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 22, 2013 at 3:38 PM, Sage Weil <sage@inktank.com> wrote:
> There's a branch pending that lets you do the remainder of the most c=
ommon
> crush map changes via teh cli.  The command set breaks down like so:
>
> Updating leaves (devices):
>
>   ceph osd crush set <osd-id> <weight> <loc1> [<loc2> ...]
>   ceph osd crush add <osd-id> <weight> <loc1> [<loc2> ...]
>   ceph osd crush create-or-move <osd-id> <initial-weight> <loc1> [<lo=
c2> ...]
>
> These let you create, add, and move devices in teh map.  The differen=
t
> between add and set is that add will create an additional instance of=
 the
> osd (leaf), while set will move the old instance.  This is useful for=
 some
> configurations.
>
> The loc ... bits let you specify the 'where' part in teh form of key/=
value
> pairs, like 'host=3Dfoo rack=3Dbar root=3Ddefault'.  It will find the
> most-specific pair that matches an existing item, and create any
> intervening ancestors.  For example, if my map has only a root=3Ddefa=
ult
> node (nothing else) and I do
>
>  ceph osd crush set osd.0 1 host=3Dfoo rack=3Dmyrack row=3Dfirst root=
=3Ddefault
>
> it will create teh row, rack, and host nodes, and then stick osd.0 in=
side
> host=3Dfoo.
>
> Create-or-move is similar to set except that it won't ever change teh
> weight of the device; only set the initial weight if it has to create=
 it.
> This is used by the upstart hook so that it doesn't inadvertantly clo=
bber
> changes the admin has made.
>
> The next set of commands adjust the map structure. Although people us=
ually
> create a tree structure, in reality the crush map is a DAG (directed
> acyclic graph).
>
>
>   ceph osd crush rm <name> [ancestor]
>
> Will remove an osd or internal node from the, assuming there are no
> children.  With the optional ancestor arg, it will remove only instan=
ces
> under the given ancestor.  Otherwise, all instances are removed.  If =
it is
> a bucket and non-empty, it does nothing.
>
>   ceph osd crush unlink <bucketname> [ancestor]
>
> Is similar, but will let you remove a (or all) link(s) to a bucket ev=
en if
> it is non-empty.
>
>   ceph osd crush move <bucketname> <loc1> [<loc2> ...]
>
> will unlink the bucket from its existing location(s) and link it in a=
 new
> position.
>
>   ceph osd crush link <bucketname> <loc1> [<loc2> ...]
>
> Doesn't touch existing links, only adds a new one.
>
> Finally,
>
>   ceph osd crush add-bucket <bucketname> <type>
>
> is the one command that will create an internal node with no parent.
> Normally this is just used to create the root of the tree (e.g.,
> root=3Ddefault).  Once it is there, then devices can be added beneath=
 with
> it set, add, link, etc. and loc... bit will add any intervening ances=
tors
> that are missing.
>
> This maps cleanly on to the internal data model that CRUSH is using. =
 As
> long as it doesn't bend everyone's mind in uncomfortable ways, I'd li=
ke to
> stick with it (or something like it)... but if there is something her=
e
> that seems wrong, let me know!

I suspect users are going to easily get in trouble without a more
rigid separation between multi-linked and single-linked buckets. It's
probably best if anybody who's gone to the trouble of setting up a DAG
can't wipe it out without being very explicit =97 so for instance "move=
"
should only work against a bucket with a single parent. Rather than
defaulting to all ancestors, removals should (for multiply-linked
buckets) require users to either specify a set of ancestors or to pass
in a "--all" flag.
Also, I suspect that "rm" actually deletes the bucket while "unlink"
simply removes it from all parents (but leaves it in the tree); that
distinction might need to be a little stronger (or is possibly not
appropriate to leave in the CLI?).

You mention that one of the commands "does nothing" under some
circumstances =97 does that mean there's no error? If a command can't b=
e
logically completed it should complain to the user, not just fail
silently.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
