From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Fixed URL for latest branch shaman build?
Date: Mon, 27 Feb 2017 11:13:57 -0700
Message-ID: <CALqRxCxv31_=CnomH_eDTdjBuz4Vi5JUE23DnLA5LQyz6xGfTg@mail.gmail.com>
References: <CABZ+qqk+ni5ACoRaRqTd75G77sDMvXnzuSQT7pwyiM8z0tsnMQ@mail.gmail.com>
 <CAEPMp+7VMR8VCUs5hN+109wRKy16x7L_=W2dTY7Q50rdgVnwxQ@mail.gmail.com> <CABZ+qqmcyQ_kJZP9XJiaW26eiQCZN4sfJwZXHPP9qBsVgY9h_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33238 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdB0SXL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 13:23:11 -0500
Received: by mail-ua0-f169.google.com with SMTP id e4so31725734uae.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 10:22:38 -0800 (PST)
In-Reply-To: <CABZ+qqmcyQ_kJZP9XJiaW26eiQCZN4sfJwZXHPP9qBsVgY9h_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Andrew Schoen <aschoen@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

Dan if you have ideas for how we could best expose this in the UI,
please comment in https://github.com/ceph/shaman/issues/88 !

- Ken

On Mon, Feb 27, 2017 at 9:42 AM, Dan van der Ster <dan@vanderster.com> wrote:
> On Mon, Feb 27, 2017 at 5:32 PM, Andrew Schoen <aschoen@redhat.com> wrote:
>> On Mon, Feb 27, 2017 at 8:21 AM, Dan van der Ster <dan@vanderster.com> wrote:
>>> Hi all,
>>>
>>> tl;dr: Is there a fixed URL which points to the latest jewel build on shaman?
>>
>> There is, but it doesn't work exactly like how this has worked in the
>> past with the gitbuilders. The new system uses multiple repo builder
>> nodes (chacra) and reports those back to shaman.ceph.com. Because of
>> this, the latest repo for jewel might not always exist on the same
>> chacra node.
>>
>> We've setup an API endpoint on shaman.ceph.com that will redirect you
>> to a repo file definition for the 'latest' built repo of your choice.
>>
>> For example, this url will always redirect to an endpoint that will
>> print out plain text that looks like either a deb or rpm repo.
>>
>> $ curl -L https://shaman.ceph.com/api/repos/ceph/jewel/latest/centos/7/repo/
>> [ceph]
>> name=ceph packages for \$basearch
>> baseurl=https://1.chacra.ceph.com/r/ceph/jewel/ac3ba2adcd21ac011ad556ac4506623e61fbe696/centos/7/flavors/default/\$basearch
>> enabled=1
>> gpgcheck=0
>> type=rpm-md
>>
>> [ceph-noarch]
>> name=ceph noarch packages
>> baseurl=https://1.chacra.ceph.com/r/ceph/jewel/ac3ba2adcd21ac011ad556ac4506623e61fbe696/centos/7/flavors/default/noarch
>> enabled=1
>> gpgcheck=0
>> type=rpm-md
>>
>> [ceph-source]
>> name=ceph source packages
>> baseurl=https://1.chacra.ceph.com/r/ceph/jewel/ac3ba2adcd21ac011ad556ac4506623e61fbe696/centos/7/flavors/default/SRPMS
>> enabled=1
>> gpgcheck=0
>> type=rpm-md
>>
>> You can modify that url to change the branch, release, distro and
>> distro version values for the repo you want. Using 'latest' in the
>> sha1 position will always give you the latest sha1 built that shaman
>> knows about.
>>
>> I realize this is a bit more work for any CI system that used to pull
>> down the latest from gitbuilder, but it's the best we have currently
>> to deal with a variable amount of chacra builders for these repos.
>
> Thanks -- this should work for us.
>
> Is there a way to be specific about which flavor? We don't want the
> notcmalloc jewel builds, for example.
>
> --
> Dan
>
>
>>
>> Thanks,
>> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
