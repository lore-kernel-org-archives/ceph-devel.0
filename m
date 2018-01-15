From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Mon, 15 Jan 2018 18:04:27 +0100
Message-ID: <20180115170427.GA10256@mailware>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <CAJE9aOPs8KPYQRprJ_iFcTGnkafnSkY_yswc5YennZox7-P1BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:51536 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965295AbeAORKR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 15 Jan 2018 12:10:17 -0500
Content-Disposition: inline
In-Reply-To: <CAJE9aOPs8KPYQRprJ_iFcTGnkafnSkY_yswc5YennZox7-P1BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

On Tue, Jan 16, 2018 at 12:53:22AM +0800, kefu chai wrote:
> On Mon, Jan 15, 2018 at 11:49 PM, kefu chai <tchaikov@gmail.com> wrote:
> > [..]
> > i am preparing a change to prototype this approach. the downside of it is:
> >
> > - we need to include a placeholder structure in buffer.h for
> > seastar::tempoary_buffer<char>. and cast it to
> > seastar::tempoary_buffer<char> in buffer.cc . otherwise we need to
> > include seastar headers in librados.
> 
> - we cannot store the crc map along with the raw class anymore. this
> might be a show stopper.

https://github.com/ceph/ceph/pull/18906
There, already fixed it.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
