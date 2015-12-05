From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, Clang refuses to compile a test
Date: Sat, 5 Dec 2015 13:56:11 +0100
Message-ID: <5662DEEB.7060208@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl> <5660106F.90202@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57705 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbbLEM4l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Dec 2015 07:56:41 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id C717B15340A
	for <ceph-devel@vger.kernel.org>; Sat,  5 Dec 2015 13:56:38 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:bcd9:eb4c:91af:378c] (unknown [IPv6:2001:4cb8:3:1:bcd9:eb4c:91af:378c])
	by smtp.digiware.nl (Postfix) with ESMTP id 10AB8153418
	for <ceph-devel@vger.kernel.org>; Sat,  5 Dec 2015 13:56:21 +0100 (CET)
In-Reply-To: <5660106F.90202@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

src/test/erasure-code/TestErasureCodeIsa.cc

contains snippets, function definition like:

buffer::ptr enc[k + m];
   // create buffers with a copy of the original data to be able to 
compare it after decoding
   {
     for (int i = 0; i < (k + m); i++) {

Clang refuses because the [k+m] size in not known at compiletime.
Suggesting to tempate this.

How would one normally handle this?

I've temporarily made it fixed size 1024*1024.
But I'm not sure if that is big enough

--WjW

