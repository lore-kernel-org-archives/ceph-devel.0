From: Florian Haas <florian@hastexo.com>
Subject: Re: librbd: error finding header
Date: Mon, 09 Jul 2012 18:30:56 +0200
Message-ID: <4FFB0740.3050709@hastexo.com>
References: <4FFA6F35.4040102@bashkirtsev.com> <4FFA9E6D.7030207@inktank.com> <4FFAB273.6030605@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58113 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2GIQbB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:31:01 -0400
Received: by bkwj10 with SMTP id j10so6186679bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 09:31:00 -0700 (PDT)
In-Reply-To: <4FFAB273.6030605@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

On 07/09/12 12:29, Vladimir Bashkirtsev wrote:
> On 09/07/12 18:33, Dan Mick wrote:
>> Vladimir: you can do some investigation with the rados command.  What
>> does
>> rados -p rbd ls show you?
> Rather long list of:
> rb.0.11.000000002786
> rb.0.d.0000000054a2
> rb.0.6.000000002eb5
> rb.0.d.000000008294
> rb.0.13.000000000377
> rb.0.e.000000000629
> rb.0.6.000000002756
> rb.0.d.000000006156
> rb.0.d.000000009b82
> rb.0.5.000000000c9e
> rb.0.d.0000000080ba
> rb.0.f.000000000e75
> rb.0.6.00000000ab4f
> rb.0.d.0000000048e4
> rb.0.d.000000005f67
> rb.0.13.0000000014ad
> rb.0.d.00000000e074
> rb.0.f.000000001a4b
> rb.0.13.0000000004a3
> ...
> 
> How to find out to which image these objects belong?

"rbd info" would tell you the block prefix for the image you're looking
at. Or does that command give you an "error opening image" message as well?

Cheers,
Florian
