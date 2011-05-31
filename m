From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: compile error for ceph-0.28.*.tar.gz
Date: Tue, 31 May 2011 11:52:35 -0600
Message-ID: <4DE52AE3.9020900@sandia.gov>
References: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
 <20110531172458.GA12733@dreamer>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:39876 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1EaRxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 13:53:09 -0400
In-Reply-To: <20110531172458.GA12733@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Simon Tian <aixt2006@gmail.com>, ceph-devel@vger.kernel.org

Tommi Virtanen wrote:
> On Tue, May 31, 2011 at 02:23:10PM +0800, Simon Tian wrote:
>> hi  folks,
>>
>>     When I make ceph after ./configure,  error comes both in 0.28.1
>> and 0.28.2 like bellow:
>>
>> ./include/encoding.h:294: error: no matching function for call to
>> ?.ecode(PG::Log::Entry&, ceph::buffer::list::iterator&)?
>> ./include/encoding.h:42: note: candidates are: void decode(__u8&,
>> ceph::buffer::list::iterator&)
>> ... ...
>>
>> ./include/encoding.h:406: error: no matching function for call to
>> ?.ncode(const PG::Missing::item&, ceph::buffer::list&)?
>> ./include/encoding.h:42: note: candidates are: void encode(const
>> __u8&, ceph::bufferlist&)
>> ... ...
>>
>>
>> I just download them from http://ceph.newdream.net/download/ceph-0.28.*.tar.gz
> 
> I just built ceph-0.28.2 from the tarball, with ./configure && make,
> and had no problems.
> 
> What operating system and version are you trying to build it on?
> 
> Does the output really say "?.ecode" and "?.ncode"? Those seem really
> odd. Can this machine successfully compile bigger projects, e.g. the
> Linux kernel? That's a good general test of hardware reliability..
> 
FWIW, I believe I saw such errors on RHEL 5 due to it having
boost v1.33.1, while Ceph needs v1.34 or newer to get statechart.

-- Jim


