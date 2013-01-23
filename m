From: Neil Levine <neil.levine@inktank.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 20:06:47 -0800
Message-ID: <CANygib98gsC32hO8nidzs4uWdaiGprWBcDWiA22XS6N5hWD7Cg@mail.gmail.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
	<50FEDE7A.5070307@cs.utah.edu>
	<CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
	<alpine.DEB.2.00.1301221514010.17154@cobra.newdream.net>
	<CACkq2mqNqa5ujAPh=OHcSb1UW=0DWzS-gjPt21mmaqGAXdMFKA@mail.gmail.com>
	<CANygib-D3-V5TDV1ZZhFOkvfpD9Z-9a0+aFnW074QF8L2yEcvw@mail.gmail.com>
	<CACkq2mrYKObqbVxbOnP2_bw2Ajzk7g7YEB3WhkCY9Ph2vbS+LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45]:42173 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab3AWEGs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 23:06:48 -0500
Received: by mail-vb0-f45.google.com with SMTP id p1so4029859vbi.18
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 20:06:47 -0800 (PST)
In-Reply-To: <CACkq2mrYKObqbVxbOnP2_bw2Ajzk7g7YEB3WhkCY9Ph2vbS+LA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Xing Lin <xinglin@cs.utah.edu>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

From my perspective, I want to ensure that we have a script that helps
users get Ceph up and running as quickly as possible so they can play,
explore and evaluate it. With this goal in mind, I would prefer to
lean towards the KISS principle to reduce the potential failure
scenarios which a) deter casual users and b) generate lots of support
overhead.

This might be achieved in a number of ways: by disaggregating the
provisioning (one-time) from configuration (ongoing) hooks which then
allow users to insert their own tools; or, by having a more prescribed
environment which still avoids unnecessarily forcing things like a
security model (password-less SSH) on users.

I think the production-ready aspect of the script should come from how
many use-cases it meets more than the robustness of it, but right now
I think the quality of the script is not good enough for our main
use-case, the first-time evaluator of Ceph.

I should have kicked off this conversation further in advance of our
chat tomorrow but am still interested to hear from other users what
they like/dislike about the script or what other tools they eventually
adopted for their Ceph provisioning or configuration management.

Neil

On Tue, Jan 22, 2013 at 7:43 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> Since you are chatting about ceph-deploy tomorrow, I'll chime in with
> a bit more.
>
> I'm interested in ceph-deploy since it can be a light-weight
> production appropriate installer.  The docs repeatedly warn that
> mkcephfs is not intended for production clusters, and Neil reminds us
> that the expectation is that production clusters will likely use a
> config management tool.  Seems like that is most likely Chef, but I
> know there are others.
>
> I've always wondered "why" mkcephfs isn't suitable.  Looking at the
> Chef recipes and ceph-deploy, my best explanation is that these other
> tools use ceph-disk-prepare to take advantage of GPT and to label the
> disks for Ceph's use.  Then you can use the Upstart scripts to auto
> recognize prepared disks and automatically add them to the cluster.
> This scales a lot better than having to add each disk (assigned to a
> node) in ceph.conf and using /etc/init.d/ceph to stop/start the
> cluster.   It also makes it quite a lot easier to add new OSDs to the
> cluster.  Is that about right?
>
> If that's on the right track, I'm interested in ceph-deploy to achieve
> these goals because at the moment we're not interested in deploying
> Chef (or Puppet), great tools that they are.  Down the road, sure, but
> only once we have some in-house experience/expertise, which we
> currently do not.  Having a standalone tool that is just "simple"
> Python seems like a nice alternative.
>
> Those are my thoughts!
>
>  - Travis
>
> On Tue, Jan 22, 2013 at 7:09 PM, Neil Levine <neil.levine@inktank.com> wrote:
>> We're having a chat about ceph-deploy tomorrow. We need to strike a
>> balance between its being a useful tool for standing up a quick
>> cluster and its ignoring the UNIX philosophy and trying to do to much.
>>
>> My assumption is that for most production operations, or at the point
>> where people decide to invest in Ceph, users will already have
>> selected a parallel execution and/or configuration management tool.
>> Ensuring new or early PoC adopters, who perhaps don't want to wade
>> into the wider-operational frameworks issues, is probably where the
>> tool is best focused.
>>
>> Neil
>>
>> On Tue, Jan 22, 2013 at 3:57 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>>> On Tue, Jan 22, 2013 at 6:14 PM, Sage Weil <sage@inktank.com> wrote:
>>>> On Tue, 22 Jan 2013, Neil Levine wrote:
>>>>> Out of interest, would people prefer that the Ceph deployment script
>>>>> didn't try to handle server-server file copy and just did the local
>>>>> setup only, or is it useful that it tries to be a mini-config
>>>>> management tool at the same time?
>>>>
>>>> BTW, you can also run mkcephfs that way; the man page will let you run
>>>> individual steps and do the remote execution parts yourself.
>>>>
>>>> But I'm also curious what people think of the 'normal' usage... anyone?
>>>>
>>>> sage
>>>>
>>>
>>> While I am interested to see where ceph-deploy goes, I do think
>>> mkcephfs in its current form is quite useful.  It does allow you to
>>> stand up decent size clusters with relative ease and is fairly fast.
>>> It has also come quite a ways since since the pre-argonaut form -- the
>>> recent --mkfs additions coupled with the auto-mounting in
>>> /etc/init.d/ceph is pretty slick.  It was a nice discovery for me last
>>> week, as I hadn't created a cluster from scratch since 0.50 or so.
>>>
>>>  - Travis
