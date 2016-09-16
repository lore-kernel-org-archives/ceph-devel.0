From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Snapshots of consistency groups
Date: Fri, 16 Sep 2016 13:37:52 -0400
Message-ID: <CA+aFP1ABzFvX8HUyQBm4eFyAPDv7K5Qo7NyGogeHuuAaoLqNNw@mail.gmail.com>
References: <CA+hcxJS8sbBUjYieM3+86XG5KX9ouP8dO+9iFwtsHoO+v=9KWA@mail.gmail.com>
 <CA+aFP1BAw7yzPYT5z6D6Wq6tPvd-Y9meDxfgqcVi0GBg0eR3+g@mail.gmail.com>
 <CA+aFP1BZPHhiBan4r5N7x0LfHofmkrUWgLPD0MrS-uV6WrF4Kg@mail.gmail.com>
 <CA+hcxJSO8TXSRV4bgTZVkrFsjX1wpW3DYFKqaDnWhA3+7gE_eg@mail.gmail.com>
 <CA+aFP1BMK1=daZpUFdNDJ+i8+nfQt42ahCXVaxy9fWdAY-kXwA@mail.gmail.com>
 <CA+hcxJT9JdVz-ZQz_SXwAPbbHoNegNSVfPk6h8kzmDo0xs0BJQ@mail.gmail.com>
 <20160819124813.GB17630@gmail.com> <CA+hcxJQs_t2u5PWiJNzJO1LPdH3HAh21VoB63w5pOdWk0+ih1Q@mail.gmail.com>
 <20160820162713.GA5997@gmail.com> <CA+hcxJTwVEJz5__s6pqivUN61X0xCccKHJ=0_o+1g8+Zu+wkDQ@mail.gmail.com>
 <CA+aFP1CqjyTVpzJNLiyuEg8ydOh_vXjF2ESFjwqESY6O7NhVfA@mail.gmail.com>
 <CA+hcxJQ1RBKbHam8tq2KL=pphLEmtvvacjD1qUvvpqs8NgkCcA@mail.gmail.com>
 <CA+hcxJQ80g_aROrb0+AVaXij1w_pqwRCxC+cHF7j+gXfGyW=Rw@mail.gmail.com>
 <CA+aFP1Dkv_vMMxfnyOE3MfaFP4CV=Z0atT-=bDTjSrRx-quNSw@mail.gmail.com>
 <CA+hcxJTxfT1BO5uuXARsUo8oyHwQxJgymzUTAM8KV1=ciJG20w@mail.gmail.com>
 <CA+aFP1BY67WbVWT-Wb3fHsS_-jUJBJ4FM3NO3VsqFO9+iRGNRg@mail.gmail.com>
 <CA+hcxJRbmnfUeZbnCkvZf52-0H_Du0tGeFb=h_GJryabv0Ng8A@mail.gmail.com>
 <CA+hcxJRptWbrh5R5v5s1YjD-1wuDLUmbGoF6+J=sv+BnrnAzWg@mail.gmail.com>
 <CA+hcxJROQ-xkxNpn5-SZo5abShntVu_mSUhX7ZwmCGuM+6PLVg@mail.gmail.com>
 <CA+aFP1A9-XcxZK---L8iYLVgKUR2ULzHrAVp9=fGbrDaQd3Zyw@mail.gmail.com>
 <CA+hcxJSQdxjxjeVy47AWMJ_-bVRh9NjcHr0h-FkHkJgymCrfUw@mail.gmail.com> <CA+hcxJQm4Z+ODFZbf_4Z9uNOez+amgA1bxLcAQtM5HVo7Qq_pw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33297 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934703AbcIPRhy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2016 13:37:54 -0400
Received: by mail-pf0-f173.google.com with SMTP id 21so18594279pfy.0
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2016 10:37:54 -0700 (PDT)
In-Reply-To: <CA+hcxJQm4Z+ODFZbf_4Z9uNOez+amgA1bxLcAQtM5HVo7Qq_pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Thu, Sep 15, 2016 at 7:17 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> if (struct_v >= 5) {
>       ::decode(snapshot_namespace, p);
>     } else {
>       snapshot_namespace = cls::rbd::UserSnapshotNamespace();
>     }
>
> then code for ::encode function of cls_rbd_snap would change accordingly:
>
> instead of
>
> boost::apply_visitor(cls::rbd::EncodeSnapshotTypeVisitor(bl),
> snapshot_namespace);
>
> I would do:
> ::encode(snapshot_namespace, bl);


+1 -- looks good to me

-- 
Jason
