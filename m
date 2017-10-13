From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: mds client reconnect
Date: Fri, 13 Oct 2017 22:38:04 +0800
Message-ID: <CAEYCsVJryo8Q9x4U4_4iK2QB-W1a6zvKS4x0pJ77QOO9Q1Ng1Q@mail.gmail.com>
References: <CAEYCsVL1MxuYKf3vVN+UQchgaj=X7vxjZ0PfD2Oqsz2To2smRg@mail.gmail.com>
 <CAEYCsVL+_DanFXSCGLxY+WUq2gZoRi8N1D8maFeHsCr5ndOaCA@mail.gmail.com> <CAAM7YAnxQcaBHU=KgZhU9UM-=zksW-h206q2fuzHoM_kBcYsMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:56637 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdJMOiF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Oct 2017 10:38:05 -0400
Received: by mail-it0-f52.google.com with SMTP id g18so10812088itg.5
        for <ceph-devel@vger.kernel.org>; Fri, 13 Oct 2017 07:38:05 -0700 (PDT)
In-Reply-To: <CAAM7YAnxQcaBHU=KgZhU9UM-=zksW-h206q2fuzHoM_kBcYsMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Zheng,
    Thanks for the input. So we dont client to reconnect due to dirty
metadata?  Does client drop dirty data(page cached data) when
reconnect get denied and try tro re-open session?

     And would you mind pointing the commit/kernel version considered
recent enough with re-open session?  We are on CentOS 7.3
(3.10.0-514.21.2.el7.x86_64) but seems not the behavior.


Xiaoxi

2017-10-13 21:59 GMT+08:00 Yan, Zheng <ukernel@gmail.com>:
> On Fri, Oct 13, 2017 at 2:10 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>>
>> resend with plain txt
>>
>> 2017-10-13 10:56 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
>> > Hi,
>> >
>> >     We sometimes seen client (fs kernel) get evicted by MDS and try to
>> > reconnect,  even we set  mds_session_blacklist_on_evict = True, client still
>> > cannot reconnect due to below code:
>> >
>> >  if (!mds->is_reconnect() && mds->get_want_state() ==
>> > CEPH_MDS_STATE_RECONNECT) {
>> >     dout(10) << " we're almost in reconnect state (mdsmap delivery race?);
>> > waiting" << dendl;
>> >     mds->wait_for_reconnect(new C_MDS_RetryMessage(mds, m));
>> >     return;
>> >   }
>> >
>> >      Could someone share any insight on why MDS only accept reconnect in
>> > reconnect state? and how, if the client is get evicted , can automatically
>> > recovered? note that remount is usually impossible as umount will always
>> > hang(due to cannot talk to mds).
>> >
>
> If reconnect get denied, unflushed dirty metadata on client get lost.
>
> If mds_session_blacklist_on_evict is set to FALSE, recent version kernel client
> should re-open session automatically after reconnect get denied. For
> fuse client,
> client_reconnect_stale need to be set to true.
>
> FYI: 'umount -f' works for evicted client.
>
>
>
>>
>> >
>> >
>> > Xiaoxi
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
