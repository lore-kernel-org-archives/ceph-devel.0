From: Sage Weil <sage@inktank.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:21:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210301419480.13553@cobra.newdream.net>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com> <508EE540.5060303@inktank.com> <CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com> <CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
 <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com> <CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com> <CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com> <CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com>
 <CAJH6TXjE=nQscexL34fQ7RA0sDVc4+QB_O1r39UUAJ5_q87+OQ@mail.gmail.com> <CAMm-wcJox33ZvdfQMT-UN75g5tmGjkbLzPvcbJNmC0-jD1rKVw@mail.gmail.com> <CAJH6TXg=DpmE8O24TPtQwPL3MsEaqqdxBsnhS1zAFmjgRbUYrQ@mail.gmail.com> <50904154.7080004@inktank.com>
 <CAJH6TXhLWzgLS_RK5GNpsNpbzF=QiaEV8-3CwmvG2ZHEWdekQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51246 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934577Ab2J3VVL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 17:21:11 -0400
In-Reply-To: <CAJH6TXhLWzgLS_RK5GNpsNpbzF=QiaEV8-3CwmvG2ZHEWdekQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, =?ISO-2022-JP?Q?=1B$BjOE=5F=1B=28J?= <yuandong1222@gmail.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Tue, 30 Oct 2012, Gandalf Corvotempesta wrote:
> 2012/10/30 Dan Mick <dan.mick@inktank.com>:
> > Generally that's considered OK.  ceph-mon doesn't use very much disk or CPU
> > or network bandwidth.
> 
> In this case, should I reserve some space to ceph-mon (a partition or
> a dedicated disk) or ceph-mon is able to 'share' the osd disk space
> automatically (for example using a directory)?

A common pattern is to give it a directory on the OS/boot volume.  This 
can be a dedicated disk (lots of space for logs) or something carved out 
of another disk (more space for ceph data, but can interfere with ceph-osd 
performance).

sage
