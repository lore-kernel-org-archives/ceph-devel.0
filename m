From: Sage Weil <sweil@redhat.com>
Subject: RE: chooseleaf may cause some unnecessary pg migrations
Date: Thu, 15 Oct 2015 12:14:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510150715020.16833@cobra.newdream.net>
References: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.00.1510130940400.6589@cobra.newdream.net> <FF8D83DAE5DF57468726B79904321E06047273@H3CMLB12-EX.srv.huawei-3com.com> <alpine.DEB.2.00.1510140714580.6589@cobra.newdream.net>
 <FF8D83DAE5DF57468726B79904321E06047677@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43445 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbbJOTOU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Oct 2015 15:14:20 -0400
In-Reply-To: <FF8D83DAE5DF57468726B79904321E06047677@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 15 Oct 2015, Xusangdi wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, October 14, 2015 10:18 PM
> > To: xusangdi 11976 (RD)
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: chooseleaf may cause some unnecessary pg migrations
> >
> > On Wed, 14 Oct 2015, Xusangdi wrote:
> > > Please see inline.
> > >
> > > > -----Original Message-----
> > > > From: ceph-devel-owner@vger.kernel.org
> > > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > > > Sent: Wednesday, October 14, 2015 12:45 AM
> > > > To: xusangdi 11976 (RD)
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: Re: chooseleaf may cause some unnecessary pg migrations
> > > >
> > > > Hi Sangdi,
> > > >
> > > > On Tue, 13 Oct 2015, Xusangdi wrote:
> > > > > Hi Sage,
> > > > >
> > > > > Recently when I was learning about the crush rules I noticed that
> > > > > the step chooseleaf may cause
> > > > some unnecessary pg migrations when OSDs are outed.
> > > > > For example, for a cluster of 4 hosts with 2 OSDs each, after
> > > > > host1(osd.2, osd.3) is down, the
> > > > mapping differences would be like this:
> > > > > pgid    before <-> after        diff    diff_num
> > > > > 0.1e    [5, 1, 2] <-> [5, 1, 7]         [2]     1
> > > > > 0.1f    [0, 7, 3] <-> [0, 7, 4]         [3]     1
> > > > > 0.1a    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> > > > > 0.5     [6, 3, 1] <-> [6, 0, 5]         [1, 3]  2
> > > > > 0.4     [5, 6, 2] <-> [5, 6, 0]         [2]     1
> > > > > 0.7     [3, 7, 0] <-> [7, 0, 4]         [3]     1
> > > > > 0.6     [2, 1, 7] <-> [0, 7, 4]         [1, 2]  2
> > > > > 0.9     [3, 4, 0] <-> [5, 0, 7]         [3, 4]  2
> > > > > 0.15    [2, 6, 1] <-> [6, 0, 5]         [1, 2]  2
> > > > > 0.14    [3, 6, 5] <-> [7, 4, 1]         [3, 5, 6]       3
> > > > > 0.17    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> > > > > 0.16    [0, 4, 2] <-> [0, 4, 7]         [2]     1
> > > > > 0.11    [4, 7, 2] <-> [4, 7, 1]         [2]     1
> > > > > 0.10    [0, 3, 6] <-> [0, 7, 4]         [3, 6]  2
> > > > > 0.13    [1, 7, 3] <-> [1, 7, 4]         [3]     1
> > > > > 0.a     [0, 2, 7] <-> [0, 7, 4]         [2]     1
> > > > > 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> > > > > 0.b     [2, 5, 7] <-> [4, 7, 0]         [2, 5]  2
> > > > > 0.18    [7, 2, 4] <-> [7, 4, 0]         [2]     1
> > > > > 0.f     [2, 7, 5] <-> [6, 4, 0]         [2, 5, 7]       3
> > > > > Changed pg ratio: 30 / 32
> > > > >
> > > > > I tried to change the code (please see
> > > > > https://github.com/ceph/ceph/pull/6242) and after the
> > > > modification the result would be like this:
> > > >
> > > > Can you describe the reasoning behind the change?  I can't make
> > > > sense of it.  The recursive call is still picking just 1 item, but
> > > > it looks like it is always choosing a device in for slot 0 and not the current slot in the caller.  I'm not
> > sure how that could generate a correct result.
> > > >
> > > From my understanding, the argument 'outpos' of
> > > crush_choose_firstn(...) is always set to 0 for 'choose firstn' and
> > > the first step of 'chooseleaf firstn' (you may check its caller, i.e.
> > > crush_do_rule(...), that the variable 'j' there is always 0). So in
> > > fact the code modification won't change anything for these steps. It will only affect the recursive call.
> > > And it this call, 'rep'(and 'r') is independent from its caller, which
> > > means it's only used to indicate the replica number(the start value of
> > > 'rep' should be 1 less than 'numrep'), but is not related to result
> > > position. Since 'outpos' is correctly passed to the recursive call,
> > > the result would be put in the right slot, not slot 0.
> >
> > Okay, I undertstand now.  Thanks!
> >
> > > The current code set the starting value of 'r' based on the slot
> > > number, which means the algorithm may generate a different result even
> > > when only the slot number changes, which I believe is not what we want
> > > for replicated pools. For example, 0.14 [3, 6, 5] <-> [7, 4, 1], after
> > > ods.3 is down and out, the pg on osd.6 is transferred to osd.7 because
> > > the starting value of 'r' is changed(probably from 1 to 0), and so is
> > > the pg from osd.5 to osd.4. Though it looks like that all of these
> > > extra migrations are always within the same chosen bucket, they are
> > > unnecessary. If we set the starting value of 'rep'(and 'r') to be a
> > > fixed value(e.g. 0), the results would be stable.
> >
> > Yeah, that makes sense.
> >
> > The only problem I see is the collision check here:
> >
> >       https://github.com/ceph/ceph/pull/6242/files#diff-0df13ad294f6585c322588cfe026d701R497
> >
> > For most maps your change isn't problematic because devices only appear once in the hierarchy, but if
> > an item does appear twice, we may choose it twice and not detect the dup.
> >
> > Perhaps leaving the argument alone and simply changing the for loop to
> >
> >       for (rep = 0; rep < (numrep - outpos) && count > 0 ; rep++) {
> >
> > would do the trick?
> >
> Well I believe it actually will detect the dup as 'numrep' and 'outpos' 
> are two different arguments and 'outpos' is correctly passed, so the 
> 'for loop' you marked for detecting collision will check all previously 
> selected items.

Yep, right again.

> I have read the post about current CRUSH behavior and thanks for that 
> detailed explanation. However, the prerequisite there is the crushmap is 
> changed(some item is reweighted), while in the current implementation 
> the crushmap remains untouched for quite a long time after some devices 
> fail. And because of this, I think the code change can make the pg 
> migrations to be optimal when osds become down. When the crushmap does 
> change, like you said, the extra migrations would be unavoidable. 
> Anyway, as I really cannot find it, could you give me some tip about how 
> or when the crushmap would get modified automatically? Thank you!

I think the situation is the same: when the osd is marked "out" the 
weight[i] value goes to zero and we will reject it at 

https://github.com/ceph/ceph/pull/6242/files#diff-0df13ad294f6585c322588cfe026d701R535

(An osd goes down but not out doesn't have any effect on crush--the ceph 
code just filters those osds out of the crush result.)

So, anyway, yes: this looks like a good change.  One thing that would be 
great would be a way to quantify how much it improves things.

The next step is to introduce a tunable that makes this behavior optional 
(as we can't break/change previous mappings).  That means introducing a 
new field in crush/crush.h for the tunable, adding accessors in 
CrushWrapper, introducing a new 'jewel' preset that sets it that way (and 
making jewel the new 'optimal'), modifying crushtool.cc with an argument 
to modify the tunable, modifying CrushCompiler to both spit out the 
tunable if it's non-default and to parse it if its specified in the input, 
etc.

If you're comfortable with those changes, it would be great if you 
could do this part.  If not, I can take care of it!

Thanks-
sage


> 
> ---Sangdi
> 
> > Thanks!
> > sage
> >
> >
> >
> > > The quality of distribution could be assured by the hashed value x,
> > > since it's dependent on pgid. A simple test result for a relatively
> > > large cluster is as followings, which from my view is similar with
> > > that of the current code:
> > >
> > > crushtool -o crushmap --build --num_osds 64 host straw2 4 rack straw2
> > > 4 root straw2 0
> > >
> > > crushtool --test -i crushmap --num_rep 3 --show-utilization rule 0
> > > (replicated_ruleset), x = 0..1023, numrep = 3..3 rule 0
> > > (replicated_ruleset) num_rep 3 result size == 3: 1024/1024
> > >   device 0:              stored : 57     expected : 48
> > >   device 1:              stored : 39     expected : 48
> > >   device 2:              stored : 44     expected : 48
> > >   device 3:              stored : 42     expected : 48
> > >   device 4:              stored : 45     expected : 48
> > >   device 5:              stored : 42     expected : 48
> > >   device 6:              stored : 45     expected : 48
> > >   device 7:              stored : 48     expected : 48
> > >   device 8:              stored : 43     expected : 48
> > >   device 9:              stored : 38     expected : 48
> > >   device 10:             stored : 44     expected : 48
> > >   device 11:             stored : 52     expected : 48
> > >   device 12:             stored : 54     expected : 48
> > >   device 13:             stored : 59     expected : 48
> > >   device 14:             stored : 53     expected : 48
> > >   device 15:             stored : 53     expected : 48
> > >   device 16:             stored : 42     expected : 48
> > >   device 17:             stored : 56     expected : 48
> > >   device 18:             stored : 49     expected : 48
> > >   device 19:             stored : 42     expected : 48
> > >   device 20:             stored : 56     expected : 48
> > >   device 21:             stored : 51     expected : 48
> > >   device 22:             stored : 59     expected : 48
> > >   device 23:             stored : 34     expected : 48
> > >   device 24:             stored : 43     expected : 48
> > >   device 25:             stored : 52     expected : 48
> > >   device 26:             stored : 46     expected : 48
> > >   device 27:             stored : 44     expected : 48
> > >   device 28:             stored : 43     expected : 48
> > >   device 29:             stored : 57     expected : 48
> > >   device 30:             stored : 53     expected : 48
> > >   device 31:             stored : 52     expected : 48
> > >   device 32:             stored : 46     expected : 48
> > >   device 33:             stored : 42     expected : 48
> > >   device 34:             stored : 59     expected : 48
> > >   device 35:             stored : 50     expected : 48
> > >   device 36:             stored : 48     expected : 48
> > >   device 37:             stored : 47     expected : 48
> > >   device 38:             stored : 52     expected : 48
> > >   device 39:             stored : 56     expected : 48
> > >   device 40:             stored : 38     expected : 48
> > >   device 41:             stored : 40     expected : 48
> > >   device 42:             stored : 52     expected : 48
> > >   device 43:             stored : 43     expected : 48
> > >   device 44:             stored : 41     expected : 48
> > >   device 45:             stored : 51     expected : 48
> > >   device 46:             stored : 43     expected : 48
> > >   device 47:             stored : 46     expected : 48
> > >   device 48:             stored : 42     expected : 48
> > >   device 49:             stored : 47     expected : 48
> > >   device 50:             stored : 51     expected : 48
> > >   device 51:             stored : 54     expected : 48
> > >   device 52:             stored : 56     expected : 48
> > >   device 53:             stored : 46     expected : 48
> > >   device 54:             stored : 47     expected : 48
> > >   device 55:             stored : 48     expected : 48
> > >   device 56:             stored : 42     expected : 48
> > >   device 57:             stored : 40     expected : 48
> > >   device 58:             stored : 58     expected : 48
> > >   device 59:             stored : 53     expected : 48
> > >   device 60:             stored : 41     expected : 48
> > >   device 61:             stored : 44     expected : 48
> > >   device 62:             stored : 52     expected : 48
> > >   device 63:             stored : 60     expected : 48
> > >
> > > > Perhaps you can share the osd tree output so we can see how your map it structured?
> > > >
> > > The architecture is pretty simple:
> > > ID WEIGHT  TYPE NAME      UP/DOWN REWEIGHT PRIMARY-AFFINITY
> > > -5 8.00000 root root
> > > -1 2.00000     host host0
> > >  0 1.00000         osd.0       up  1.00000          1.00000
> > >  1 1.00000         osd.1       up  1.00000          1.00000
> > > -2 2.00000     host host1
> > >  2 1.00000         osd.2     down        0          1.00000
> > >  3 1.00000         osd.3     down        0          1.00000
> > > -3 2.00000     host host2
> > >  4 1.00000         osd.4       up  1.00000          1.00000
> > >  5 1.00000         osd.5       up  1.00000          1.00000
> > > -4 2.00000     host host3
> > >  6 1.00000         osd.6       up  1.00000          1.00000
> > >  7 1.00000         osd.7       up  1.00000          1.00000
> > >
> > > And the rule used if you were interested:
> > > rule replicated_ruleset {
> > >         ruleset 0
> > >         type replicated
> > >         min_size 1
> > >         max_size 10
> > >         step take root
> > >         step chooseleaf firstn 0 type host
> > >         step emit
> > > }
> > >
> > > Also all the tunables are default values and I'm running the master from several days ago.
> > >
> > > > It is normal for some mappings to have multiple items change, as I've described previously on this
> > list.
> > > > It's a result of the fact that we're considering totally independent
> > > > series of items, but whether we accept a choice also depends on the
> > > > previous choices (we do not allow dups).. which means that you get echo effects in later slots
> > when we make a different choice in earlier slots.
> > > >
> > > As I described in the previous section, I think these extra migrations
> > > is not caused by collisions. And IMO the ideal result when an osd fails should be a simple shifting, just
> > as you illustrated in the CRUSH paper:
> > >
> > > 1 2 3 4 5 6
> > > a b c d e f ...
> > >
> > > b fails ==>
> > >
> > > 1 2 3 4 5 6
> > > a c d e f g ...
> > >
> > > ----------
> > > Best regards,
> > > Sangdi
> > >
> > > > Thanks!
> > > > sage
> > > >
> > > >
> > > > > pgid    before <-> after        diff    diff_num
> > > > > 0.1e    [5, 0, 3] <-> [5, 0, 7]         [3]     1
> > > > > 0.1f    [0, 6, 3] <-> [0, 6, 4]         [3]     1
> > > > > 0.1a    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> > > > > 0.5     [6, 3, 0] <-> [6, 0, 5]         [3]     1
> > > > > 0.4     [5, 7, 2] <-> [5, 7, 0]         [2]     1
> > > > > 0.7     [3, 7, 1] <-> [7, 1, 5]         [3]     1
> > > > > 0.6     [2, 0, 7] <-> [0, 7, 4]         [2]     1
> > > > > 0.9     [3, 5, 1] <-> [5, 1, 7]         [3]     1
> > > > > 0.15    [2, 6, 1] <-> [6, 1, 4]         [2]     1
> > > > > 0.14    [3, 7, 5] <-> [7, 5, 1]         [3]     1
> > > > > 0.17    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> > > > > 0.16    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> > > > > 0.11    [4, 6, 3] <-> [4, 6, 0]         [3]     1
> > > > > 0.10    [0, 3, 6] <-> [0, 6, 5]         [3]     1
> > > > > 0.13    [1, 7, 3] <-> [1, 7, 5]         [3]     1
> > > > > 0.a     [0, 3, 6] <-> [0, 6, 5]         [3]     1
> > > > > 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> > > > > 0.b     [2, 4, 6] <-> [4, 6, 1]         [2]     1
> > > > > 0.18    [7, 3, 5] <-> [7, 5, 1]         [3]     1
> > > > > 0.f     [2, 6, 5] <-> [6, 5, 1]         [2]     1
> > > > > Changed pg ratio: 20 / 32
> > > > >
> > > > > Currently the only defect I can see from the change is that the
> > > > > chance for a given pg to successfully
> > > > choose required available OSDs might be a bit lower compared with
> > > > before. However, I believe it will cause problems only when the
> > > > cluster is pretty small and degraded. And in that case, we can still make it workable by tuning some
> > of the crushmap parameters such as chooseleaf_tries.
> > > > >
> > > > > Anyway I'm not sure if it would raise any other issues, could you
> > > > > please review it and maybe give me
> > > > some suggestions? Thank you!
> > > > >
> > > > > ----------
> > > > > Best regards,
> > > > > Sangdi
> > > > >
> > > > > ------------------------------------------------------------------
> > > > > ----
> > > > > ---------------------------------------------------------------
> > > > > ????????????????????????????????????????
> > > > > ????????????????????????????????????????
> > > > > ????????????????????????????????????????
> > > > > ???
> > > > > This e-mail and its attachments contain confidential information
> > > > > from H3C, which is intended only for the person or entity whose
> > > > > address is listed above. Any use of the information contained
> > > > > herein in any way (including, but not limited to, total or partial
> > > > > disclosure, reproduction, or dissemination) by persons other than
> > > > > the intended
> > > > > recipient(s) is prohibited. If you receive this e-mail in error,
> > > > > please notify the sender by phone or email immediately and delete it!
> > > > > N?????r??y??????X???v???)?{.n?????z?]z????ay?????j ??f???h??????w???
> > > >
> > > > ???j:+v???w???????? ????zZ+???????j"????i
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > ----------------------------------------------------------------------
> > > ---------------------------------------------------------------
> > > ????????????????????????????????????????
> > > ????????????????????????????????????????
> > > ????????????????????????????????????????
> > > ???
> > > This e-mail and its attachments contain confidential information from
> > > H3C, which is intended only for the person or entity whose address is
> > > listed above. Any use of the information contained herein in any way
> > > (including, but not limited to, total or partial disclosure,
> > > reproduction, or dissemination) by persons other than the intended
> > > recipient(s) is prohibited. If you receive this e-mail in error,
> > > please notify the sender by phone or email immediately and delete it!
> > > N?????r??y??????X???v???)?{.n?????z?]z????ay?????j ??f???h??????w???
> >
> > ???j:+v???w???????? ????zZ+???????j"????i
> -------------------------------------------------------------------------------------------------------------------------------------
> ????????????????????????????????????????
> ????????????????????????????????????????
> ????????????????????????????????????????
> ???
> This e-mail and its attachments contain confidential information from H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!
> 
