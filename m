From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: How to enable the debug symbols
Date: Sun, 15 May 2011 07:46:53 -0500
Message-ID: <77a86a15068ca287fcc7343f071f093e@pl1.haspere.com>
References: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
 <10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
 <BANLkTikCB1gAL-WPGv1u8AZk_OjD4TLgyA@mail.gmail.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:47787 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756374Ab1EOMqx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 15 May 2011 08:46:53 -0400
In-Reply-To: <BANLkTikCB1gAL-WPGv1u8AZk_OjD4TLgyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

 Hi Simon!

 Set your CFLAGS and CXXFLAGS environment variables before calling 
 configure and make.

 Example:
 CFLAGS="-march=native -pipe -ggdb" CXXFLAGS="${CFLAGS}" ./configure
 CFLAGS="-march=native -pipe -ggdb" CXXFLAGS="${CFLAGS}" make
 etc


 Thanks,
 Dyweni


 On Sun, 15 May 2011 20:37:16 +0800, Simon Tian wrote:

> Hi Dyweni,
>
> Can I do this by any options of "./configure"? or JUST modify
> the Makefile manually?
>
> Thx!
> Simon
>

