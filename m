From: Sage Weil <sweil@redhat.com>
Subject: Re: [GSoC2016] BlueStore SMR Support
Date: Mon, 14 Mar 2016 08:40:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603140840080.14377@cpach.fuggernut.com>
References: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com> <alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com> <CAKP7xVyMGJO-8YjkqhhFPoiY_608ByKY8+c_Y=7W-tcmDBADsg@mail.gmail.com> <alpine.DEB.2.11.1603140816560.14377@cpach.fuggernut.com>
 <CAKP7xVzKuwy9sP2PqJ-sHT0cygj6byuVX62=oUgnVCNpjWaE9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36546 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965093AbcCNMkg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Mar 2016 08:40:36 -0400
In-Reply-To: <CAKP7xVzKuwy9sP2PqJ-sHT0cygj6byuVX62=oUgnVCNpjWaE9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giridhar Yasa <giridhar.yasa@flipkart.com>
Cc: Shehbaz Jaffer <shehbazjaffer007@gmail.com>, ceph-devel@vger.kernel.org

On Mon, 14 Mar 2016, Giridhar Yasa wrote:
> On Mon, Mar 14, 2016 at 5:47 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Sun, 13 Mar 2016, Giridhar Yasa wrote:
> >> On Fri, Mar 11, 2016 at 8:20 PM, Sage Weil <sweil@redhat.com> wrote:
> >> >
> >> > On Fri, 4 Mar 2016, Shehbaz Jaffer wrote:
> >> >
> >> > > 2) Will scope of project be to build an allocator on a simulator for
> >> > > SMR Drives? Or will I get actual HDDs to work with? In case of
> >> > > simulators, will the project involve building a simulator on disksim?
> >> >
> >> > I seem to remember hearing something about a dm module that simulated SMR,
> >> > but I'm not sure.  We may also be able to get some SMR disks to play
> >> > with--I'll reach out to our drive vendor friends.
> >>
> >> Would that be https://github.com/hgst/libzbc from HGST?
> >
> > Yes.
> >
> > I'm not sure about a disk simulator or actual drive availability,
> > though.
> 
> libzbc has an emulation mode that can use files or block devices to
> emulate SMR disk zones.

Oh, perfect!

sage
