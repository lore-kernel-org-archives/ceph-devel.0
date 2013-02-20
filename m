From: Bo-Syung Yang <bsedyang@gmail.com>
Subject: Re: crush reweight
Date: Wed, 20 Feb 2013 13:41:54 -0800
Message-ID: <CAM8T9Zpj-JuNKAFs_E_w+7D2V1O027i31iBr+t1g0zSTGJL3Bg@mail.gmail.com>
References: <CAM8T9Zpv6YTz335Q+mfzOrJ1WGY2G4DZcP=d6yYpGMhB+AqPHg@mail.gmail.com>
	<alpine.DEB.2.00.1302201238180.26205@cobra.newdream.net>
	<CAM8T9Zp0zEsgpr2ihFebcyZSeZnjJbkZG3Q8+_3R4cJNn-ny1Q@mail.gmail.com>
	<alpine.DEB.2.00.1302201318030.26205@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:36151 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab3BTVly (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 16:41:54 -0500
Received: by mail-ia0-f172.google.com with SMTP id l29so5659701iag.31
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 13:41:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302201318030.26205@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 20, 2013 at 1:19 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 20 Feb 2013, Bo-Syung Yang wrote:
>> On Wed, Feb 20, 2013 at 12:39 PM, Sage Weil <sage@inktank.com> wrote:
>> > On Wed, 20 Feb 2013, Bo-Syung Yang wrote:
>> >> Hi,
>> >>
>> >> I have a crush map (may not be practical, but just for demo) applied
>> >> to a two-host cluster (each host has two OSDs) to test "ceph osd crush
>> >> reweight":
>> >>
>> >> # begin crush map
>> >>
>> >> # devices
>> >> device 0 sdc-host0
>> >> device 1 sdd-host0
>> >> device 2 sdc-host1
>> >> device 3 sdd-host1
>> >>
>> >> # types
>> >> type 0 device
>> >> type 1 pool
>> >> type 2 root
>> >>
>> >> # buckets
>> >> pool one {
>> >>         id -1
>> >>         alg straw
>> >>         hash 0  # rjenkins1
>> >>         item sdc-host0 weight 1.000
>> >>         item sdd-host0 weight 1.000
>> >>         item sdc-host1 weight 1.000
>> >>         item sdd-host1 weight 1.000
>> >> }
>> >>
>> >> pool two {
>> >>         id -2
>> >>         alg straw
>> >>         hash 0  # rjenkins1
>> >>         item sdc-host0 weight 1.000
>> >>         item sdd-host0 weight 1.000
>> >>         item sdc-host1 weight 1.000
>> >>         item sdd-host1 weight 1.000
>> >> }
>> >>
>> >> root root-for-one {
>> >>         id -3
>> >>         alg straw
>> >>         hash 0  # rjenkins1
>> >>         item one weight 4.000
>> >>         item two weight 4.000
>> >> }
>> >>
>> >> root root-for-two {
>> >>         id -4
>> >>         alg straw
>> >>         hash 0  # rjenkins1
>> >>         item one weight 4.000
>> >>         item two weight 4.000
>> >> }
>> >>
>> >> rule data {
>> >>         ruleset 0
>> >>         type replicated
>> >>         min_size 1
>> >>         max_size 4
>> >>         step take root-for-one
>> >>         step choose firstn 0 type pool
>> >>         step choose firstn 1 type device
>> >>         step emit
>> >> }
>> >>
>> >> rule metadata {
>> >>         ruleset 1
>> >>         type replicated
>> >>         min_size 1
>> >>         max_size 4
>> >>         step take root-for-one
>> >>         step choose firstn 0 type pool
>> >>         step choose firstn 1 type device
>> >>         step emit
>> >> }
>> >>
>> >> rule rbd {
>> >>         ruleset 2
>> >>         type replicated
>> >>         min_size 1
>> >>         max_size 4
>> >>         step take root-for-two
>> >>         step choose firstn 0 type pool
>> >>         step choose firstn 1 type device
>> >>         step emit
>> >> }
>> >>
>> >>
>> >> After crush map applied, the osd tree looks as:
>> >>
>> >> # id    weight  type name       up/down reweight
>> >> -4      8       root root-for-two
>> >> -1      4               pool one
>> >> 0       1                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >> -2      4               pool two
>> >> 0       1                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >> -3      8       root root-for-one
>> >> -1      4               pool one
>> >> 0       1                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >> -2      4               pool two
>> >> 0       1                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >>
>> >>
>> >> Then, I reweight osd.0 (device sdc-host0) in crush map to 5 through:
>> >>
>> >>  ceph osd crush reweight sdc-host0 5
>> >>
>> >> I found the osd tree with the weight changes:
>> >>
>> >> # id    weight  type name       up/down reweight
>> >> -4      8       root root-for-two
>> >> -1      4               pool one
>> >> 0       5                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >> -2      4               pool two
>> >> 0       1                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >> -3      12      root root-for-one
>> >> -1      8               pool one
>> >> 0       5                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >> -2      4               pool two
>> >> 0       1                       osd.0   up      1
>> >> 1       1                       osd.1   up      1
>> >> 2       1                       osd.2   up      1
>> >> 3       1                       osd.3   up      1
>> >>
>> >> My question is why only pool one's weight changed, but not pool two.
>> >
>> > Currently the reweight (and most of the other) command(s) assume there is
>> > only one instance of each item in the hierarchy, and only operate on the
>> > first one they see.
>> >
>> > What is your motivation for having the pools appear in two different
>> > trees?
>> >
>> > sage
>> >
>>
>> By defining different pools in different trees, it allows me setting
>> different rules for sharing certain OSDs or/and isolating the others
>> for the different pools (created through ceph osd pool create ...)
>
> Right.
>
> Well, we can fix some of the commands (like reweight) to update all
> instances of X.  Others won't always work well in this world (like the
> set/move commands)...
>
> sage

I appreciate that crush reweight command can be fixed to update all
instances of X.  I will also pay close attention to other commands, as
you mentioned.

Thanks,

Edward
