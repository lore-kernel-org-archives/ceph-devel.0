From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Tue, 1 Feb 2011 13:44:04 -0800
Message-ID: <AANLkTinJ6RWM6L9hF6yJ5KYEs3qYEwvY0EaZFCcHL-t1@mail.gmail.com>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
	<AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
	<1291418749.4879.319.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
	<1291734873.4879.347.camel@sale659.sandia.gov>
	<AANLkTi=wo0LxhsKTSpRAMRc=Owb6wfV3D8=fYTxR+BMR@mail.gmail.com>
	<1296595866.23762.226.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53326 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1BAVoH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 16:44:07 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 21555C064
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 13:44:07 -0800 (PST)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id C1713C062
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 13:44:06 -0800 (PST)
Received: by ewy5 with SMTP id 5so3474261ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 13:44:05 -0800 (PST)
In-Reply-To: <1296595866.23762.226.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 1, 2011 at 1:31 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> I've just lightly tested current stable branch, commit 0f3198e8c63.
>
> For me both problems seem to still exist.
Well that's a bummer.

> I'm running 4 osds per host on 4 hosts, 1 mon, 1 mds, 64 clients.
>
> For me a "ls" on the file system root from one of
> the clients still doesn't complete until the dd commands
> running on each client complete.
>
> Also, it is still true for me if I truncate all the files
> to zero from one of the clients, then write them again,
> one file per client, that second set of writes goes very
> slow.
>
> Am I maybe testing the wrong commit?
Nope, that commit should do it.

What version of the client software are you running? I'll have to look
over the change logs to see if maybe there are changes in there that
would impact this as well. Also my test environment is smaller than
yours; I'll endeavor to look this over again on a larger one with more
clients and see if I can spot any extra interactions causing problems.
-Greg
