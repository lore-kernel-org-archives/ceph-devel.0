From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Why can't I subscribe ceph-devel mailing list?
Date: Tue, 22 Nov 2016 12:21:34 +0100
Message-ID: <20161122112134.GB26997@predictor>
References: <4d701771.a856.1588ba3e28c.Coremail.xxhdx1985126@163.com>
 <20161122110430.GA26997@predictor>
 <6b2baf88.aaa4.1588bb6754a.Coremail.xxhdx1985126@163.com>
 <bebd4d7d-f260-bc22-6bf2-8ee6699b97ef@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:44016 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932933AbcKVLTU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 06:19:20 -0500
Content-Disposition: inline
In-Reply-To: <bebd4d7d-f260-bc22-6bf2-8ee6699b97ef@brockmann-consult.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 22, 2016 at 12:12:39PM +0100, Peter Maloney wrote:
> Your last email was filled with junk binary characters (or some other
> language?)... maybe you need to fix your client or send in text/plain
> only, without any footers or extra text.

This is a known bug of Majordomo, if the message is encoded in Base64
(regardless of whether it's text/plain, text/html or multipart/alternative),
Majordomo adds its own signature anyway without re-encoding, making that
signature to appear as garbage.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
