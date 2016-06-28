From: Alyona Kiselyova <akiselyova@mirantis.com>
Subject: Re: How to propose plugin, which uses external lib
Date: Tue, 28 Jun 2016 16:07:57 +0300
Message-ID: <CAONhiy4xycDrFjxvuz0ubbnmZpzCfcMXW_VL4zabfbE-VsGtrw@mail.gmail.com>
References: <CAONhiy5cg+fX-A49shN9FLREpigiTO18vk7t9anM_ZK9Czc5cQ@mail.gmail.com>
 <CACJqLybFf2G3jQjY5LBnsFtxsbeJ-L3V=+TbeR8h0Y9t_LsmOA@mail.gmail.com> <alpine.DEB.2.11.1606171644370.27611@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32941 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbcF1NH6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 09:07:58 -0400
Received: by mail-oi0-f45.google.com with SMTP id u201so21488150oie.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 06:07:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606171644370.27611@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In this case I would like to propose isa-l extension for zlib plugin -
https://github.com/ceph/ceph/compare/master...Ved-vampir:zlib_isal_extension?expand=1
I think, it would be better to choose plugin type based on processor
type, this variant is used in branch. To add tuned option on the step
of plugin loading is possible too, but here we can get an assert in
case, if processor type is not compatible. Or it will be better
nevertheless to keep this option and leave error treatment for plugin
user?

About isa-l lib files. The only change, that I made to them, is
renaming asm files to asm.s, but I suspect this restriction can be
bypassed by some options in make/cmake files? In this way I think it
would be better to create submodule repo for isa-l lib, because I'm
still thinking, that just making a copy is not a very good way.
-------------------------------
Best regards,
Alyona Kiseleva


On Fri, Jun 17, 2016 at 7:47 PM, Sage Weil <sage@newdream.net> wrote:
> On Sat, 18 Jun 2016, Haomai Wang wrote:
>> Cool, I guess it should be behavior better than others in intel platform.
>>
>> On Fri, Jun 17, 2016 at 11:51 PM, Alyona Kiselyova
>> <akiselyova@mirantis.com> wrote:
>> > Hi,
>> > I would like to propose a new compression plugin, which is based on
>> > Isa-l open source library
>> > (https://github.com/01org/isa-l/tree/master/igzip). I already have a
>> > code - https://github.com/Ved-vampir/ceph/tree/wip_isal_plugin/src/compressor/isal.
>> > I see, that there are erasure-code plugin, based on isa-l too. As I
>> > see, library code is not loaded as submodule repo, like some others.
>
> In this case, I assume the inflate/deflate encoding is compatible with
> zlib.  If that's the case, I think we don't want to treat this as a
> different compression type, but rather as an optimized
> implementation of the same type.
>
> Not sure the best way to do that, though.  The simplest would probably be
> to make the ZlibCompressor either use zlib or isal based on an option
> and/or processor type.
>
>> > But if I'm right, I think, it's not the best way to use external code.
>>
>> Sorry, why it's not a best way?
>>
>> > The question is, what is the right way to use external library in my case?
>>
>> I think maybe we could make the whole
>> repo(https://github.com/01org/isa-l) as submodule and make each dir
>> used by different compoent?
>
> In the crc case we just copied the relevant asm files into the ceph repo.
> That's probably not the best path, though.  I think we had to make some
> minor changes to make them build, too.  :/
>
> sage
