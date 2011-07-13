From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Radosgw cannot output Chinese file names
Date: Wed, 13 Jul 2011 10:47:34 -0700
Message-ID: <CAORUGqAPK9Op_hQ6D0fT_x1EsH4YDX2xHyHx+xa0s_UBf-_YEw@mail.gmail.com>
References: <CAPE_nyKQz0AR8H6HFe-BiGGoG=+uJpzRT_LfFNhn4OMr5ARH6w@mail.gmail.com>
 <CAC-hyiGeKnCEFXQq_F=2HWRmA7cRiv=uF6+sDCB2TyHYiTXavA@mail.gmail.com> <CA+qbEUPYHsJRPY-_ouCDCGLBxCcsy9cvDtwQ3hwuONNtp3ta2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59369 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964805Ab1GMRry (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 13:47:54 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so5810441iwn.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 10:47:54 -0700 (PDT)
In-Reply-To: <CA+qbEUPYHsJRPY-_ouCDCGLBxCcsy9cvDtwQ3hwuONNtp3ta2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Sylar Shen <kimulaaa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 13, 2011 at 10:45, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> I guess this means that XML escaping needs to be utf-8-aware, which it
> isn't now. Probably it's just a matter of recognizing when we are
> inside a utf-8 character and skipping the bytes comprising that
> character. JSON escaping probably also needs that change.

Not using standard libraries for standard data formats makes me sad.
