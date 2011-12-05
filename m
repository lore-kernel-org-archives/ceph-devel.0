From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Mon, 5 Dec 2011 11:03:09 -0800
Message-ID: <CAORUGqCZy+j3MUry7ut=E7YXNiPHLGSqRw5qyqaOKR2=12mjhA@mail.gmail.com>
References: <4EDC0ECF.60805@cs.ucsc.edu> <4EDC1853.5080405@cs.ucsc.edu>
 <Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net> <4EDD1437.4030608@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63678 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab1LETDb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 14:03:31 -0500
Received: by eaak14 with SMTP id k14so4374407eaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2011 11:03:30 -0800 (PST)
In-Reply-To: <4EDD1437.4030608@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org

On Mon, Dec 5, 2011 at 10:57, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Here is the proc/<mds_pid>/fd contents. These contents should reflect an
> idle cluster with no active clients.
...
> root@issdm-23:~# ls -la /proc/1394/fd/
> lrwx------ 1 root root 64 2011-12-05 10:54 10 -> socket:[40002]

Can we get a "sudo lsof -n -p 1394" too? That would tell a little bit
more about what the sockets are actually for..
