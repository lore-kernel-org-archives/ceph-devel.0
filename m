From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Backend ObjectStore engine performance bench with FIO
Date: Tue, 29 Sep 2015 16:06:16 -0400 (EDT)
Message-ID: <727310273.23482377.1443557176794.JavaMail.zimbra@redhat.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03BD7EFC9@SSIEXCH-MB3.ssi.samsung.com> <720951445.22040695.1443205323581.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:54670 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbI2UGS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Sep 2015 16:06:18 -0400
In-Reply-To: <720951445.22040695.1443205323581.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: ceph-devel@vger.kernel.org

Hi James/Haomai/Xiaoxi,

I spent some more time on the fio-objectstore branch, and pushed an update.

In testing, I realized that it was using the io_unit's start time to name the
objects, which meant that every write operation was creating a separate object.
In addition to fixing this to use fio's filenames for object names, I also
added support for the open_file() and close_file() functions. It now creates
objects of the proper size on startup, so read-only jobs will work normally.
It also removes its objects on exit.

On startup, it no longer calls create_collection() if it already exists, so I
was able to re-run fio jobs over and over again without having to clear the
data directory (tested with FileStore and KeyValueStore).

Casey

----- Original Message -----
> Great work James!
> 
> ----- Original Message -----
> > From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
> > To: "Xiaoxi Chen" <xiaoxi.chen@intel.com>, "Casey Bodley"
> > <cbodley@redhat.com>
> > Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> > Sent: Friday, September 25, 2015 1:55:29 PM
> > Subject: Backend ObjectStore engine performance bench with FIO
> > 
> > Hi Xiaoxi,
> > 
> >    With changing the IO mode from aio to sync, we make fio against newstore
> >    works. Even  with sync engine(I am still debugging the aio engine in
> >    newstore with Xiaoxi) in newstore, Newstore still performing the best
> >    among all of backstore engine with our initial setup(Thoroughly test
> >    will
> >    be run soon). Attachment is the initial data we collected for your
> >    reference. Thanks for great help from Xiaoxi from regarding to Newstore
> >    development to support FIO.
> > 
> > Hi Casey,
> >   Let me know if you need any help to put fio-ceph-objectstore into
> >   upstream.
> >   After then , I can commit all of mine into upstream.
> 
> My pull request at https://github.com/ceph/ceph/pull/5943 is still pending.
> If you have patches that you'd like included, I would be happy to pull them
> in; just point me to a branch.
> 
> > 
> >   Thanks,
> >   James
> > 
> 
> Thanks,
> Casey
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
