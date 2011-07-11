From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: boost recoverystate handle_log fault
Date: Mon, 11 Jul 2011 12:38:23 -0700
Message-ID: <4E1B512F.8060000@hq.newdream.net>
References: <CABAwU-aHS_P+wJ-TqHfVbBj7ZmsDtSvnr5t1zXTKaqSrBX4HQA@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60773 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757644Ab1GKTiX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 15:38:23 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2F41DC065
	for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 12:38:23 -0700 (PDT)
Received: from [192.168.107.170] (ip-64-111-111-107.dreamhost.com [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 268C1C062
	for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 12:38:23 -0700 (PDT)
In-Reply-To: <CABAwU-aHS_P+wJ-TqHfVbBj7ZmsDtSvnr5t1zXTKaqSrBX4HQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The messenger errors probably indicate that that OSD's peers are down.
The boost errors are a result of the OSD receiving a log message in the
GetInfo state.  This indicates a bug in the peering state machine.  Is
there a way that you could get us more complete logs?  I need an idea
of what happened to cause the erroneous log message.

Thanks!
-Sam

On 07/11/2011 07:26 AM, huang jun wrote:
> hi,all
> I use ceph v0.30 on 31osds, on linux 2.6.37
> after i set up the whole cluster, there are many (10) osds going down
> because the cosd process was killed, and we can provide the osd log
> in attach file "osd-failed".
>
> and this phenomenon occured once a week ago.At first we fixed it
> by just rebuilding the cluster, but this time we will not try that method.
> we want to find where lead this failed happen.
> why did the simplemessenger always send RETSETSESSION?
> whar lead the boost:recovery failed ? can you give some constructive advices?
>
> thanks in advance

