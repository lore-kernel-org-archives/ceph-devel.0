From: Tommi Virtanen <tv@inktank.com>
Subject: Re: librbd: error finding header
Date: Thu, 12 Jul 2012 09:00:14 -0700
Message-ID: <CADvuQRH0+AxZEsCePMeRr7Oyr1NWZgwVUEA-OxmKDZwLCBCp-w@mail.gmail.com>
References: <4FFA6F35.4040102@bashkirtsev.com> <4FFA9E6D.7030207@inktank.com>
 <4FFAB273.6030605@bashkirtsev.com> <4FFB193D.7050207@inktank.com>
 <4FFBA108.3010009@bashkirtsev.com> <4FFBB74F.2050702@inktank.com>
 <4FFBF505.4050400@bashkirtsev.com> <4FFC8BBC.6010807@hq.newdream.net>
 <4FFE3939.2000000@bashkirtsev.com> <4FFE5567.3060807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36782 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030320Ab2GLQAg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 12:00:36 -0400
Received: by pbbrp8 with SMTP id rp8so3917729pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 09:00:36 -0700 (PDT)
In-Reply-To: <4FFE5567.3060807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Jul 11, 2012 at 9:41 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> You're right about the object name - you can get its offset in the
> image that way. Since rbd is thin-provisioned, however, the highest
> index object might not be the highest possible object. When you first
> create an image, only the header object is created.

You can re-create it with a size that's known to be greater than the
old size (put in a terabyte extra, or something), and then use a
partitioning tool to see what the disk layout really is, and resize
based on that.
