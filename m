From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: rbd and Metaserver
Date: Thu, 5 May 2011 10:18:52 -0700
Message-ID: <BANLkTimmq_HyjBjuqRPZh=2jfm1V0Bt_-Q@mail.gmail.com>
References: <4DC2DB6E.9010500@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36306 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1EERSz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 13:18:55 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 15253C065
	for <ceph-devel@vger.kernel.org>; Thu,  5 May 2011 10:18:55 -0700 (PDT)
Received: from mail-bw0-f46.google.com (mail-bw0-f46.google.com [209.85.214.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id B11CDC063
	for <ceph-devel@vger.kernel.org>; Thu,  5 May 2011 10:18:54 -0700 (PDT)
Received: by bwz15 with SMTP id 15so2018803bwz.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 10:18:53 -0700 (PDT)
In-Reply-To: <4DC2DB6E.9010500@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Thu, May 5, 2011 at 10:16 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi!
>
> If I only want to use rbd - requires metaserver?
>

rbd does not require mds running.

Yehuda
