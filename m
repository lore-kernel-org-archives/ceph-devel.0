From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Upcoming 10.2.4
Date: Tue, 11 Oct 2016 12:33:59 +0200
Message-ID: <CABZ+qqnOUTZun6SS4m4VpC5aMQcfvfU6W+9Po=ai-p04zMzvdw@mail.gmail.com>
References: <57FB7494.1010309@dachary.org> <CALe9h7c=doR1DiahZceq2+i-5i=X4rQqXnprwGDTO7mgS8V4Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35533 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbcJKKeq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 06:34:46 -0400
Received: by mail-qt0-f182.google.com with SMTP id f6so9333174qtd.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2016 03:34:42 -0700 (PDT)
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com. [209.85.220.175])
        by smtp.gmail.com with ESMTPSA id o65sm884149qkc.48.2016.10.11.03.34.40
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 03:34:41 -0700 (PDT)
Received: by mail-qk0-f175.google.com with SMTP id f128so25091755qkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2016 03:34:40 -0700 (PDT)
In-Reply-To: <CALe9h7c=doR1DiahZceq2+i-5i=X4rQqXnprwGDTO7mgS8V4Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 11, 2016 at 12:15 PM, John Spray <jspray@redhat.com> wrote:
> On Mon, Oct 10, 2016 at 11:59 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Abhishek,
>>
>> Since you're now release manager, it is my understanding that we'll be a=
sking you if the release should be cut or not. I updated the issue tracking=
 the progress of 10.2.4 accordingly. This is a heads up to let you know we'=
ll most likely ask that question for 10.2.4 some time next week ;-)
>
> I've just done a test run of the following jewel PRs:
> [11389]  mon: don't crash on invalid standby_for_fscid
> [10997]  jewel: multimds: allow_multimds not required when max_mds is
> set in ceph.conf at startup
> [10958]  jewel: client: fix shutdown with open inodes
> [10921]  jewel client: add missing client_lock for get_root
> [10107]  jewel: client: FAILED assert(root_ancestor->qtree =3D=3D __null)
>
> http://pulpito.ceph.com/jspray-2016-10-10_15:27:25-fs-wip-jcsp-backports-=
20161010-distro-basic-mira/
>
> No (real) failures -- can we go ahead and merge all these before 10.2.4?
>
> Cheers,
> John

John/Loic, did "client: kill QuotaTree" fall off the backport radar?

  https://github.com/ceph/ceph/pull/9591/commits/161954bbfeb13d5588668637d5=
258221948128ea
  http://tracker.ceph.com/issues/16066

Tracker's offline now, but AFAICT this wasn't yet backported to jewel.
And this is unfortunate because jewel's ceph-fuse is still crashy with
client quota enabled.

Thanks!

Dan
