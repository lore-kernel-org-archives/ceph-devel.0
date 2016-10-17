From: Alfredo Deza <adeza@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Mon, 17 Oct 2016 07:08:29 -0400
Message-ID: <CAC-Np1zEB4Tx2XgpS0r9GcM1wHHzjE7jkBbuqQ=BXR8o4cGe+g@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
 <alpine.DEB.2.11.1610061633440.19850@piezo.us.to> <CAEPMp+7EyHBJSDoCZoTPvnd5bBKmsZ_D7UfZ5aYCvS6THLMqSg@mail.gmail.com>
 <26CBB0BA-AF47-40AB-BF35-B50F5A6501A3@Teradata.com> <CAC-Np1xnSoNth7rn-9Cu=ws_=6AwMQP7zKvgu2URi5-dTijndg@mail.gmail.com>
 <alpine.DEB.2.11.1610141858350.23131@piezo.us.to> <CAJ4mKGbaND27MDDZc3dT+a2enM6-t=io68U6vPEca1vP28cJNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36536 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbcJQLIb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2016 07:08:31 -0400
Received: by mail-lf0-f51.google.com with SMTP id b75so282762790lfg.3
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2016 04:08:30 -0700 (PDT)
In-Reply-To: <CAJ4mKGbaND27MDDZc3dT+a2enM6-t=io68U6vPEca1vP28cJNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "Kamble, Nitin A" <Nitin.Kamble@teradata.com>, Andrew Schoen <aschoen@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 14, 2016 at 3:53 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> +1 this idea
>
> On Fri, Oct 14, 2016 at 12:03 PM, Sage Weil <sage@newdream.net> wrote:
>> That seems okay for now.  I think this might have gotten lost in the
>> earlier thread, though:
>>
>> Why don't we take this opportunity to create a ceph-ci.git and lock down
>> ceph.git?
>>
>>  - ceph.git would contain only official branches (master, jewel, etc.)
>>  - ceph-ci.git would have all the branches that need to get build for
>>    ci purposes.
>>  - ci would build everything in ceph.git and ceph-ci.git that doesn't have
>>    a / in it
>>  - if you don't want a branch built, don't push it to either one; push it
>>    to your private clone (which is what you should be doing anyway!)

But nobody does and it is not enforceable :(

>>  - restrict access to ceph.git to core developers (and trusted robots)
>>  - grant access to ceph-ci to a broader set of developers (and robots)
>
> Except for this. Until/unless we find something requiring ceph.git
> access, we should lock down push access and only let code go in via
> Github PRs. Give ceph-ci access to everybody who's allowed in to
> sepia. Why open any gates preemptively if we don't need to? :)

This sounds very similar to the problem we have today. Building
everything in ceph.git and ceph-ci.git would
get us right where we are right now (although not from the start).

Not that we can't adapt these rules and settings as we move forward though.

> -Greg
>
>>
>> Right now, I think this requires that
>>
>> 1) shaman and/or jenkins build branches in both ceph.git and ceph-ci.git
>>
>> and then at our leisure,
>>
>> 2) we delete or move all non-official branches over to ceph-gi.git
>> (prefixing historical branches with old/ or similar), and
>> 3) we restrict ceph.git access.
>>
>> ?
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
