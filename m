From: Damien Churchill <damoxc@gmail.com>
Subject: Re: Determining RBD storage utilization
Date: Thu, 11 Oct 2012 10:15:12 +0100
Message-ID: <CAFtEh-eKUWyb42vhESfEJBdyQdExs6+PQb3Rc1KmdiEaGLK1SA@mail.gmail.com>
References: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
	<CAFtEh-fk1NHEOnmnG1aHpZhiNjApqyrsJOhrTrg9nWKxAiXG2Q@mail.gmail.com>
	<CAPYLRzja7=nnk4pp0=YGL4AhxVKdnM91U1W4GD5qcoORw+oKDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40561 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab2JKJPN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Oct 2012 05:15:13 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1295961wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Oct 2012 02:15:12 -0700 (PDT)
In-Reply-To: <CAPYLRzja7=nnk4pp0=YGL4AhxVKdnM91U1W4GD5qcoORw+oKDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

On 10 October 2012 18:55, Gregory Farnum <greg@inktank.com> wrote:
> I don't know the ext4 internals at all, but filesystems tend to
> require allocation tables of various sorts (for managing extents,
> etc). 7.5GB out of 500GB seems a little large for that metadata, but
> isn't ridiculously so...
>

Just for comparisons sake, Just formatted a spare 500G disk (-8GB swap
partition at the start) as ext4:

$ df -h /dev/sdc2
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc2       451G  198M  428G   1% /mnt
