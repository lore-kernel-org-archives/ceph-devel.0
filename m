From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: rados pool object listing suckage
Date: Thu, 12 May 2011 10:55:33 -0700
Message-ID: <BANLkTi=q+Ksrp_E1Wecyr5BDDym6qndHSQ@mail.gmail.com>
References: <Pine.LNX.4.64.1105111445100.14296@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40831 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab1ELRzf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 13:55:35 -0400
Received: by fxm17 with SMTP id 17so1259138fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 10:55:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105111445100.14296@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wed, May 11, 2011 at 2:57 PM, Sage Weil <sage@newdream.net> wrote:
> The ability to list objects in rados pools is something we originally
> added to round out the librados interface and to support the requirem=
ents
> of radosgw (S3 and swift both let you list objects in buckets). =A0Th=
e
> current interface is stateless. =A0You iterate over the PGs in the po=
ol, and
> for each one, request up to N objects. =A0The result has up to N resu=
lts and
> (optionally) a cookie to continue and get more objects for that pg.
> Currently, that cookie is a readdir offset from the directory on the
> server.
>
> The problem is that we currently list objects based only on what we h=
ave
> on disk. =A0If the PG is degraded and we're recovery, we miss any obj=
ects
> that aren't yet copied locally.
>
> Because the 'list all objects in a pool' operation consists of many
> smaller requests, and there is no state to associate them, it's hard =
to
> solve this one correctly. =A0The osd _knows_ which objects are missin=
g at
> all times, but it needs to include those in the results in a sane way=
=2E
>
> My original thought was use the low 2^63 values of the offset/cookie =
to
> represent any (potentially) missing objects and use that as an index =
into
> the missing set, and then use the high values to represent the readdi=
r
> offset. =A0That's easy enough to do (and I just did), but because rec=
overy
> is progressing while the client is doing the series of list-objects c=
alls,
> you can get duplicates (client sees an object while it was missing, a=
nd
> also sees it later when it was on disk). =A0Conversely, if a pg start=
s out
> as not degraded, we may return no missing objects, and later return a=
n
> incomplete set of on-disk objects because the primary changed.
>
> This approach can be hacked if the client restarts the whole process =
(for
> a given pg) when the primary changes (because, for any given pg mappi=
ng,
> the missing set will also shrink or stay the same). =A0That will work=
, but
> will potentially return some objects twice.

Can the client keep track of all the objects it has already seen? Then
it could eliminate dups from the result it gets from the server.

You can't track this information on the server because of the obvious
DDOS exploit, but it seems like the client could keep around this
state.

C.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
