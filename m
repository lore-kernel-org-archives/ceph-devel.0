From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [ceph-commit] teuthology value error
Date: Tue, 2 Oct 2012 10:06:58 -0700
Message-ID: <CADvuQRF+8OQs2BGmKGe3k=OmZ91a8arD_fdZmLHZhzi1UmNq1g@mail.gmail.com>
References: <CABpo6hJZPKt1p1g4yC+KviC4Wr6OKuffcNGyVL9UeoJe8K+TDA@mail.gmail.com>
 <CAPYLRzice5K7H1W6baizm0EK=J9nAZX4Hm5FcVETB8_ikyDp4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36742 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab2JBRHT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 13:07:19 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so757069qad.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 10:07:18 -0700 (PDT)
In-Reply-To: <CAPYLRzice5K7H1W6baizm0EK=J9nAZX4Hm5FcVETB8_ikyDp4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Lokesh Krishnappa <lokesh.professional.it@gmail.com>, ceph-devel@vger.kernel.org

On Tue, Oct 2, 2012 at 9:56 AM, Gregory Farnum <greg@inktank.com> wrote=
:
>> File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/misc=
=2Epy",
>> line 501, in read_config
>> ctx.teuthology_config.update(new)
>> ValueError: dictionary update sequence element #0 has length 1; 2 is
>> required
> I haven't looked at teuthology much in a while, but the error is
> complaining that you have a list of length 1 that requires length 2.
> I'm pretty sure your problem is that you only have one machine
> available, but the default Ceph task wants 2.

Actually, that error seems to be bubbling up from where it reads
~/.teuthology.yaml -- it expects a file like this:

lock_server: http://foo.example.com/locker/lock
queue_host: bar.example.com
queue_port: 1234

Teuthology doesn't have much in the way of data format enforcement --
it kind of assumes the target audience is programmers, so they can
just dig in.

> Rather more importantly than that, teuthology is a piece of our
> internal infrastructure. We make it available to others, but if you
> plan to use it in your own testing you will need infrastructure of
> your own to run it on =E2=80=94 we have a generic server farm, but al=
so
> "special" machines like a lock server, in addition to the client
> actually running the test. You should not play with it casually.

Hey, I resent that remark!

We *want* outside users for teuthology. That would be awesome.

That would probably also mean needing to split the current "tasks" out
of the teuthology core, so that the core becomes a general-purpose
multi-machine test runner.

But you are correct in that there are a lot of assumptions about the
environment in there. Tread carefully.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
