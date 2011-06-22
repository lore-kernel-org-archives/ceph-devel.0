From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: MDS Stuck In Replay
Date: Wed, 22 Jun 2011 13:34:55 -0700
Message-ID: <288F18A8-50F5-4791-9186-B7450CDD91B4@hq.newdream.net>
References: <B828A4C02BE12543ACDFCF7EB0C693C67886252F0F@NC-SVR-09.netelligent.com> <Pine.LNX.4.64.1106211545340.28760@cobra.newdream.net> <B828A4C02BE12543ACDFCF7EB0C693C67886252F3B@NC-SVR-09.netelligent.com> <18981DE9-A820-44EF-B5F7-B18C14C16C96@hq.newdream.net> <B828A4C02BE12543ACDFCF7EB0C693C6788625305D@NC-SVR-09.netelligent.com> <C87D8994-9C53-4712-8351-9C09FEFABAA6@hq.newdream.net> <B828A4C02BE12543ACDFCF7EB0C693C678862530A6@NC-SVR-09.netelligent.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49294 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618Ab1FVUe4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 16:34:56 -0400
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C678862530A6@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Jun 22, 2011, at 1:30 PM, Mark Nigh wrote:

> Thanks for your help.
> 
> I think I can summarize my problems due to the inconsistent version I was running between nodes. Once I used your git steps below, I have consistent versions and I am working. My mds is in active state and my clients are able to read/write to the f/s.
Oh good, that's what I wanted to hear. Sorry you stumbled into a broken commit there. :(


> Thanks!!
Welcome. :) Let us know if you run into any other issues;  we love our testers!
-Greg