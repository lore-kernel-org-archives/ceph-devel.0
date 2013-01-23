From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 22:43:04 -0500
Message-ID: <CACkq2mrYKObqbVxbOnP2_bw2Ajzk7g7YEB3WhkCY9Ph2vbS+LA@mail.gmail.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
 <50FEDE7A.5070307@cs.utah.edu> <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
 <alpine.DEB.2.00.1301221514010.17154@cobra.newdream.net> <CACkq2mqNqa5ujAPh=OHcSb1UW=0DWzS-gjPt21mmaqGAXdMFKA@mail.gmail.com>
 <CANygib-D3-V5TDV1ZZhFOkvfpD9Z-9a0+aFnW074QF8L2yEcvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58123 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3AWDn0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 22:43:26 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so3169431eaa.5
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 19:43:24 -0800 (PST)
In-Reply-To: <CANygib-D3-V5TDV1ZZhFOkvfpD9Z-9a0+aFnW074QF8L2yEcvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Xing Lin <xinglin@cs.utah.edu>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

Since you are chatting about ceph-deploy tomorrow, I'll chime in with
a bit more.

I'm interested in ceph-deploy since it can be a light-weight
production appropriate installer.  The docs repeatedly warn that
mkcephfs is not intended for production clusters, and Neil reminds us
that the expectation is that production clusters will likely use a
config management tool.  Seems like that is most likely Chef, but I
know there are others.

I've always wondered "why" mkcephfs isn't suitable.  Looking at the
Chef recipes and ceph-deploy, my best explanation is that these other
tools use ceph-disk-prepare to take advantage of GPT and to label the
disks for Ceph's use.  Then you can use the Upstart scripts to auto
recognize prepared disks and automatically add them to the cluster.
This scales a lot better than having to add each disk (assigned to a
node) in ceph.conf and using /etc/init.d/ceph to stop/start the
cluster.   It also makes it quite a lot easier to add new OSDs to the
cluster.  Is that about right?

If that's on the right track, I'm interested in ceph-deploy to achieve
these goals because at the moment we're not interested in deploying
Chef (or Puppet), great tools that they are.  Down the road, sure, but
only once we have some in-house experience/expertise, which we
currently do not.  Having a standalone tool that is just "simple"
Python seems like a nice alternative.

Those are my thoughts!

 - Travis

On Tue, Jan 22, 2013 at 7:09 PM, Neil Levine <neil.levine@inktank.com> wrote:
> We're having a chat about ceph-deploy tomorrow. We need to strike a
> balance between its being a useful tool for standing up a quick
> cluster and its ignoring the UNIX philosophy and trying to do to much.
>
> My assumption is that for most production operations, or at the point
> where people decide to invest in Ceph, users will already have
> selected a parallel execution and/or configuration management tool.
> Ensuring new or early PoC adopters, who perhaps don't want to wade
> into the wider-operational frameworks issues, is probably where the
> tool is best focused.
>
> Neil
>
> On Tue, Jan 22, 2013 at 3:57 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>> On Tue, Jan 22, 2013 at 6:14 PM, Sage Weil <sage@inktank.com> wrote:
>>> On Tue, 22 Jan 2013, Neil Levine wrote:
>>>> Out of interest, would people prefer that the Ceph deployment script
>>>> didn't try to handle server-server file copy and just did the local
>>>> setup only, or is it useful that it tries to be a mini-config
>>>> management tool at the same time?
>>>
>>> BTW, you can also run mkcephfs that way; the man page will let you run
>>> individual steps and do the remote execution parts yourself.
>>>
>>> But I'm also curious what people think of the 'normal' usage... anyone?
>>>
>>> sage
>>>
>>
>> While I am interested to see where ceph-deploy goes, I do think
>> mkcephfs in its current form is quite useful.  It does allow you to
>> stand up decent size clusters with relative ease and is fairly fast.
>> It has also come quite a ways since since the pre-argonaut form -- the
>> recent --mkfs additions coupled with the auto-mounting in
>> /etc/init.d/ceph is pretty slick.  It was a nice discovery for me last
>> week, as I hadn't created a cluster from scratch since 0.50 or so.
>>
>>  - Travis
