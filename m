From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: Radosgw cannot output Chinese file names
Date: Wed, 13 Jul 2011 11:03:59 -0700
Message-ID: <CA+qbEUOmruR-MOQptaR=fwU6XWv8Ub-OEMhxoUCe4XQukhR4Vg@mail.gmail.com>
References: <CAPE_nyKQz0AR8H6HFe-BiGGoG=+uJpzRT_LfFNhn4OMr5ARH6w@mail.gmail.com>
	<CAC-hyiGeKnCEFXQq_F=2HWRmA7cRiv=uF6+sDCB2TyHYiTXavA@mail.gmail.com>
	<CA+qbEUPYHsJRPY-_ouCDCGLBxCcsy9cvDtwQ3hwuONNtp3ta2g@mail.gmail.com>
	<CAORUGqAPK9Op_hQ6D0fT_x1EsH4YDX2xHyHx+xa0s_UBf-_YEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37426 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab1GMSEC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 14:04:02 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E918FC062
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 11:04:01 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 61F77C065
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 11:04:01 -0700 (PDT)
Received: by fxd18 with SMTP id 18so6219064fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 11:03:59 -0700 (PDT)
In-Reply-To: <CAORUGqAPK9Op_hQ6D0fT_x1EsH4YDX2xHyHx+xa0s_UBf-_YEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Sylar Shen <kimulaaa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 13, 2011 at 10:47 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Wed, Jul 13, 2011 at 10:45, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
>> I guess this means that XML escaping needs to be utf-8-aware, which it
>> isn't now. Probably it's just a matter of recognizing when we are
>> inside a utf-8 character and skipping the bytes comprising that
>> character. JSON escaping probably also needs that change.
>
> Not using standard libraries for standard data formats makes me sad.
>

Well, there are plenty of options for outputting XML:

http://www.nongnu.org/scew/
http://www.grinninglizard.com/tinyxmldocs/index.html
http://xerces.apache.org/

I would like to see RGW converted over to use one of those for
outputting XML. I somehow doubt that it's going to happen any time
soon, though.
Anyway, it looks like the signed/unsigned problem was the cause of the
bug, and fixing that will resolve it.

regards,
Colin
