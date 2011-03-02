From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 2 Mar 2011 15:20:02 -0800
Message-ID: <AANLkTikg0n23FdcRc-r=aLbT3UbfORu6xhFP+WQ-6KL2@mail.gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
	<75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
	<1297893011.25491.124.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
	<Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
	<1297957574.25491.152.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
	<1298483538.25491.233.camel@sale659.sandia.gov>
	<460F770CEB1C499F8B87593762171483@gmail.com>
	<1298489031.25491.250.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
	<1299079262.4750.19.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
	<1299099295.4750.41.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
	<1299103144.4750.49.camel@sale659.sandia.gov>
	<1299106628.4750.62.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58091 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab1CBXUE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 18:20:04 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 467F0C069
	for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2011 15:20:04 -0800 (PST)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id E59E7C068
	for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2011 15:20:03 -0800 (PST)
Received: by ewy6 with SMTP id 6so182494ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2011 15:20:02 -0800 (PST)
In-Reply-To: <1299106628.4750.62.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 2, 2011 at 2:57 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> On Wed, 2011-03-02 at 14:59 -0700, Jim Schutt wrote:
>>
>> On Wed, 2011-03-02 at 14:45 -0700, Sage Weil wrote:
>> > On Wed, 2 Mar 2011, Jim Schutt wrote:
>> > >
>> > > On Wed, 2011-03-02 at 10:10 -0700, Sage Weil wrote:
>> > > > > I'll see if I see the same signature with master,
>> > > > > and post logs.
>> > > >
>> > > > Thanks! =A0Keep us posted.
>> > >
>> > > Hmmm, I'm not having much luck with master (commit
>> > > 0fb5ef2ce92 + extra debugging) on a 96-osd filesystem;
>> > > lots of dead OSDs during startup.
>> >
>> > Commit c916905a8a14029653aae45f0a9fb6c9b4c39e05 (master) should fi=
x this.
>>
>> I try it out, thanks!
>
> I don't get any more core files with master commit 67355779ecc.
> Now my cosds just die - no stack trace in the log, no core
> file, nothing in syslog or dmesg ...
Another commit got in that changed the logging behavior slightly --
which log file are you opening?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
