From: Sage Weil <sage@inktank.com>
Subject: Re: Bug about issue 5883
Date: Thu, 26 Sep 2013 08:36:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309260834280.12714@cobra.newdream.net>
References: <CAMm-wc+8GJyE1Bj6t06N+1T2c+cSzZFnSOG4qg7SSxf_6VQcCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39605 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3IZPgB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 11:36:01 -0400
In-Reply-To: <CAMm-wc+8GJyE1Bj6t06N+1T2c+cSzZFnSOG4qg7SSxf_6VQcCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On Thu, 26 Sep 2013, Dong Yuan wrote:
> Hello, Sage.
> 
> I meet the same bug as #5883. It is happy to know that the bug is
> fixed, but although I spent lots of time to try to get why, I still
> couldn't understand the reason.
> 
> Is there any race conditions? Or which threads? I guess the threads
> about this bug are Pipe.reader and DispatchQueue.entry, But I am not
> sure.

First, we need to carry the ref through teh function in case another 
thread (reader *or* writer) gets a socket error and tears down the socket.

Second, we need to hold mds_lock to avoid races with other mds code when 
looking at the Session*.

Hope that helps!
sage

> 
> Maybe you can give me more details.
> 
> Thank you very much.
> 
> -- 
> Dong Yuan
> Email:yuandong1222@gmail.com
> 
> 
