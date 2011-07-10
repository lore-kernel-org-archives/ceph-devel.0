From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: 0.31
Date: Mon, 11 Jul 2011 00:53:11 +0300
Message-ID: <4E1A1F47.6050202@ufm.su>
References: <4E19837D.7030702@ufm.su>	<Pine.LNX.4.64.1107101411040.10951@cobra.newdream.net>	<4E1A19AC.8060304@ufm.su> <Pine.LNX.4.64.1107101433470.10951@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:52427 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677Ab1GJVxO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Jul 2011 17:53:14 -0400
In-Reply-To: <Pine.LNX.4.64.1107101433470.10951@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/11/2011 12:36 AM, Sage Weil wrote:
> On Mon, 11 Jul 2011, Fyodor Ustinov wrote:
>> On 07/11/2011 12:12 AM, Sage Weil wrote:
>>> Hmm, yeah the 'loaded dup inode' messages should never happen.  They
>>> appear to be just files, though, not directories, so you can safely ignore
>>> them.  The namespace repair will need to clean that up at some point. The
>>> recursive rstat errors you saw are probably just fallout from that, and
>>> can also be ignored.
>> I understand it correctly, that until not  implemented the Feature # 86 I have
>> no way to fix this?
> Right.  Well, this is going to come incrementally.  We'll have a namespace
> scan that fixes some basic issues before there is a full-blown robust
> repair tool.
ok, I'll be waiting impatiently.

> :) Okay.  We're putting locking specific tests in place before trying to
> reproduce #1150 with Amanda, BTW.  It sounds like we need an amanda-like
> workload though anyway, given the issues you're seeing.  How old is this
> fs?  How many times has it been upgraded?
fs has been created not later 2011-06-09.

I'm not sure that I understand correctly "fs upgraded", but cluster 
upgraded to each new ceph versions. I.e. 0.29 -> 0.29.1 -> 0.30 -> 0.31

WBR,
     Fyodor.
