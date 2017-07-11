From: John Spray <jspray@redhat.com>
Subject: Re: mgr interface for OSDMap
Date: Tue, 11 Jul 2017 10:35:10 +0100
Message-ID: <CALe9h7djDw-s4EFsRNzzXrezuvwU23bQOX053vbe6HO3gC7ZnA@mail.gmail.com>
References: <alpine.DEB.2.11.1707110238540.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36861 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdGKJfc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 05:35:32 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so175200492wrc.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 02:35:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707110238540.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 11, 2017 at 4:27 AM, Sage Weil <sweil@redhat.com> wrote:
> Hey John, can you take a quick look at
>
>         https://github.com/ceph/ceph/pull/16250
>
> and let me know if I'm on the right track?  This successfully gets the
> epoch, so it seems to be basically working.  I didn't the dtor called,
> which makes me a bit suspicious, but otherwise it seems to work fine.
> (Lazy gc?)
>
> It seems a bit weird that all methods are static and we don't use the
> PyObject *self... and instead pass around the _handle value explicitly as
> an argument.  Is that just how it is?  The examples I see seem to all be
> static as well.

Yeah, PyState.cc is a bit hacky.  The interface code started out with
all the access to cluster state being global, and the handle bit went
in later.  I don't think there's anything that would prevent us from
declaring it all as a Python class (defined in C[1]) instead of a list
of module-scope methods.  Then, as you say, we could use the *self in
lieu of the handle.

For the OSDMap I'd be inclined to make the effort to do the C
definition of the class -- that way you don't need capsules, as any
C/C++ stuff can just be defined natively as part of the class.  e.g.
in the example from the docs, we would just have a OSDMap* member of
the noddy_NoddyObject struct.

> The plan is to wrap enough of OSDMap and CrushWrapper that a mgr module
> can exercise the upmap optimizer code and/or make CRUSH changes to run
> Loic's gradient optimization...

I'm on board with the general idea of having an OSDMap wrapper -- the
PyFormatter stuff is great as a catch-all but it makes sense to start
having specialized wrappers for things as big and important as OSDMap.

I suspect we'll do more general purpose stuff with this, so it would
be good to avoid doing deep copies by default when someone grabs a
python OSDMap instance -- I have entertained thoughts about having a
COW-ish interface for cluster maps, with some reference tracking, so
that normally a python caller would just get a reference to the
existing OSDMap instance, and then at the point we're updating it from
the C++ side, we would notice their reference, and do the deep copy at
that point instead.

John


1. https://docs.python.org/2/extending/newtypes.html
