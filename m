From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: rbd layering
Date: Tue, 1 Feb 2011 23:34:45 -0800
Message-ID: <AANLkTikArvio88WVi1-Fx72UwE7__rnzORKDsHcLGVay@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
	<AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36581 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab1BBHeq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 02:34:46 -0500
Received: by wyb28 with SMTP id 28so7568756wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 23:34:45 -0800 (PST)
In-Reply-To: <AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Feb 1, 2011 at 11:13 PM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
>
> On Mon, Jan 31, 2011 at 10:08 PM, Sage Weil <sage@newdream.net> wrote=
:
> > One idea we've talked a fair bit about is layering RBD images. =A0T=
he idea
> > would be to create a new image in O(1) time that mirrors on old ima=
ge and
> > get copy-on-write type semantics, like a writeable snapshot.
> >
> > We've come up with a few different approaches for doing this, each =
with
> > somewhat different performance characteristics. =A0The main conside=
ration is
> > that RBD images do not (currently) have an "allocation table." =A0I=
mage data
> > is simply striped over objects (that may or may not exist). =A0You =
read the
> > object for a given block to see if it exists; if it doesn't (a "hol=
e"),
> > the content is defined to be zero-filled.
>
> Have we thought about the hash table based approach yet? Where every
> block gets hashed and we only store one copy for each? I guess this i=
s
> basically how git works, except instead of fixed-size blocks, it
> tracks variable-sized blobs. This is also how ZFS dedupe works.
>

Long ago there were some plans to introduce content addressable
storage at the osd level. We will probably want to have something like
that sometime, but we'd rather introduce it as a proper osd/rados
feature and not as some hack tailored specifically for rbd. I don't
want to start digging into the architectural requirements, but my gut
feeling says that it's not going to be trivial (as an understatement)
and its benefits compared to what we'd lose (simplicity, performance)
are marginal.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
