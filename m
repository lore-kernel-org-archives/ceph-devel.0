From: Giridhar Yasa <giridhar.yasa@flipkart.com>
Subject: Re: [GSoC2016] BlueStore SMR Support
Date: Mon, 14 Mar 2016 18:03:46 +0530
Message-ID: <CAKP7xVzKuwy9sP2PqJ-sHT0cygj6byuVX62=oUgnVCNpjWaE9A@mail.gmail.com>
References: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
	<alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com>
	<CAKP7xVyMGJO-8YjkqhhFPoiY_608ByKY8+c_Y=7W-tcmDBADsg@mail.gmail.com>
	<alpine.DEB.2.11.1603140816560.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33837 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965112AbcCNMdr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 08:33:47 -0400
Received: by mail-ob0-f173.google.com with SMTP id ts10so173899922obc.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 05:33:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603140816560.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Shehbaz Jaffer <shehbazjaffer007@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Mar 14, 2016 at 5:47 PM, Sage Weil <sweil@redhat.com> wrote:
> On Sun, 13 Mar 2016, Giridhar Yasa wrote:
>> On Fri, Mar 11, 2016 at 8:20 PM, Sage Weil <sweil@redhat.com> wrote:
>> >
>> > On Fri, 4 Mar 2016, Shehbaz Jaffer wrote:
>> >
>> > > 2) Will scope of project be to build an allocator on a simulator for
>> > > SMR Drives? Or will I get actual HDDs to work with? In case of
>> > > simulators, will the project involve building a simulator on disksim?
>> >
>> > I seem to remember hearing something about a dm module that simulated SMR,
>> > but I'm not sure.  We may also be able to get some SMR disks to play
>> > with--I'll reach out to our drive vendor friends.
>>
>> Would that be https://github.com/hgst/libzbc from HGST?
>
> Yes.
>
> I'm not sure about a disk simulator or actual drive availability,
> though.

libzbc has an emulation mode that can use files or block devices to
emulate SMR disk zones.

Giridhar

--
Giridhar Yasa | Flipkart Engineering | http://www.flipkart.com/
