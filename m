From: Sage Weil <sage@newdream.net>
Subject: Re: Is anyone aware of bluestor exploding all the time ?
Date: Mon, 25 Sep 2017 02:38:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709250237170.16664@piezo.novalocal>
References: <636422C8-A440-4CA8-A7A2-E7F947EA350D@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:43816 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdIYCic (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Sep 2017 22:38:32 -0400
In-Reply-To: <636422C8-A440-4CA8-A7A2-E7F947EA350D@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Kusmierz <tom.kusmierz@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 25 Sep 2017, Tomasz Kusmierz wrote:
> hi guys just FYI:
> http://tracker.ceph.com/issues/21318

I just followed up on the bug.  It looks like a bug in the rocksdb caching 
code...  let's confirm that and see if it's been fixed upstream.

Thanks!
sage

