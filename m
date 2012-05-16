From: Felix Feinhals <ff@turtle-entertainment.de>
Subject: Re: MDS crash, wont startup again
Date: Wed, 16 May 2012 10:11:37 +0200
Message-ID: <CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com>
References: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62496 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759678Ab2EPIL7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 04:11:59 -0400
Received: by lbbgm6 with SMTP id gm6so314932lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 01:11:57 -0700 (PDT)
In-Reply-To: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi again,

anything on this Problem? Seems that the only choice for me is to
reinitialize the whole cephfs (mkcephfs...)
:(

2012/5/10 Felix Feinhals <ff@turtle-entertainment.de>:
> Hi List,
>
> we installed a ceph cluster with ceph version 0.46.
> 3 OSDs, 3 MONs and 3 MDSs.
>
> After copying a bunch of files to a ceph-fuse mount all MDS daemons
> crash and now i cant bring them back online.
> I already tried to restart the daemons in different order and also
> removed one OSD, nothing really happened only now we have pgs with
> active+remapped which i think is normal.
> Any hints?
>
