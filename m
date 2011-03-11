From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Facing some basic stability issues
Date: Fri, 11 Mar 2011 09:16:21 -0800
Message-ID: <AANLkTimYbz_VUW3dEafuX4SJtEStPmYXHD=uTh83JNwt@mail.gmail.com>
References: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
	<41CFF52D45D542C8A45E8590301D5557@gmail.com>
	<1299853883.15120.20.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46729 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab1CKRQZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 12:16:25 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7A478C064
	for <ceph-devel@vger.kernel.org>; Fri, 11 Mar 2011 09:16:23 -0800 (PST)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2A39CC062
	for <ceph-devel@vger.kernel.org>; Fri, 11 Mar 2011 09:16:23 -0800 (PST)
Received: by eyx24 with SMTP id 24so986442eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 11 Mar 2011 09:16:21 -0800 (PST)
In-Reply-To: <1299853883.15120.20.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in
Cc: ceph-devel@vger.kernel.org

On Fri, Mar 11, 2011 at 6:31 AM, Ajit K Jena <ajit@iitb.ac.in> wrote:
> Hi Greg,
>
> I found that the mds process dies during the weird 'untar'
> behavior. I am trying to analyze the logs. May be I will
> find something there.
Can you send us the backtrace? It should be printed out at the end of
the mds log. :)

An untar should be safe so I'm not sure why it would crash, but the
backtrace will give us something to work with!
-Greg
