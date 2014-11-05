From: jianpeng <majianpeng@gmail.com>
Subject: Re: Question about =?utf-8?b?VHJhbnNhY3Rpb246OmdldF9kYXRhX2FsaWdubWVudA==?=
Date: Wed, 5 Nov 2014 06:58:14 +0000 (UTC)
Message-ID: <loom.20141105T075526-51@post.gmane.org>
References: <CAMm-wc+v1_yrcHgftxjgNBo1QARP29K5V_mshuANYq=gn8yRXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58964 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbaKEG60 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 Nov 2014 01:58:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1XluXv-0000bV-Sw
	for ceph-devel@vger.kernel.org; Wed, 05 Nov 2014 07:58:24 +0100
Received: from jfdmzpr01-ext.jf.intel.com ([134.134.137.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 07:58:23 +0100
Received: from majianpeng by jfdmzpr01-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 07:58:23 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dong Yuan <yuandong <at> unitedstack.com> writes:

> 
> Hi Sage,
> 
> I am now working with the BP osd: update Transaction encoding, but the
> Transaction::get_data_alignment make me confused.
> 
> This method give the alignment which is used by FileJournal to do
> better buffer build. It calculate the alignment by largest_data_off
> and get_data_offset() while the first is an offset of some object and
> the second is an offset of the transaction encode result. I am not
> sure there is any reason to do calculation between them.
> 
> The code works fine, probably because any result is fine for
> Transaction::get_data_alignment, while
> FileJournal::prepare_single_write can use any alignment value to build
> logical bufferlist.
> 
> Can you give me some explanation?  Thank you.
> 

Hi, i send a pull request to reduce the memcopy cause by unalignment.
https://github.com/ceph/ceph/pull/2803
I think get_data_offset() should not care largest_data_off.

Jianpeng
Thanks! 



