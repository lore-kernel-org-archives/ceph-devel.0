From: Sage Weil <sweil@redhat.com>
Subject: Re: Fwd: question about object replication theory
Date: Thu, 25 Sep 2014 07:26:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409250726341.6593@cobra.newdream.net>
References: <CAPaK2r9eWn=GaEsMabtepjCOtBpvjOyE3vnpcFsUpuC2YJ_XJg@mail.gmail.com> <CAPaK2r-dmpGaO6Y7HHC+CCBocyw9WskvaqKufMNwKTfvA5YH5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38904 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbaIYO0u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 10:26:50 -0400
In-Reply-To: <CAPaK2r-dmpGaO6Y7HHC+CCBocyw9WskvaqKufMNwKTfvA5YH5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yue longguang <yuelongguang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 25 Sep 2014, yue longguang wrote:
> ---------- Forwarded message ----------
> From: yue longguang <yuelongguang@gmail.com>
> Date: Tue, Sep 23, 2014 at 5:37 PM
> Subject: question about object replication theory
> To: ceph-devel@vger.kernel.org
> 
> 
> hi,all
>    take a look at the link ,
> http://www.ceph.com/docs/master/architecture/#smart-daemons-enable-hyperscale
> could you explain  point 2, 3 in that picture.
> 
> 1.
> at point 2,3, before primary writes data  to next osd, where is the
> data?  it is in momory or on disk already?

In memory

> 2. where is the  code of point 2 or 3,  at there  primary distributes
> data to others?

ReplicatedPG::issue_repop()
