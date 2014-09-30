From: Gregory Farnum <greg@inktank.com>
Subject: Re: why index (collectionIndex) need a lock?
Date: Tue, 30 Sep 2014 10:23:48 -0700
Message-ID: <CAPYLRzg=y1YKsZAACdwT08UiSVf_wZ8G1TFa7MYLOu8xV-fZyw@mail.gmail.com>
References: <CALZt5jwhBNifcagmsGBZiEC99Q0TvDFPy45f05hidVZedKEK-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:56220 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbaI3RXt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 13:23:49 -0400
Received: by mail-qc0-f171.google.com with SMTP id i17so4210984qcy.30
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 10:23:49 -0700 (PDT)
In-Reply-To: <CALZt5jwhBNifcagmsGBZiEC99Q0TvDFPy45f05hidVZedKEK-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 30, 2014 at 12:08 AM, Nicheal <zay11022@gmail.com> wrote:
> Dear develops,
>
> I go through the files (hashIndex, LFNIndex and CollectionIndex), I
> cannot find any parameters need to grasp a lock. And basically,
> (hashIndex, LFNIndex and CollectionIndex) is used to manage a
> collection of objects.
>
> Thus, just in one case, when the spilt or merge is on going, then
> lookup() path function is called to get the object path. It may obtai=
n
> a wrong path, right?
>
> If so, why not using a state parameter in the class CollectionIndex o=
r
> HashIndex indicating the current state of this collection (split,
> merge on going or none) and grasp a lock when the state changes. Why
> always lock the index before lookup() path or lfn_find()?
>
> Any other reasons?

Well, you've just named why we have the lock =E2=80=94 it's to prevent
multiple users simultaneously making changes to the *filesystem* that
we can't handle. In particular, no simultaneous ops can run against
the same Collection. This is to prevent situations where a reader
comes in and builds up the path for an object it needs to look at,
then a writer creates a new file which initiates collection split and
the reader's path is suddenly invalid.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
