From: Samuel Just <sam.just@inktank.com>
Subject: Re: Striped images and cluster misbehavior
Date: Sun, 30 Dec 2012 10:56:21 -0800
Message-ID: <CA+4uBUYfvhZcApiOOebQ360q-JWsAdfWshOFLQXKu7aqFe+0-g@mail.gmail.com>
References: <CABYiri-uqJ3sJt-pnV24EG60T6PGL7K+QvhSwE-=OnEG1R6W_A@mail.gmail.com>
	<CABYiri_5ww+RBdXM0CVEU9+WcHveXdQEJ6ymcp_-K9hgO_o=QQ@mail.gmail.com>
	<CABYiri96WTFLy9usyy_3LNzUxSWC7pBrhUgit2gp5bCziw7pkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:64605 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2L3S4W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Dec 2012 13:56:22 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so12038302vbb.7
        for <ceph-devel@vger.kernel.org>; Sun, 30 Dec 2012 10:56:22 -0800 (PST)
In-Reply-To: <CABYiri96WTFLy9usyy_3LNzUxSWC7pBrhUgit2gp5bCziw7pkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry for the delay.  A quick look at the log doesn't show anything
obvious... Can you elaborate on how you caused the hang?
-Sam

On Wed, Dec 19, 2012 at 3:53 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Please take a look at the log below, this is slightly different bug -
> both osd processes on the node was stuck eating all available cpu
> until I killed them. This can be reproduced by doing parallel export
> of different from same client IP using both ``rbd export'' or API
> calls - after a couple of wrong ``downs'' osd.19 and osd.27 finally
> stuck. What is more interesting, 10.5.0.33 holds most hungry set of
> virtual machines, eating constantly four of twenty-four HT cores, and
> this node fails almost always, Underlying fs is an XFS, ceph version
> gf9d090e. With high possibility my previous reports are about side
> effects of this problem.
>
> http://xdel.ru/downloads/ceph-log/osd-19_and_27_stuck.log.gz
>
> and timings for the monmap, logs are from different hosts, so they may
> have a time shift of tens of milliseconds:
>
> http://xdel.ru/downloads/ceph-log/timings-crash-osd_19_and_27.txt
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
