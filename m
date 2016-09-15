From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Snapshots of consistency groups
Date: Thu, 15 Sep 2016 16:17:52 -0700
Message-ID: <CA+hcxJQm4Z+ODFZbf_4Z9uNOez+amgA1bxLcAQtM5HVo7Qq_pw@mail.gmail.com>
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
 <CA+aFP1A9-XcxZK---L8iYLVgKUR2ULzHrAVp9=fGbrDaQd3Zyw@mail.gmail.com> <CA+hcxJSQdxjxjeVy47AWMJ_-bVRh9NjcHr0h-FkHkJgymCrfUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33679 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbcIOXRy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 19:17:54 -0400
Received: by mail-vk0-f50.google.com with SMTP id 192so2806706vkl.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 16:17:54 -0700 (PDT)
In-Reply-To: <CA+hcxJSQdxjxjeVy47AWMJ_-bVRh9NjcHr0h-FkHkJgymCrfUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

Hi Jason,

I have a question about implementation of snapshot namespaces in cls_rbd.

What if I implement encode and decode functions for SnapshotNamespace
types as follows:

inline void encode(const SnapshotNamespace &c, bufferlist &bl,
uint64_t features=0)
{
  ENCODE_DUMP_PRE();
  boost::apply_visitor(EncodeSnapshotTypeVisitor(bl), c);
  ENCODE_DUMP_POST(SnapshotNamespace);
}

inline void decode(SnapshotNamespace &c, bufferlist::iterator &p)
{
  uint32_t snap_type;
  ::decode(snap_type, p);
  switch (snap_type) {
    case cls::rbd::SNAPSHOT_NAMESPACE_TYPE_USER:
      c = UserSnapshotNamespace();
      break;
    case cls::rbd::SNAPSHOT_NAMESPACE_TYPE_GROUP:
      c = GroupSnapshotNamespace();
      break;
    default:
      c = UnknownSnapshotNamespace();
      break;
  }
  boost::apply_visitor(DecodeSnapshotTypeVisitor(p), c);
}

https://github.com/VictorDenisov/ceph/blob/consistency_groups_namespaces/src/cls/rbd/cls_rbd_types.h#L314

and then instead of


if (struct_v >= 5) {
      uint32_t snap_type;
      ::decode(snap_type, p);
      snapshot_namespace_type =
static_cast<cls::rbd::SnapshotNamespaceType>(snap_type);
      switch (snap_type) {
        case cls::rbd::SNAPSHOT_NAMESPACE_TYPE_USER:
          snapshot_namespace = cls::rbd::UserSnapshotNamespace();
          break;
        case cls::rbd::SNAPSHOT_NAMESPACE_TYPE_GROUP:
          snapshot_namespace = cls::rbd::GroupSnapshotNamespace();
          break;
        default:
          snapshot_namespace = cls::rbd::UnknownSnapshotNamespace();
          break;
      }
      boost::apply_visitor(cls::rbd::DecodeSnapshotTypeVisitor(p),
snapshot_namespace);
    } else {
      snapshot_namespace = cls::rbd::UserSnapshotNamespace();
    }


in cls_rbd_snap decoding I would write just:

if (struct_v >= 5) {
      ::decode(snapshot_namespace, p);
    } else {
      snapshot_namespace = cls::rbd::UserSnapshotNamespace();
    }

then code for ::encode function of cls_rbd_snap would change accordingly:

instead of

boost::apply_visitor(cls::rbd::EncodeSnapshotTypeVisitor(bl),
snapshot_namespace);

I would do:
::encode(snapshot_namespace, bl);

The reason I would like to have encode and decode for
SnapshotNamespace implemented like this is because when I implement
get_snap_namespace method in cls_rbd.cc it's very convenient to have
conventional encode and decode functions. get_snap_namespace has to
serialize and deserialize results.

https://github.com/VictorDenisov/ceph/blob/consistency_groups_namespaces/src/cls/rbd/cls_rbd.cc#L1492


What do you think?

Thanks,
V.

On Tue, Sep 13, 2016 at 4:41 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> Published a pull request for extracting Group.cc
>
> https://github.com/ceph/ceph/pull/11070
>
> Please review.
>
>
> On Tue, Sep 13, 2016 at 5:33 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>> On Mon, Sep 12, 2016 at 7:09 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>> I also think, probably, moving existing group api to Group.cc can be
>>> done in a separate pull request.
>>
>> Agreed -- no worries.
>>
>>> On Mon, Sep 12, 2016 at 4:06 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> Another quick question.
>>>> Do you think it makes sense to introduce snapshot namespaces in a pull
>>>> request and review it first?
>>>> It looks like a self sufficient change that we can merge before
>>>> introducing snapshots.
>>
>> Yes, I think that would be a good idea to simplify the PR and get it
>> merged potentially quicker.
>>
>> --
>> Jason
