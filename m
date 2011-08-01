From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 13:14:40 -0700
Message-ID: <CAORUGqAVM=d1wz_U7wt5X2ueq9JO_BrcXgD1b_RqrXnHOHGfZw@mail.gmail.com>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
 <CA+qbEUPiy5equ8Y2PmY-Ua28eFiaWjEAAdWc52CgOe73oYYCkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36910 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab1HAUPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 16:15:00 -0400
Received: by vxh35 with SMTP id 35so4458868vxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 13:15:00 -0700 (PDT)
In-Reply-To: <CA+qbEUPiy5equ8Y2PmY-Ua28eFiaWjEAAdWc52CgOe73oYYCkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 1, 2011 at 11:04, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
> One thing that neither Jansson nor JSON-C offer, to my knowledge, is
> the ability to do SAX-style parsing of a JSON document. In other
> words, to set up a bunch of function pointers and have them called at
> various points during parsing. I did not personally feel the need for
> this, since my JSON data was small enough that memory consumption was
> a non-issue, but I guess someone else might. If Jansson wants to do
> something to differentiate itself from the competition, that could be
> it.

As far as my experience with various JSON encoders/decoders goes,
that's the typical case. Most libraries cater for the simple case of
being able to hold the full object in memory, and if that is not
possible, it's more typical to go for an approach where the input is a
stream of objects, one per line (e.g. Twitter streaming and all kinds
of mapreduce solutions do this).

Jansson's differentiating factor is that it's significantly simpler
than json-c. My buddies use it for embedded development.

> I am not sure how I feel about using libraries to output (as opposed
> to parse) JSON. There is a point where a task becomes simple enough
> that using more libraries is an anti-pattern. For example, would you
> use a library to output CSV? Probably not. The only thing you have to
> remember is to properly do escaping.

I would. The doublequote rules of CSV are a pain to get right, and I
don't want to keep rewriting unit tests for that particular wheel.
Ceph has already had multiple bugs of this kind.
