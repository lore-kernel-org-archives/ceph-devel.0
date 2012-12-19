From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Striped images and cluster misbehavior
Date: Wed, 19 Dec 2012 14:53:44 +0300
Message-ID: <CABYiri96WTFLy9usyy_3LNzUxSWC7pBrhUgit2gp5bCziw7pkQ@mail.gmail.com>
References: <CABYiri-uqJ3sJt-pnV24EG60T6PGL7K+QvhSwE-=OnEG1R6W_A@mail.gmail.com>
 <CABYiri_5ww+RBdXM0CVEU9+WcHveXdQEJ6ymcp_-K9hgO_o=QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:53233 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab2LSLyG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 06:54:06 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so1911138oag.17
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 03:54:04 -0800 (PST)
In-Reply-To: <CABYiri_5ww+RBdXM0CVEU9+WcHveXdQEJ6ymcp_-K9hgO_o=QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Please take a look at the log below, this is slightly different bug -
both osd processes on the node was stuck eating all available cpu
until I killed them. This can be reproduced by doing parallel export
of different from same client IP using both ``rbd export'' or API
calls - after a couple of wrong ``downs'' osd.19 and osd.27 finally
stuck. What is more interesting, 10.5.0.33 holds most hungry set of
virtual machines, eating constantly four of twenty-four HT cores, and
this node fails almost always, Underlying fs is an XFS, ceph version
gf9d090e. With high possibility my previous reports are about side
effects of this problem.

http://xdel.ru/downloads/ceph-log/osd-19_and_27_stuck.log.gz

and timings for the monmap, logs are from different hosts, so they may
have a time shift of tens of milliseconds:

http://xdel.ru/downloads/ceph-log/timings-crash-osd_19_and_27.txt

Thanks!
