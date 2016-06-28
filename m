From: Sage Weil <sage@newdream.net>
Subject: Re: How to propose plugin, which uses external lib
Date: Tue, 28 Jun 2016 14:17:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606281414530.8816@piezo.us.to>
References: <CAONhiy5cg+fX-A49shN9FLREpigiTO18vk7t9anM_ZK9Czc5cQ@mail.gmail.com> <CACJqLybFf2G3jQjY5LBnsFtxsbeJ-L3V=+TbeR8h0Y9t_LsmOA@mail.gmail.com> <alpine.DEB.2.11.1606171644370.27611@piezo.novalocal>
 <CAONhiy4xycDrFjxvuz0ubbnmZpzCfcMXW_VL4zabfbE-VsGtrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32945 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbcF1ORe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 10:17:34 -0400
In-Reply-To: <CAONhiy4xycDrFjxvuz0ubbnmZpzCfcMXW_VL4zabfbE-VsGtrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 28 Jun 2016, Alyona Kiselyova wrote:
> In this case I would like to propose isa-l extension for zlib plugin -
> https://github.com/ceph/ceph/compare/master...Ved-vampir:zlib_isal_extension?expand=1
> I think, it would be better to choose plugin type based on processor
> type, this variant is used in branch. To add tuned option on the step
> of plugin loading is possible too, but here we can get an assert in
> case, if processor type is not compatible. Or it will be better
> nevertheless to keep this option and leave error treatment for plugin
> user?

You mean in the case where the user set zlib_use_isal=true but the 
processor doesn't have the right features?  In that case we could just 
ignore the option and fall back.

But what you have here looks fine to me.

Could you perhaps add a unit test that takes some random data 
(/dev/urandom maybe?) and compresses without isal and decompressed 
with, and the other way around, so we have confidence they are 
bit-compatible?

> About isa-l lib files. The only change, that I made to them, is
> renaming asm files to asm.s, but I suspect this restriction can be
> bypassed by some options in make/cmake files? In this way I think it
> would be better to create submodule repo for isa-l lib, because I'm
> still thinking, that just making a copy is not a very good way.

Yeah, I'm happy to go the submodule route.  I expect making cmake handle 
it is doable... Ali?

sage



> -------------------------------
> Best regards,
> Alyona Kiseleva
> 
> 
> On Fri, Jun 17, 2016 at 7:47 PM, Sage Weil <sage@newdream.net> wrote:
> > On Sat, 18 Jun 2016, Haomai Wang wrote:
> >> Cool, I guess it should be behavior better than others in intel platform.
> >>
> >> On Fri, Jun 17, 2016 at 11:51 PM, Alyona Kiselyova
> >> <akiselyova@mirantis.com> wrote:
> >> > Hi,
> >> > I would like to propose a new compression plugin, which is based on
> >> > Isa-l open source library
> >> > (https://github.com/01org/isa-l/tree/master/igzip). I already have a
> >> > code - https://github.com/Ved-vampir/ceph/tree/wip_isal_plugin/src/compressor/isal.
> >> > I see, that there are erasure-code plugin, based on isa-l too. As I
> >> > see, library code is not loaded as submodule repo, like some others.
> >
> > In this case, I assume the inflate/deflate encoding is compatible with
> > zlib.  If that's the case, I think we don't want to treat this as a
> > different compression type, but rather as an optimized
> > implementation of the same type.
> >
> > Not sure the best way to do that, though.  The simplest would probably be
> > to make the ZlibCompressor either use zlib or isal based on an option
> > and/or processor type.
> >
> >> > But if I'm right, I think, it's not the best way to use external code.
> >>
> >> Sorry, why it's not a best way?
> >>
> >> > The question is, what is the right way to use external library in my case?
> >>
> >> I think maybe we could make the whole
> >> repo(https://github.com/01org/isa-l) as submodule and make each dir
> >> used by different compoent?
> >
> > In the crc case we just copied the relevant asm files into the ceph repo.
> > That's probably not the best path, though.  I think we had to make some
> > minor changes to make them build, too.  :/
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
