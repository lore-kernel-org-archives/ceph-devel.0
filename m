From: Wes Dillingham <wes_dillingham@harvard.edu>
Subject: Re: [ceph-disk]how to specific cluster name when active an osd?
Date: Thu, 13 Oct 2016 11:31:24 -0400
Message-ID: <CAMrEFZ4xjXPizoQuAsdzO+GeQ7rhs-UCW3wj1OG0Rdp3UTDpfg@mail.gmail.com>
References: <CAKZcxgdYG__w1f_YEu0fcO8CpRWejBnadRP-giVLY7MC7QYsEw@mail.gmail.com>
Reply-To: wes_dillingham@harvard.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:35510 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbcJMRJ4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 13:09:56 -0400
Received: by mail-it0-f48.google.com with SMTP id e203so130758966itc.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 10:09:42 -0700 (PDT)
In-Reply-To: <CAKZcxgdYG__w1f_YEu0fcO8CpRWejBnadRP-giVLY7MC7QYsEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I know this doesnt answer your question directly but instead of
bothering naming our clusters something other than ceph we name all of
our clusters "ceph" and then just concern ourselves with creating the
/etc/ceph/XXXX.conf and the /etc/ceph/XXX.client.user.keyring on our
clients to differentiate one cluster from the other.

This works well for our situation where only clients are "aware" of
two clusters and helps us avoid the mucky situation of having
non-standard cluster names - as that proved to be a real pain point
for deployment. Good luck

On Wed, Oct 12, 2016 at 3:18 AM, Jaze Lee <jazeltq@gmail.com> wrote:
> If using systemd, we can not specific cluster name when active an osd...
> Is there a way to send in the ENV CLUSTER by systemctl?
>
>
> Thank a lot
>
> --
> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Respectfully,

Wes Dillingham
wes_dillingham@harvard.edu
Research Computing | Infrastructure Engineer
Harvard University | 38 Oxford Street, Cambridge, Ma 02138 | Room 210
