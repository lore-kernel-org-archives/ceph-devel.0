From: Sage Weil <sage@newdream.net>
Subject: Re: How to propose plugin, which uses external lib
Date: Fri, 17 Jun 2016 16:47:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606171644370.27611@piezo.novalocal>
References: <CAONhiy5cg+fX-A49shN9FLREpigiTO18vk7t9anM_ZK9Czc5cQ@mail.gmail.com> <CACJqLybFf2G3jQjY5LBnsFtxsbeJ-L3V=+TbeR8h0Y9t_LsmOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:49606 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751768AbcFQQrn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jun 2016 12:47:43 -0400
In-Reply-To: <CACJqLybFf2G3jQjY5LBnsFtxsbeJ-L3V=+TbeR8h0Y9t_LsmOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Alyona Kiselyova <akiselyova@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 18 Jun 2016, Haomai Wang wrote:
> Cool, I guess it should be behavior better than others in intel platform.
> 
> On Fri, Jun 17, 2016 at 11:51 PM, Alyona Kiselyova
> <akiselyova@mirantis.com> wrote:
> > Hi,
> > I would like to propose a new compression plugin, which is based on
> > Isa-l open source library
> > (https://github.com/01org/isa-l/tree/master/igzip). I already have a
> > code - https://github.com/Ved-vampir/ceph/tree/wip_isal_plugin/src/compressor/isal.
> > I see, that there are erasure-code plugin, based on isa-l too. As I
> > see, library code is not loaded as submodule repo, like some others.

In this case, I assume the inflate/deflate encoding is compatible with 
zlib.  If that's the case, I think we don't want to treat this as a 
different compression type, but rather as an optimized 
implementation of the same type.

Not sure the best way to do that, though.  The simplest would probably be 
to make the ZlibCompressor either use zlib or isal based on an option 
and/or processor type.

> > But if I'm right, I think, it's not the best way to use external code.
> 
> Sorry, why it's not a best way?
> 
> > The question is, what is the right way to use external library in my case?
> 
> I think maybe we could make the whole
> repo(https://github.com/01org/isa-l) as submodule and make each dir
> used by different compoent?

In the crc case we just copied the relevant asm files into the ceph repo.  
That's probably not the best path, though.  I think we had to make some 
minor changes to make them build, too.  :/

sage
